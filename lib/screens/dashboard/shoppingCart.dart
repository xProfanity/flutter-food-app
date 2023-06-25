import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  final cart;
  const ShoppingCart(this.cart);

  @override
  _ShoppingCart createState() => _ShoppingCart();
}

class _ShoppingCart extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    return Center(
        child: Container(
      child: ListView.builder(
        itemCount: cart?.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cart[index]?['name']),
            leading: Icon(Icons.shopping_basket),
            subtitle: Text("TotalPrice: \$${cart[index]?['price']}"),
            trailing:
                IconButton(onPressed: () {}, icon: Icon(Icons.delete_rounded)),
          );
        },
      ),
    ));
  }
}
