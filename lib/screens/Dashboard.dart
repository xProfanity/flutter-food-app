import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/menu.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/screens/ProfileScreen.dart';
import 'package:foodapp/screens/dashboard/menu.dart';
import 'package:foodapp/screens/dashboard/shoppingCart.dart';
import 'package:foodapp/widgets/AppLogo.dart';
import 'package:foodapp/widgets/BottomNavigation.dart';
import 'package:foodapp/widgets/MenuButton.dart';
import 'package:foodapp/widgets/MenuContainer.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  final data;

  Dashboard(this.data);

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final logo = const AppLogo();
  final menuButton = MenuButton();
  final menuContainer = MenuContainer();

  bool isMenu = true;

  int count = 0;
  var cart = [];

  @override
  Widget build(BuildContext context) {
    final foodMenu = Provider.of<List<FoodMenu>?>(context);
    final user = widget.data?[0];
    final cartCount = user['cart'].length;
    setState(() {
      cart = user['cart'];
    });
    void updateCartCount(newCartCount) {
      count = newCartCount;
      cart = user['cart'];
      setState(() {});
    }

    if (count == 0) {
      setState(() {
        count = cartCount;
      });
    }

    return Scaffold(
        endDrawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF232323)),
                accountName: Text(user?['username']),
                accountEmail: Text(user?['email']),
                currentAccountPicture: CircleAvatar(
                    radius: 40,
                    child: ClipOval(
                        child: Image.network(
                      user?['profilePic'],
                      height: 80,
                      width: 80,
                    ))),
              ),
              SizedBox(
                height: 25,
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  _auth.signOut();
                  UserData(null, null, null, null);
                },
                leading: Icon(Icons.logout),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: logo.build(context),
          centerTitle: true,
          leadingWidth: 60,
          leading: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Profile()));
                  },
                  child: CircleAvatar(
                    radius: 20,
                    child: ClipOval(
                      child: Image.network(
                        user?['profilePic'],
                        height: 40,
                        width: 40,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Builder(builder: (BuildContext context) {
              return IconButton(
                  padding: EdgeInsets.only(right: 8),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    size: 40,
                    color: Colors.black,
                  ));
            })
          ],
        ),
        body: Stack(
          children: [
            isMenu
                ? Menu(updateCartCount, user['docId'], cart, count, foodMenu)
                : const ShoppingCart(),
          ],
        ),
        bottomNavigationBar: BottomNavigation(count));
  }
}
