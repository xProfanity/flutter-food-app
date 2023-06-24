import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.home_outlined,
              size: 30,
            ),
          ),
          label: 'Home',
          backgroundColor: const Color(0xFFd79914),
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_bag_outlined,
              size: 30,
            ),
          ),
          label: "Shopping Bag",
          backgroundColor: const Color(0xFFd79914),
        )
      ],
    );
  }
}
