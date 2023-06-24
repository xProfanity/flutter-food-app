import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  MenuButton({Key? key}) : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  final bool containerOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(containerOpened == true ? Icons.close : Icons.menu),
              color: Colors.black,
              iconSize: 40,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
