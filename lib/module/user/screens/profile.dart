import 'dart:math';

import 'package:ecommerce_app/module/user/models/usermodel.dart';
import 'package:ecommerce_app/module/user/screens/Login_screen.dart';
import 'package:ecommerce_app/module/user/screens/helpcenter_screen.dart';
import 'package:ecommerce_app/module/user/screens/orderdetails.dart';
import 'package:ecommerce_app/module/user/screens/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  //late Color _randomColor;

  @override
  void initState() {
    super.initState();
    _getUser().then((user) {
      setState(() {
        _user = user;
      });
    });
  }

  Future<User> _getUser() async {
    return _user = _auth.currentUser!;
  }

  Color _randomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: const Color.fromARGB(255, 122, 121, 120)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // BlocBuilder<UserCubit, UserState>(
              //   builder: (_, userstate) {
              //     return Column(
              //       children: [
              //         Container(
              //           margin: const EdgeInsets.only(top: 20),
              //           child: CircleAvatar(
              //             radius: 50,
              //             backgroundImage: NetworkImage(userstate.image),
              //           ),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.only(top: 10),
              //           child: Text(
              //             userstate.name,
              //             style: const TextStyle(
              //                 fontSize: 24, fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.only(top: 10),
              //           child: Text(
              //             userstate.email,
              //             style: TextStyle(fontSize: 16),
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // ),
              FutureBuilder(
                future: Utils.fetchUserData(id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          // Profile header
                          Container(
                            height: 200,
                            decoration: const BoxDecoration(
                              //color: Color.fromARGB(255, 197, 183, 173),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: _user.photoURL != null
                                      ? NetworkImage(
                                          _user.photoURL!,
                                        )
                                      : const NetworkImage(
                                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                                  backgroundColor: _user.photoURL == null
                                      ? _randomColor()
                                      : Colors.white,
                                  // child: _user.photoURL == null
                                  //     ? Text(
                                  //         _user.displayName![0].toUpperCase(),
                                  //         style: const TextStyle(
                                  //           fontSize: 40,
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.white,
                                  //         ),
                                  //       )
                                  //     : null,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  snapshot.data?.get('username') ?? '',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _user.email ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text('No user data');
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 163, 163, 161),
                    ),
                    ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: const Text(
                        'Orders',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrdersDetails()));
                      },
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 163, 163, 161),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen()),
                        );
                      },
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 163, 163, 161),
                    ),
                    ListTile(
                      leading: const Icon(Icons.help_center),
                      title: const Text(
                        'Help Center',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HelpCenterScreen()),
                        );
                      },
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 163, 163, 161),
                    ),
                    ListTile(
                      leading: const Icon(Icons.manage_accounts),
                      title: const Text(
                        'Manage Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {},
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromARGB(255, 163, 163, 161),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
