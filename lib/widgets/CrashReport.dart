import 'package:flutter/material.dart';

class CrashReport extends StatelessWidget {
  final message;

  const CrashReport(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/pizza_sliced.gif'),
            const SizedBox(
              height: 40,
            ),
            Text(
              message,
              style: const TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
