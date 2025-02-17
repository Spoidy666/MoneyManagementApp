import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneyapp/models/category/category_model.dart';
import 'package:moneyapp/pages/home/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter() );
  }
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter() );
  }
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
