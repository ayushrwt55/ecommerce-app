import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HotDeals extends StatelessWidget {
  const HotDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: MediaQuery.sizeOf(context).height * 0.04,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.12,
        backgroundColor: Colors.deepOrange,
        title: Padding(
          padding: EdgeInsets.only(left: 3),
          child: Column(
            children: [
              Image.network(
                "https://jtiventures.se/wp-content/uploads/estore-logo-blue.png",
                height: MediaQuery.sizeOf(context).height * 0.05,
              ),
              const SizedBox(height: 15),
              Text(
                'HOT DEALS',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 216, 205),
              Color.fromARGB(255, 240, 240, 240),
            ],
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'EXCLUSIVE OFFERS',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: MediaQuery.sizeOf(context).height * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
            Lottie.network(
              "https://lottie.host/e94902f3-2415-4151-a374-10d81219c9fb/6An9BN8f24.json",
              height: MediaQuery.sizeOf(context).height * 0.2,
            ),
            Column(
              children: [
                Image.asset("assets/slider3.jpg"),
                Image.asset("assets/slider.jpg"),
                Image.asset("assets/image1.png"),
                Image.asset("assets/slider2.jpg"),
                Image.asset("assets/men.jpg"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'MORE DEALS COMING SOON...',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
