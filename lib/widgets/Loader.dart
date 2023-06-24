import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final message;
  const Loader(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/pizza_spinning.gif'),
            const SizedBox(
              height: 40,
            ),
            Text(message)
          ],
        ),
      ),
    );
  }
}
