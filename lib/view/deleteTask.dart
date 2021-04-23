import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pomodoro/model/PriorityLevel.dart';
import 'package:pomodoro/model/Storage.dart';
import 'package:pomodoro/model/Task.dart';
import 'package:uuid/uuid.dart';

// The Delete Task widget
class DeleteTaskScreen extends StatefulWidget {
  @override
  DeleteTaskScreenState createState() {
    return DeleteTaskScreenState();
  }
}

// The Delete Task State class
class DeleteTaskScreenState extends State<DeleteTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Are you sure you want to delete this task?"),
            ],
          )),
    );
  }
}
