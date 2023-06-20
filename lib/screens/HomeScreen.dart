import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/user.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('${user?.username!}'),
        actions: [
          Center(
            child: Container(
              child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(2.0))),
                child: const Icon(Icons.logout),
                onPressed: () => _auth.signOut(),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: const Text('Welcome!'),
      ),
    );
  }
}
