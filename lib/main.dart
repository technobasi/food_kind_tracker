import 'package:flutter/material.dart';
import 'package:food_kind_tracker/screens/MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Omnomnom Tracking",
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
     home: const MainScreen()
    );
  }
}
