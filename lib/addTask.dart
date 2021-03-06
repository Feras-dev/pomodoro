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
    return Form(
      key: _formKey,
      child: Container(
        width: 400.0,
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
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
            new Container(
                width: 400.0,
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
                child: new RaisedButton(
                  child: const Text('Add Task'),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}
