import 'package:flutter/material.dart';
import 'package:techstore_app/features/Profile/profile_screen.dart';
import 'package:techstore_app/features/checkout/checkout_screen.dart';
import 'package:techstore_app/features/favorite/favorite_screen.dart';
import 'package:techstore_app/features/home/home.screen.dart';
import 'package:techstore_app/features/cart/cart_screen.dart';
import 'package:techstore_app/shared/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashView(),
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
        '/favorite': (context) => const FavoriteScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/checkout': (context) => const CheckoutScreen(),
      },
    );
  }
}