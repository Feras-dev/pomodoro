import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create a Form widget.
class AddTaskForm extends StatefulWidget {
  @override
  AddTaskFormState createState() {
    return AddTaskFormState();
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
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
  String id = '';
  String _taskName = '';
  String _workInterval = '';
  String _breakInterval = '';
  String isComplete = 'no';

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('taskName', _taskName);
    prefs.setString('workInterval', _workInterval);
    prefs.setString('breakInterval', _breakInterval);
  }

  bool isNumber(String string) {
    final numericRegex = RegExp(r"^[1-9]\d*$");
    return numericRegex.hasMatch(string);
  }

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

  Widget _buildWorkIntervalField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter work interval";
        } else if (!isNumber(value)) {
          return "Please enter a valid number";
        }
        return null;
      },
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
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              children: <Widget>[
                _buildTaskField(),
                _buildWorkIntervalField(),
                _buildBreakIntervalField(),
                Padding(padding: const EdgeInsets.fromLTRB(0, 16, 0, 0)),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Add Task'),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        saveData();
                        showAlertDialog(context);
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
