import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remainder_app/Database/database.dart';
import 'package:remainder_app/Provider/notesProvider.dart';
import 'package:remainder_app/Screens/splashScreen.dart';

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
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
