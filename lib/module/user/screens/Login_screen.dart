import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/module/user/cubit/user_cubit.dart';
import 'package:ecommerce_app/module/user/models/usermodel.dart';
import 'package:ecommerce_app/module/user/screens/signup.dart';
import 'package:ecommerce_app/module/user/services/oauth/email_pass_auth.dart';
//import 'package:ecommerce_app/module/user/services/oauth/google_oauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/widgets/textbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'nav_bar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true; // for password visibility
  bool _isloading = false;
  final _auth = AuthService();

  Future<void> _Login(context) async {
    setState(() {
      _isloading = true;
    });
    try {
      final user = await _auth.loginUserWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      if (user != null) {
        await _setupDatabase();
        setState(() {
          _isloading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BottomNavBar()),
        );
      } else {
        Fluttertoast.showToast(msg: "Invalid email or password");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      } else {
        Fluttertoast.showToast(msg: "An unknown error occurred.");
      }
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }

  Future<void> _login(context) async {
    setState(() {
      _isloading = true;
    });
    await BlocProvider.of<UserCubit>(context).login();
    setState(() {
      _isloading = false;
    });
    _setupDatabase();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BottomNavBar()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Image.network(
                        "https://jtiventures.se/wp-content/uploads/estore-logo-blue.png",
                        width: 300),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 40,
                            color: Color.fromARGB(255, 156, 155, 154)
                            //fontWeight: FontWeight.bold,
                            ),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 15), // add some space
                    Textbox(
                      'Enter your email',
                      Icons.email,
                      false,
                      _emailController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15), // add some space
                    Textbox(
                      'Enter your password',
                      Icons.lock,
                      _obscureText,
                      _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
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
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24), // add some space
                    ElevatedButton(
                      onPressed: () {
                        // Add your login logic here
                        // For example:
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          _Login(context);
                          // Login logic
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill in all fields')),
                          );
                        }
                      },
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.openSans(
                            color: Colors.grey.shade900,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()),
                            );
                          },
                          child: Text(
                            "Signup",
                            style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 24), // add some space
                    const Text(
                      "OR",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 24), // add some space
                    SignInButton(
                      Buttons.googleDark,
                      onPressed: () async {
                        //Oauth oauth = Oauth();
                        _login(context);

                        // Add your Google login logic here
                      },
                    ),
                    _isloading
                        ? const Center(
                            child: const CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : Container(),
                    // Or login with google
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBar()),
      );

  // Future<void> _setupDatabase() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final usercollection = FirebaseFirestore.instance.collection("users");
  //   String id = auth.currentUser!.uid;
  //   final userDoc = await usercollection.doc(id).get();
  //   if (userDoc.exists) {
  //     if (userDoc.data()!['email'] == null ||
  //         userDoc.data()!['username'] == null) {
  //       _createData(UserModel(
  //         username: auth.currentUser!.displayName,
  //         email: auth.currentUser!.email,
  //       ));
  //     }
  //     Navigator.pushReplacement(
  //       // ignore: use_build_context_synchronously
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const BottomNavBar(),
  //       ),
  //     );
  //   }
  // } else {
  //   _createData(UserModel(
  //     username: auth.currentUser!.displayName,
  //     email: auth.currentUser!.email,
  //   ));
  // }
}

Future<void> _setupDatabase() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final usercollection = FirebaseFirestore.instance.collection("users");
  String id = auth.currentUser!.uid;
  final userDoc = await usercollection.doc(id).get();

  if (userDoc.exists) {
    // Update the user document with the current user's email and username
    usercollection.doc(id).update({
      'email': auth.currentUser!.email,
      'username': auth.currentUser!.displayName,
    });
  } else {
    // Create a new user document with the current user's email and username
    _createData(UserModel(
      username: auth.currentUser!.displayName,
      email: auth.currentUser!.email,
    ));
  }
}

void _createData(UserModel userModel) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final usercollection = FirebaseFirestore.instance.collection("users");
  String id = auth.currentUser!.uid;

  final newUser = UserModel(
    email: userModel.email,
    username: userModel.username,
  ).toJson();

  usercollection.doc(id).set(newUser);
}
