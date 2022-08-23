import 'package:flutter/material.dart';
import 'package:food_kind_tracker/color_schemes.g.dart';
import 'package:food_kind_tracker/screens/MainScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("meals");
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
        useMaterial3: true,
        colorScheme: lightColorScheme
      ),
     darkTheme: ThemeData(
       useMaterial3: true,
       colorScheme: darkColorScheme
     ),
     home: const MainScreen()
    );
  }
}
