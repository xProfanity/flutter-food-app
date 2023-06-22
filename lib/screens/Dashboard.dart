import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/menu.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/screens/dashboard/menu.dart';
import 'package:foodapp/screens/dashboard/shoppingCart.dart';
import 'package:foodapp/services/Firebase.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isMenu = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);

    return StreamProvider<List<FoodMenu>?>.value(
        value: Firestore().menu,
        initialData: null,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: FittedBox(
              fit: BoxFit.cover,
              child: Container(
                  height: 40,
                  width: 40,
                  child: Image.asset("assets/favicon.ico")),
            ),
            centerTitle: true,
            leadingWidth: 60,
            leading: Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  child: CircleAvatar(
                    radius: 20,
                    child: ClipOval(
                      child: Image.network(
                        user?.profilePic,
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
              ],
            ),
            actions: [
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu_rounded,
                        color: Colors.black,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: isMenu ? const Menu() : const ShoppingCart(),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    setState(() {
                      isMenu = true;
                    });
                  },
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
                  onPressed: () {
                    setState(() {
                      isMenu = false;
                    });
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 30,
                  ),
                ),
                label: "Shopping Bag",
                backgroundColor: const Color(0xFFd79914),
              )
            ],
          ),
        ));
  }
}
