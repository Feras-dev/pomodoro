import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pomodoro/model/PriorityLevel.dart';
import 'package:pomodoro/model/Storage.dart';
import 'package:pomodoro/model/Task.dart';
import 'package:uuid/uuid.dart';

// Create a Form widget.
class AddTaskForm extends StatefulWidget {
  @override
  AddTaskFormState createState() {
    return AddTaskFormState();
  }
}

// Method to build and show alert box.
showAlertDialog(BuildContext context) {
  // Create OK button
  // TODO: Go back after dismissing the alert.
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Task Added"),
    content: Text("New task successfully added."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// Create a corresponding State class. This class holds data related to the form.
class AddTaskFormState extends State<AddTaskForm> {
  List<Task> taskList = [];
  String id = '';
  String _taskName = '';
  String _workInterval = '';
  String _breakInterval = '';
  String isComplete = 'no';
  PriorityLevel _taskPriority = PriorityLevel.LOW;

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  saveData(BuildContext context) async {
    // Whenever user presses Add Task button,
    // we take all the data entered by the user and
    // construct a new Task object with it.
    var uuid = Uuid();
    Task task = Task(
        id: uuid.v4(),
        name: _taskName,
        breakDuration: int.parse(_breakInterval),
        workDuration: int.parse(_workInterval),
        priorityLevel: _taskPriority,
        isComplete: false);

    // Singleton Storage class is used to access the
    // storage.
    bool isSuccess = await Storage().addTask(task);

    // Show alert only if the task has been stored successfully.
    if (isSuccess) {
      showAlertDialog(context);
    }
  }

  // Regex to confirm that given string is all numbers.
  bool isNumber(String string) {
    final numericRegex = RegExp(r"^[1-9]\d*$");
    return numericRegex.hasMatch(string);
  }

  // Task name input field.
  Widget _buildTaskField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter the task name";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Task Name',
      ),
      onSaved: (String value) {
        setState(() {
          _taskName = value;
        });
      },
    );
  }

  // Work interval input field.
  Widget _buildWorkIntervalField() {
    return TextFormField(
      // Validator gives a value and we need to
      // check that given value for errors.
      // Returning null indicates no errors and
      // validation passes.
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter work interval";
        } else if (!isNumber(value)) {
          return "Please enter a valid number";
        }
        return null;
      },
      // For opening the number keyboard.
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Work Interval',
      ),
      onSaved: (String value) {
        setState(() {
          _workInterval = value;
        });
      },
    );
  }

  // Break interval input field.
  Widget _buildBreakIntervalField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter break interval";
        } else if (!isNumber(value)) {
          return "Please enter a valid number";
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Break Interval',
      ),
      onSaved: (String value) {
        setState(() {
          _breakInterval = value;
        });
      },
    );
  }

  // A simple static text with padding.
  Widget _priorityText() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
      child: Text(
        "Task Priority",
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  // Task Priority dropdown list.
  Widget _buildPriorityLevelList() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
      // Dropdown button bound to PriorityLevel enum
      // Changing PriorityEnum values will automatically
      // change the dropdown options.
      child: DropdownButton<PriorityLevel>(
          // Values selected by the user.
          value: _taskPriority,
          onChanged: (PriorityLevel newValue) {
            setState(() {
              // Newly selected value will be set in the state.
              _taskPriority = newValue;
            });
          },
          // In order to populate the dropdown, we take all the values in the
          // PriorityLevel enum. Since we get values in "PriorityLevel.LOW"
          // format, we need to split it at ".". Here, dropdown should be
          // populated with the second value.
          items: PriorityLevel.values.map((PriorityLevel classType) {
            // Splitting with "." gives us a List<String> containing two values,
            // first is "PriorityLevel" and second is "LOW". Here we take 2nd
            // value (last in the returned List<String>), and process it to show
            // in the dropdown.
            String valUse = classType.toString().split(".").last.toLowerCase();
            valUse = valUse[0].toUpperCase() + valUse.substring(1);
            if (valUse.contains("_")) {
              valUse = valUse.replaceAll(new RegExp('[\\W_]+'), ' ');
            }
            return DropdownMenuItem<PriorityLevel>(
                value: classType, child: Text(valUse));
          }).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: Text("Add a new task"),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              // CrossAxisAlignment is used to align dropdown to
              // start of the screen.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTaskField(),
                _buildWorkIntervalField(),
                _buildBreakIntervalField(),
                _priorityText(),
                _buildPriorityLevelList(),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Add Task'),
                    onPressed: () {
                      // Validate the form and show appropriate errors.
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        // Save the data.
                        saveData(context);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
