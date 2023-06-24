import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/Dashboard.dart';
import 'package:foodapp/widgets/CrashReport.dart';
import 'package:foodapp/widgets/Loader.dart';

class DashboardLoader extends StatelessWidget {
  final uid;

  DashboardLoader(this.uid);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _user =
        FirebaseFirestore.instance.collection('users');

    return FutureBuilder<QuerySnapshot>(
        future: _user.where('userId', isEqualTo: uid).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print('snapshot $snapshot');
          if (snapshot.hasError) {
            return CrashReport('👻 Something went wrong, lol');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!.docs.map((item) {
              return item.data();
            });
            return Dashboard(data.toList());
          }

          return Loader('Loading 💨');
        });
  }
}
