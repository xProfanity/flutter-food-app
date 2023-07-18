import 'package:flutter/material.dart';
import 'package:foodapp/screens/StripeScreen.dart';
import 'package:foodapp/services/Firebase.dart';

class ShoppingCart extends StatefulWidget {
  final cart;
  final uid;
  final updateCartCount;
  final count;
  final totalPrice;
  const ShoppingCart(
      this.cart, this.uid, this.updateCartCount, this.count, this.totalPrice);

  @override
  _ShoppingCart createState() => _ShoppingCart();
}

class _ShoppingCart extends State<ShoppingCart> {
  final firestore = Firestore();

  num totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    return Center(
        child: Column(
      children: [
        Container(
          height: 600,
          child: ListView.builder(
            itemCount: cart?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cart[index]?['name']),
                leading: Icon(Icons.shopping_basket),
                subtitle: Text("Price: \$${cart[index]?['price']}"),
                trailing: IconButton(
                    onPressed: () async {
                      widget.updateCartCount(widget.count - 1);
                      await firestore.removeFromShoppingCart(
                          cart[index], widget.uid);
                    },
                    icon: Icon(Icons.delete_rounded)),
              );
            },
          ),
        ),
        Container(
          child: Column(
            children: [
              Container(
                  height: 40,
                  child: Center(
                      child: Text(
                    "Total Price: \$${widget.totalPrice}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ))),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF5433FF))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  StripeScreen()));
                    },
                    child: const Text(
                      "Proceed To Payment",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
