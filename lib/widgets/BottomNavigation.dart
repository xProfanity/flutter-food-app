import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int cart;

  BottomNavigation(this.cart);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    print(cart);
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
          icon: badges.Badge(
            badgeAnimation: const badges.BadgeAnimation.scale(
                animationDuration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut),
            badgeStyle: const badges.BadgeStyle(badgeColor: Color(0xFFd79914)),
            position: badges.BadgePosition.custom(end: 4),
            badgeContent: Text(
              '$cart',
              style: const TextStyle(color: Colors.white),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 30,
              ),
            ),
          ),
          label: "Shopping Bag",
          backgroundColor: const Color(0xFFd79914),
        )
      ],
    );
  }
}
