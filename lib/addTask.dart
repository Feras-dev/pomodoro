import 'package:flutter/material.dart';

// Create a Form widget.
class MyAddTaskForm extends StatefulWidget {
  @override
  MyAddTaskFormState createState() {
    return MyAddTaskFormState();
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
class MyAddTaskFormState extends State<MyAddTaskForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

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
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Task Name',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Work Interval',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Break Interval',
                  ),
                ),
                Padding(padding: const EdgeInsets.fromLTRB(0, 16, 0, 0)),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Add Task'),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
