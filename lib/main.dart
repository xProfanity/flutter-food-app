import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:foodapp/firebase_options.dart';
import 'package:foodapp/index.dart';
import 'package:foodapp/models/user.dart';
import 'package:foodapp/services/Firebase.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = dotenv.env['STRIPE_API_PUBLISHABLE_KEY'] as String;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData?>.value(
      value: Authentication().user,
      initialData: null,
      child: const MaterialApp(
        title: 'Food App',
        debugShowCheckedModeBanner: false,
        home: Index(),
      ),
    );
  }
}
