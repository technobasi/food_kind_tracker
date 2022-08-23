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
    _selected_meal = MealType.valueOf(
        mealBox.get(_dateFormatter.format(_selectedDate)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
          return Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedDate = _selectedDate.subtract(_ONE_DAY);
                          dateInput.text = _dateFormatter.format(_selectedDate);
                        });
                      },
                      icon: const Icon(Icons.arrow_back)),
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
                          setState(() {
                            _selectedDate = pickedDate;
                            dateInput.text = _dateFormatter.format(pickedDate);
                          });
                        }
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedDate = _selectedDate.add(_ONE_DAY);
                          dateInput.text = _dateFormatter.format(_selectedDate);
                        });
                      },
                      icon: const Icon(Icons.arrow_forward))
                ],
              ),
              Flexible(
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        title: const Text("Mischkost"),
                        trailing: _selected_meal == MealType.OMNI
                            ? const Icon(Icons.check)
                            : null,
                        onTap: () {
                          mealBox.put(_dateFormatter.format(_selectedDate),
                              MealType.OMNI.toString()).then((value) {
                            setState(() {
                           _selected_meal = MealType.OMNI;
                          });
                          });
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text("Vegetarisch"),
                        trailing: _selected_meal == MealType.VEGGIE
                            ? const Icon(Icons.check)
                            : null,
                        onTap: () {
                          setState(() {
                            _selected_meal = MealType.VEGGIE;
                            mealBox.put(_dateFormatter.format(_selectedDate), MealType.VEGGIE.toString());
                          });
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Vegan"),
                        trailing: _selected_meal == MealType.VEGAN
                            ? const Icon(Icons.check)
                            : null,
                        onTap: () {
                          setState(() {
                            _selected_meal = MealType.VEGAN;
                            mealBox.put(_dateFormatter.format(_selectedDate), MealType.VEGAN.toString());
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
