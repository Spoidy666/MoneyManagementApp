import 'package:flutter/material.dart';
import 'package:moneyapp/db/category_db.dart';
import 'package:moneyapp/models/category_model.dart';
import 'package:moneyapp/pages/home/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializedbCatogory();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Homepage(),
    );
  }
}
