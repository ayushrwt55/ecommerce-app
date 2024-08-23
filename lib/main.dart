import 'dart:io';

import 'package:ecommerce_app/module/shared/services/GPS/cubit/Location_cubit.dart';
import 'package:ecommerce_app/module/user/cubit/user_cubit.dart';
import 'package:ecommerce_app/module/user/screens/splash.dart';
import 'package:ecommerce_app/module/user/services/Provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'module/user/services/Provider/add_to_cart_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDTQpz0sROCEQdSydZyBR1Wl6dzAv-Ving",
            authDomain: "ecommerceapp-2bddc.firebaseapp.com",
            projectId: "ecommerceapp-2bddc",
            storageBucket: "ecommerceapp-2bddc.appspot.com",
            messagingSenderId: "172740354558",
            appId: "1:172740354558:android:653215326820d1220920af",
            measurementId: "G-6DF96MZLQ6"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => UserCubit(),
            ),
            BlocProvider(create: (_) => LocationCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.mulishTextTheme(),
            ),
            home: SplashScreen(),
          ),
        ),
      );
}
