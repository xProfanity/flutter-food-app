import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/widgets/AppLogo.dart';
import 'package:foodapp/widgets/MenuButton.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final logo = const AppLogo();
  final menuButton = MenuButton();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF232323)),
              accountName: Text(user?.username),
              accountEmail: Text(user?.email),
              currentAccountPicture: CircleAvatar(
                  radius: 40,
                  child: ClipOval(
                      child: Image.network(
                    user?.profilePic,
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
              },
              leading: Icon(Icons.logout),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        leadingWidth: 60,
        leading: Row(
          children: [
            SizedBox(
                child: BackButton(
              color: Colors.black,
              style:
                  ButtonStyle(iconSize: MaterialStateProperty.all<double?>(40)),
            )),
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
      body: Text('Hello'),
    );
  }
}
