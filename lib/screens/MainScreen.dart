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
  static const List<Widget> _subscreens = [
    InputWidget(),
    ResultWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(208, 229, 196, 1),
      body: Center(
        child: _subscreens[_selectedIndex]
      ),
/*      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
            setState(() {
            _selectedIndex = index;
            });
    },
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          
        ]
      )
          );
/*          BottomNavigationBarItem(icon: Icon(Icons.input_rounded),
          label: "Erfassen",
          backgroundColor:  Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.list_rounded),
          label: "Auswertung",
              backgroundColor:  Color.fromRGBO(208, 229, 196, 1))
        ],
        currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      )
    );*/
  }
}

