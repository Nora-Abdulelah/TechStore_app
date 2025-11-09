import 'package:flutter/material.dart';
import 'package:techstore_app/features/home/product_card.dart';
import 'package:techstore_app/features/product/product.screen.dart';
import 'package:techstore_app/widgets/costom_navbar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int currentIndex = 2;

  final List<Map<String, dynamic>> favoriteProducts = [
    {
      'imageUrl': 'img/Headphones.png',
      'title': 'Headphones',
      'price': 199,
      'rating': 4.8,
      'reviews': 245,
    },
    {
      'imageUrl': 'img/Powerbank.png',
      'title': 'Powerbank',
      'price': 63,
      'rating': 4.1,
      'reviews': 73,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text(
                'No favorite products yet.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return Stack(
                  children: [
                    ProtectedCard(
                      imageUrl: product['imageUrl'],
                      title: product['title'],
                      price: product['price'],
                      rating: product['rating'],
                      reviews: product['reviews'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              imageUrl: product['imageUrl'],
                              title: product['title'],
                              price: product['price'],
                              rating: product['rating'],
                              reviews: product['reviews'],
                            ),
                          ),
                        );
                      },
                    ),
                    const Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(Icons.favorite, color: Colors.red, size: 20),
                    ),
                  ],
                );
              },
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
                Navigator.pushReplacementNamed(context, '/cart');
                break;
              case 2:
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