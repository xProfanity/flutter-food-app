import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeScreen extends StatelessWidget {
  const StripeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16),
          child: CardFormField(
            controller: CardFormEditController(),
          )),
    );
  }
}
