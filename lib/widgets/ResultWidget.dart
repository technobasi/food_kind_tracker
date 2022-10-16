import 'package:flutter/material.dart';
import 'package:food_kind_tracker/model/MealType.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Box mealBox = Hive.box("meals");
    var dates = daysTilToday();
    List meals = dates.map((e) => mealBox.get(e)).where((element) => element != null).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: Text("Auswertung für das Jahr ${DateTime.now().year}",
          style: const TextStyle(
            fontSize: 40
          ),),
        ),
        Text("Anzahl Tage",
          style: const TextStyle(
              fontSize: 20
          )),
        MealSumCard(meals: meals, title: "Vegan", mealType: MealType.VEGAN,),
        MealSumCard(meals: meals, title: "Vegetarisch", mealType: MealType.VEGGIE,),
        MealSumCard(meals: meals, title: "Mischkost", mealType: MealType.OMNI,)
      ],
    );
  }

  List<String> daysTilToday() {
    final DateFormat _dateFormatter = DateFormat("dd.MM.yyyy");
    var today = DateTime.now();
    var dates = <String>[];
    var date = DateTime(today.year);

    while (_dateFormatter.format(date) != _dateFormatter.format(today)) {
      dates.add(_dateFormatter.format(date));
      date = date.add(const Duration(days: 1));
    }
    dates.add(_dateFormatter.format(date));
    return dates;
  }

}

class MealSumCard extends StatelessWidget {

  const MealSumCard({
    Key? key,
    required this.title, required this.meals,
    required this.mealType
  }) : super(key: key);

  final MealType mealType;
  final List meals;
  final String title;

  @override
  Widget build(BuildContext context) {
    var sumOfType = meals.where((element) => MealType.values.byName(element) == mealType).length;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("$title",
              style: const TextStyle(fontSize: 30)),
              Text("$sumOfType",
                  style: const TextStyle(fontSize: 20))
            ],
          ),
        ),
      ),
    );
  }
}
