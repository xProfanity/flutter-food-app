import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/menu.dart';
import 'package:foodapp/screens/Dashboard.dart';
import 'package:foodapp/services/Firebase.dart';
import 'package:foodapp/store/ShoppingBag.dart';
import 'package:foodapp/widgets/CrashReport.dart';
import 'package:foodapp/widgets/Loader.dart';
import 'package:provider/provider.dart';

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
              Map<String, dynamic> data = item.data() as Map<String, dynamic>;
              final docId = item.id;

              return {...data, 'docId': docId};
            });

            Stream<Map<String, dynamic>> userData() {
              return Stream.fromIterable(data);
            }

            ShoppingBag(
                data.toList()[0]['cart'], data.toList()[0]['cart'].length);
            return StreamProvider<List<FoodMenu>?>.value(
                value: Firestore().menu,
                initialData: null,
                child: Dashboard(data.toList()));
          }

          return const Loader('Loading 💨');
        });
  }
}
