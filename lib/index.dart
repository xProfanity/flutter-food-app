import 'package:flutter/material.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/screens/AuthScreen.dart';
import 'package:foodapp/screens/HomeScreen.dart';
import 'package:provider/provider.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);

    // ignore: unnecessary_null_comparison
    return user == null ? const AuthScreen() : const HomeScreen();
  }
}
