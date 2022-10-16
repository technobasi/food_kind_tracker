import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../model/MealType.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  TextEditingController dateInput = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormatter = DateFormat("dd.MM.yyyy");
  final _ONE_DAY = const Duration(days: 1);
  MealType? _selected_meal = null;
  Box mealBox = Hive.box("meals");

  @override
  void initState() {
    dateInput.text = _dateFormatter.format(_selectedDate);
    loadMealFromHive();
    super.initState();
  }

  void loadMealFromHive() {
    var mealString = mealBox.get(_dateFormatter.format(_selectedDate));
    if(mealString != null) {
      _selected_meal = MealType.values.byName(mealString);
    } else {
      _selected_meal = null;
    }
  }
  void setNewDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      dateInput.text = _dateFormatter.format(_selectedDate);
      loadMealFromHive();
    });
  }

  @override
  Widget build(BuildContext context) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: IconButton(
                        onPressed: () {
                          setNewDate(_selectedDate.subtract(_ONE_DAY));
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      readOnly: true,
                      controller: dateInput,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                          labelText: "Datum auswählen"),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2020),
                            lastDate:
                            DateTime.now().add(const Duration(days: 365 * 10)));
                        if (pickedDate != null) {
                          setNewDate(pickedDate);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: IconButton(
                        onPressed: () {
                          setNewDate(_selectedDate.add(_ONE_DAY));
                        },
                        icon: const Icon(Icons.arrow_forward)),
                  )
                ],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(300, 50, 300, 0),
                  child: ListView(
                    children: [
                         Card(
                            child: ListTile(
                              title: const Text("Mischkost",
                              textAlign: TextAlign.center,),
                              trailing: _selected_meal == MealType.OMNI
                                  ? const Icon(Icons.check)
                                  : null,
                              onTap: () {
                                mealBox.put(_dateFormatter.format(_selectedDate),
                                    MealType.OMNI.name).then((value) {
                                  setState(() {
                                 _selected_meal = MealType.OMNI;
                                });
                                });
                              },
                            ),
                          ),
                      Card(
                        child: ListTile(
                          title: const Text("Vegetarisch",
                          textAlign: TextAlign.center,),
                          trailing: _selected_meal == MealType.VEGGIE
                              ? const Icon(Icons.check)
                              : null,
                          onTap: () {
                            setState(() {
                              _selected_meal = MealType.VEGGIE;
                              mealBox.put(_dateFormatter.format(_selectedDate), MealType.VEGGIE.name);
                            });
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("Vegan",
                          textAlign: TextAlign.center,),
                          trailing: _selected_meal == MealType.VEGAN
                              ? const Icon(Icons.check)
                              : null,
                          onTap: () {
                            setState(() {
                              _selected_meal = MealType.VEGAN;
                              mealBox.put(_dateFormatter.format(_selectedDate), MealType.VEGAN.name);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
