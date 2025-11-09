import 'package:flutter/material.dart';
import 'package:techstore_app/core/constants/app_colors.dart';
import 'package:gap/gap.dart';

class CartItems extends StatefulWidget {
  const CartItems({super.key});

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  List<Map<String, dynamic>> cartProducts = [
    {
      'image': 'img/Headphones.png',
      'title': 'Headphone',
      'description': 'Wireless over-ear with noise cancellation',
      'price': 199.0,
      'quantity': 1,
    },
    {
      'image': 'img/Powerbank.png',
      'title': 'Powerbank',
      'description': '10,000mAh fast charging',
      'price': 63.0,
      'quantity': 1,
    },
    {
      'image': 'img/JoyStick.png',
      'title': 'JoyStick',
      'description': 'Bluetooth controller for gaming',
      'price': 97.0,
      'quantity': 1,
    },
  ];

  String discountCode = '';
  double discountAmount = 0;

  void applyDiscount() {
    if (discountCode == 'HASH10') {
      setState(() {
        discountAmount = 0.1; 
      });
    } else {
      setState(() {
        discountAmount = 0;
      });
    }
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartProducts) {
      total += item['price'] * item['quantity'];
    }
    return total * (1 - discountAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: cartProducts.length,
            separatorBuilder: (_, __) => Divider(color: Colors.grey.shade300),
            itemBuilder: (context, index) {
              final product = cartProducts[index];
              return Dismissible(
                key: Key(product['title']),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  setState(() {
                    cartProducts.removeAt(index);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Image.asset(product['image'], width: 80, height: 80),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product['title'],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(product['description'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey)),
                            const SizedBox(height: 8),
                            Text('SAR ${product['price']}',
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              setState(() {
                                product['quantity']++;
                              });
                            },
                          ),
                          Text('${product['quantity']}'),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                if (product['quantity'] > 1) {
                                  product['quantity']--;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Gap(20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => discountCode = value,
                  decoration: InputDecoration(
                    hintText: 'Enter discount code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: applyDiscount,
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                  ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total items: ${cartProducts.length}',
                  style: const TextStyle(fontSize: 14)),
              Text('Total: SAR ${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
               Navigator.pushNamed(context, '/checkout');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: AppColors.primary,
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}