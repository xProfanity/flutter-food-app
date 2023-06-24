import 'package:flutter/material.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/screens/AuthScreen.dart';
import 'package:foodapp/screens/DashboardLoader.dart';
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

    return user == null ? const AuthScreen() : DashboardLoader(user.uid);
  }
}
