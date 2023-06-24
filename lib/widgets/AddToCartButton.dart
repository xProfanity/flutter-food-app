import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final updateCartCount;
  final food;
  final docId;

  AddToCartButton(this.updateCartCount, this.food, this.docId);

  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future addToShoppingBag(food, docId) async {
    final foodData = [
      {'name': food.name, 'photo': food.photoUrl, 'price': food.price}
    ];

    return await _users
        .doc(docId)
        .update({'cart': FieldValue.arrayUnion(foodData)});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final response = await addToShoppingBag(food, docId);

        print('response $response');

        updateCartCount();
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xFFd79914),
        ),
        child: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add to Bag',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              size: 15,
              weight: 51.0,
            )
          ],
        )),
      ),
    );
  }
}
