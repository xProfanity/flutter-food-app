import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int cart;
  final switchDashboard;

  BottomNavigation(this.cart, this.switchDashboard);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    return BottomNavigationBar(
      selectedItemColor: Color(0xFFd79914),
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              setState(() {
                currentIndex = 0;
              });
              widget.switchDashboard(currentIndex);
            },
            icon: const Icon(
              Icons.home_outlined,
              size: 30,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: badges.Badge(
            badgeAnimation: const badges.BadgeAnimation.scale(
                animationDuration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut),
            badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
            position: badges.BadgePosition.custom(end: 4),
            badgeContent: Text(
              '$cart',
              style: const TextStyle(color: Colors.white),
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
                widget.switchDashboard(currentIndex);
              },
              icon: const Icon(
                Icons.shopping_basket,
                size: 30,
              ),
            ),
          ),
          label: "Shopping Bag",
        )
      ],
    );
  }
}
