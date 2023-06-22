import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  _ShoppingCart createState() => _ShoppingCart();
}

class _ShoppingCart extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Text('ShoppingCart'),
      ),
    );
  }
}
