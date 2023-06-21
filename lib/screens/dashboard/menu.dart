import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Menu'),
      ),
    );
  }
}
