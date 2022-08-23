import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box mealBox = Hive.box("meals");
          return   Container(
              child: Text(mealBox.values.toString()));
  }
}
