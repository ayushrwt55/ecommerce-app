import 'dart:developer';

import 'package:ecommerce_app/module/shared/widgets/textbox.dart';
import 'package:ecommerce_app/module/user/screens/Login_screen.dart';
import 'package:ecommerce_app/module/user/screens/nav_bar_screen.dart';
import 'package:ecommerce_app/module/user/services/oauth/email_pass_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _obscureText = true;
  bool _isValid = true;
  String _errorMessage = '';

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(children: [
              const Text("Signup",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 50,
              ),
              Textbox(
                'Enter your Name',
                Icons.verified_user,
                false,
                _name,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      _isValid = false;
                      _errorMessage = 'Please enter your name';
                    });
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Textbox(
                'Enter your email',
                Icons.email,
                false,
                _email,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    setState(() {
                      _isValid = false;
                      _errorMessage = 'Please enter a valid email';
                    });
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Textbox(
                'Enter your password',
                Icons.lock,
                _obscureText,
                _password,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      _isValid = false;
                      _errorMessage = 'Please enter your password';
                    });
                    return 'Please enter your password';
                  }
                  return null;
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              Textbox(
                'Confirm password',
                Icons.lock,
                _obscureText,
                _confirmPassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      _isValid = false;
                      _errorMessage = 'Please enter your password again';
                    });
                    return 'Please enter your password again';
                  } else if (value != _password.text) {
                    setState(() {
                      _isValid = false;
                      _errorMessage = 'Passwords do not match';
                    });
                    return 'Passwords do not match';
                  }
                  return null;
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: _isValid ? _signup : null,
                  child: const Text(
                    "SignUp",
                    style: TextStyle(fontSize: 18),
                  )),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Already have an account? "),
                InkWell(
                  onTap: () => goToLogin(context),
                  child: const Text("Login",
                      style:
                          TextStyle(color: Color.fromARGB(255, 54, 139, 244))),
                )
              ]),
              _isValid
                  ? Container()
                  : Text(_errorMessage, style: TextStyle(color: Colors.red)),
            ]),
          ),
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );

  _signup() async {
    if (_name.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter your name');
      return;
    }
    if (_email.text.isEmpty || !_email.text.contains('@')) {
      Fluttertoast.showToast(msg: 'Please enter a valid email');
      return;
    }
    if (_password.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter your password');
      return;
    }
    if (_confirmPassword.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter your password again');
      return;
    }
    if (_password.text != _confirmPassword.text) {
      Fluttertoast.showToast(msg: 'Passwords do not match');
      return;
    }
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          _email.text, _password.text);
      if (user != null) {
        log("User Created Succesfully");
        await _checkIfEmailAlreadyRegistered(user);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'The email address is already in use by another account.') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error creating user: ${e.toString()}');
    }
  }

  _addUserToFirestore(User user) async {
    await _firestore.collection('users').doc(user.uid).set({
      'username': _name.text,
      'email': _email.text,
    });
    goToHome(context);
  }

  _checkIfEmailAlreadyRegistered(User user) async {
    final querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: _email.text)
        .get();

    if (querySnapshot.docs.isEmpty) {
      await _addUserToFirestore(user);
      goToHome(context);
    } else {
      Fluttertoast.showToast(
          msg: 'Email already registered with another account.');
    }
  }
}
