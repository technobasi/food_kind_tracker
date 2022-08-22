import 'package:flutter/material.dart';
import 'package:food_kind_tracker/widgets/InputWidget.dart';
import 'package:food_kind_tracker/widgets/ResultWidget.dart';

class MainScreen extends StatefulWidget {
  static String routeName = 'input';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _subscreens = [InputWidget(), ResultWidget()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _subscreens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.input_rounded),
              label: "Erfassen"),
          BottomNavigationBarItem(icon: Icon(Icons.list_rounded),
              label: "Auswertung",
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
