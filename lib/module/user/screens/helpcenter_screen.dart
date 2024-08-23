import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenterScreen extends StatefulWidget {
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Help Center',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: const Color.fromARGB(255, 122, 121, 120)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Frequently Asked Questions',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Q: How do I track my order?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'A: You can track your order by logging into your account and clicking on the "Orders" tab.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Q: How do I return or exchange an item?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'A: Please contact our customer service team at [support email] to initiate the return or exchange process.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Q: How do I reset my password?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'A: Click on the "Forgot Password" link on the login page and follow the instructions to reset your password.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              // Contact Us
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'ecommerceAppHelp@gmail.com',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Phone',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '011-5522312',
                        style: TextStyle(fontSize: 18),
                      ),
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
