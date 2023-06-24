import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/ProfileScreen.dart';

class MenuContainer extends StatefulWidget {
  MenuContainer({Key? key}) : super(key: key);

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final List menuItems = ['Home', 'Profile', 'Logout'];

  Widget menuItem(menuItem) {
    print(menuItem);
    return Container(
      width: 300,
      child: Container(
          height: 50,
          width: 400,
          margin:
              EdgeInsets.only(top: menuItem == 'Logout' ? 40 : 10, bottom: 10),
          child: Center(
              child: SizedBox(
            width: 200,
            height: 80,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color(menuItem == 'Logout' ? 0xFF000000 : 0xFFd79914))),
              onPressed: () {
                menuItem == 'Logout'
                    ? _firebaseAuth.signOut()
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Profile()));
              },
              child: Text(
                menuItem,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 150,
      child: Container(
        height: 250,
        width: 500,
        color: Colors.white,
        child: ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, int index) {
              return menuItem(menuItems[index]);
            }),
      ),
    );
  }
}
