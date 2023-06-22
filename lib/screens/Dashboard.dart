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
            title: CircleAvatar(
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
            actions: [
              Center(
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(color: Colors.black)),
                    child: const Icon(Icons.logout, color: Colors.black),
                    onPressed: () => _auth.signOut(),
                  ),
                ),
              )
            ],
          ),
          body: isMenu ? Menu() : ShoppingCart(),
          bottomNavigationBar: Container(
            height: 80,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isMenu = true;
                    });
                  },
                  icon: Icon(
                    Icons.home_outlined,
                    color: isMenu ? Color(0xFFd79914) : Colors.black,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isMenu = false;
                    });
                  },
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    color: !isMenu ? Color(0xFFd79914) : Colors.black,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
