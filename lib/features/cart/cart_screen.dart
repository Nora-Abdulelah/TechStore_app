import 'package:flutter/material.dart';
import 'package:techstore_app/widgets/costom_navbar.dart';
import 'package:techstore_app/features/cart/cart_items.dart'; 

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            'My Cart',
          ),
        ),
      ),

      body: const Padding(
        padding: EdgeInsets.all(16),
        child: CartItems(), 

      ),

      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != currentIndex) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/home');
                break;
              case 1:
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/favorite');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/profile');
                break;
            }
          }
        },
      ),
    );
  }
}