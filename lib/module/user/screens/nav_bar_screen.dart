import 'package:ecommerce_app/module/user/screens/hot_deals.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'cart_screen.dart';
import 'favorite.dart';
import 'home_screen.dart';
import 'profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 2;
  List screens = const [
    Scaffold(
      body: HotDeals(),
    ),
    Favorite(),
    HomeScreen(),
    CartScreen(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        shape: const CircleBorder(),
        backgroundColor: currentIndex == 2
            ? kprimaryColor
            : Color.fromARGB(255, 120, 23, 225),
        child: Icon(
          Icons.home,
          color: Colors.white,
          size: MediaQuery.of(context).size.height * 0.034,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: MediaQuery.of(context).size.height * 0.067,
        color: Color.fromARGB(255, 120, 23, 225),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              icon: Icon(
                Icons.grid_view_outlined,
                size: MediaQuery.of(context).size.height * 0.0335,
                color: currentIndex == 0
                    ? kprimaryColor
                    : const Color.fromARGB(255, 251, 251, 251),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              icon: Icon(
                Icons.favorite_border,
                size: MediaQuery.of(context).size.height * 0.0335,
                color: currentIndex == 1
                    ? kprimaryColor
                    : const Color.fromARGB(255, 244, 244, 244),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: MediaQuery.of(context).size.height * 0.0335,
                color: currentIndex == 3 ? kprimaryColor : Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 4;
                });
              },
              icon: Icon(
                Icons.person,
                size: MediaQuery.of(context).size.height * 0.0335,
                color: currentIndex == 4 ? kprimaryColor : Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
