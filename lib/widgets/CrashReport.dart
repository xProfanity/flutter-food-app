import 'package:flutter/material.dart';

class CrashReport extends StatelessWidget {
  final message;
  final includeScaffold;

  const CrashReport(this.message, this.includeScaffold);

  @override
  Widget build(BuildContext context) {
    return includeScaffold
        ? Scaffold(body: _contents())
        : Container(
            child: _contents(),
          );
  }

  Widget _contents() {
    return Center(
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
    );
  }
}
