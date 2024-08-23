import 'dart:math';

import 'package:ecommerce_app/module/shared/services/GPS/cubit/Location_cubit.dart';
import 'package:ecommerce_app/module/shared/services/GPS/cubit/Location_state.dart';
import 'package:ecommerce_app/module/shared/services/GPS/gps.dart';
import 'package:ecommerce_app/module/user/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../constants.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import '../models/product_model.dart';
import '../screens/detail_screen.dart';
import '../services/Provider/favorite_provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // BlocBuilder<UserCubit, UserState>(builder: (_, userstate) {
              //   return Row(
              //     children: [
              //       CircleAvatar(
              //         backgroundImage: NetworkImage(
              //           userstate.image,
              //         ),
              //         radius: 30,
              //       ),
              //       const SizedBox(width: 10),
              //       Column(
              //         children: [
              //           const Text("Welcome"),
              //           Text(
              //             userstate.name,
              //             style: GoogleFonts.poppins(fontSize: 20),
              //           ),
              //         ],
              //       )
              //     ],
              //   );
              // }),
              FutureBuilder(
                  future: Utils.fetchUserData(id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: _user.photoURL != null
                                ? NetworkImage(
                                    _user.photoURL!,
                                  )
                                : const NetworkImage(
                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                            backgroundColor: _user.photoURL == null
                                ? _randomColor()
                                : Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              const Text("Welcome"),
                              Text(
                                snapshot.data?.get('username') ?? '',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: kcontentColor,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {},
                iconSize: 20,
                icon: const Icon(Icons.notifications_outlined),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentSlide;
  const ImageSlider({
    super.key,
    required this.currentSlide,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: PageView(
              scrollDirection: Axis.horizontal,
              allowImplicitScrolling: true,
              onPageChanged: onChange,
              physics: const ClampingScrollPhysics(),
              children: [
                Image.asset(
                  "assets/slider.jpg",
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  "assets/image1.png",
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  "assets/slider3.jpg",
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  "assets/slider2.jpg",
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  "assets/men.jpg",
                  fit: BoxFit.fill,
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => AnimatedContainer(
                  duration: const Duration(microseconds: 300),
                  width: currentSlide == index ? 15 : 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentSlide == index
                          ? Colors.black
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(product: product),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kcontentColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Center(
                  child: Hero(
                    tag: product.image,
                    child: Image.asset(
                      product.image,
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "₹ ${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        product.colors.length,
                        (index) => Container(
                          width: 18,
                          height: 18,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: product.colors[index],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
              child: Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: kprimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  provider.toggleFavorite(product);
                },
                child: Icon(
                  provider.isExist(product)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class LocationBar extends StatefulWidget {
  const LocationBar({super.key});

  @override
  State<LocationBar> createState() => _LocationBarState();
}

class _LocationBarState extends State<LocationBar> {
  _getlocation() async {
    Position cord = await getGeoPosition();
    print("Cord ${cord.latitude},${cord.longitude}");
    await getGPSLocation(cord.latitude, cord.longitude);
  }

  void initState() {
    super.initState();
    context.read<LocationCubit>().getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 161, 231, 210),
          borderRadius: BorderRadius.zero,
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: const Row(
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(width: 5),
                  const Text('Deliver to '),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 5),
              child: Row(
                children: [
                  BlocBuilder<UserCubit, UserState>(builder: (_, userstate) {
                    return Text(
                      userstate.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  }),
                  const Text(' - '),
                  BlocBuilder<LocationCubit, LocationState>(
                    builder: (_, locationstate) {
                      return Row(
                        children: [
                          Text(
                            locationstate.suburb,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            locationstate.state,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            locationstate.postCode,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class MySearchBAR extends StatefulWidget {
  const MySearchBAR({super.key});

  @override
  State<MySearchBAR> createState() => _MySearchBARState();
}

class _MySearchBARState extends State<MySearchBAR> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kcontentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.grey,
              size: 30,
            ),
            const SizedBox(width: 10),
            const Flexible(
              flex: 4,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search...", border: InputBorder.none),
              ),
            ),
            Container(
              height: 25,
              width: 1.5,
              color: Colors.grey,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.tune,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
