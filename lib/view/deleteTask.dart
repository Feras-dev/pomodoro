import 'package:flutter/material.dart';
import 'package:pomodoro/model/Storage.dart';
import 'package:pomodoro/model/Task.dart';

// The Delete Task widget
class DeleteTaskScreen extends StatefulWidget {
  final Task task;
  DeleteTaskScreen({Key key, @required this.task}) : super(key: key);

  @override
  DeleteTaskScreenState createState() {
    return DeleteTaskScreenState();
  }
}

// Method to build and show alert box.
showAlertDialog(BuildContext context) {
  // Create OK button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      //Navigator.pushNamed(context, "/home");
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Task Deleted"),
    content: Text("Task successfully deleted."),
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

deleteTask(BuildContext context, Task task) async {
  bool isSuccess = await Storage().deleteTask(task);
  if (isSuccess) {
    showAlertDialog(context);
  }
}

// The Delete Task State class
class DeleteTaskScreenState extends State<DeleteTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Task'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Row(
              children: [
                Text(
                  "Are you sure you want to delete this task?",
                  style:
                      TextStyle(fontSize: 20, color: Colors.black, height: 1.2),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Container(
              width: 400,
              height: 60,
              decoration: BoxDecoration(color: Colors.white,
                  // borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(),
                    //   BoxShadow(offset: Offset(20, 20), color: Colors.yellow),
                  ]),
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.task.name,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    widget.task.workDuration.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    widget.task.breakDuration.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          deleteTask(context, widget.task);
        },
        label: Text('Delete'),
        tooltip: 'Delete',
        icon: Icon(Icons.delete),
      ),
    );
  }
}