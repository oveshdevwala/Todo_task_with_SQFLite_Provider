import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remainder_app/Database/database.dart';
import 'package:remainder_app/Provider/notesProvider.dart';
import 'package:remainder_app/Screens/homescreen.dart';

void main() {
  runApp(MultiProvider(child: MyApp(), providers: [
    ChangeNotifierProvider(
        create: (_) => TaskProvider(db: DatabaseHelper.instance))
  ]));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
