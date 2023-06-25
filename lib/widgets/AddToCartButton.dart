import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatefulWidget {
  final updateCartCount;
  final food;
  final docId;
  final cart;
  final count;

  AddToCartButton(
      this.updateCartCount, this.count, this.food, this.docId, this.cart);

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future addToShoppingBag(food, docId) async {
    final foodData = [
      {
        'name': food.name,
        'photo': food.photoUrl,
        'price': food.price,
        'quantity': 1,
        'totalPrice': food.price * 1,
        'foodId': food.docId
      }
    ];

    await _users.doc(docId).update({'cart': FieldValue.arrayUnion(foodData)});
  }

  Future removeFromShoppingCart(food, docId) async {
    print('data to delete $food');
    final foodData = [
      {
        'name': food['name'],
        'photo': food['photo'],
        'price': food['price'],
        'quantity': food['quantity'],
        'totalPrice': food['totalPrice'],
        'foodId': food['foodId']
      }
    ];

    await _users.doc(docId).update({'cart': FieldValue.arrayRemove(foodData)});
  }

  var cart = [];
  bool isInCart = false;
  @override
  Widget build(BuildContext context) {
    final cartData = widget.cart;
    final food = widget.food;
    final itemInCart =
        cartData.where((item) => item?['foodId'] == food?.docId).toList();

    if (cart.isEmpty) {
      print('cart eeti $cart');
      setState(() {
        cart = cartData;
      });
      for (var foodItem in cart) {
        if (foodItem?['foodId'] == food?.docId) {
          setState(() {
            isInCart = true;
          });
        }
      }
    }
    print('foodItem here? $itemInCart');

    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            if (!isInCart) {
              widget.updateCartCount(widget.count + 1);
              setState(() {
                isInCart = true;
              });
              await addToShoppingBag(widget.food, widget.docId);
            } else
              print('Already added in cart');
          },
          child: Container(
            width: 100,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(isInCart ? 0xFFCCCCCC : 0xFFd79914),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isInCart ? 'Added to bag' : 'Add to Bag',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  isInCart ? Icons.check : Icons.shopping_bag_outlined,
                  size: 15,
                  weight: 51.0,
                )
              ],
            )),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Visibility(
          visible: isInCart ? true : false,
          child: GestureDetector(
            onTap: () async {
              widget.updateCartCount(widget.count - 1);
              setState(() {
                isInCart = false;
              });
              await removeFromShoppingCart(itemInCart[0], widget.docId);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
              child: Center(
                  child: Icon(
                Icons.delete,
                size: 25,
                weight: 51.0,
                color: Colors.white,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
