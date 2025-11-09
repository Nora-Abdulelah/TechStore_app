import 'package:flutter/material.dart';
import 'package:techstore_app/core/constants/app_colors.dart';
import 'package:techstore_app/features/home/product_card.dart';
import 'package:techstore_app/features/product/product.screen.dart';
import 'package:techstore_app/widgets/costom_navbar.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int currentNavIndex = 0;

  final List<String> categories = ["All", "Product", "Categories", "Devices"];

  final List<Map<String, dynamic>> products = [
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
    {
      'imageUrl': 'img/JoyStick.png',
      'title': 'JoyStick',
      'price': 97,
      'rating': 3.5,
      'reviews': 51,
    },
    {
      'imageUrl': 'img/Speaker.png',
      'title': 'Speakers',
      'price': 103,
      'rating': 4.9,
      'reviews': 35,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentNavIndex,
        onTap: (index) {
          if (index != currentNavIndex) {
            switch (index) {
              case 0:
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/cart');
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                "TechStore",
                style: GoogleFonts.luckiestGuy(
                  fontSize: 29,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello, Nora",
                    style: TextStyle(fontSize: 15, color: AppColors.grey),
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      color: Colors.grey[100],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 28,
                      color: Color.fromARGB(255, 151, 154, 157),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final isSelect = index == selectedIndex;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelect ? Colors.white : Colors.grey,
                          ),
                        ),
                        selected: isSelect,
                        selectedColor: AppColors.primary,
                        backgroundColor: Colors.white,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 17),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProtectedCard(
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}