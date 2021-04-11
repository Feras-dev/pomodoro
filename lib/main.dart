import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addTask.dart';
import 'dart:convert';
import 'Task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/addTask': (context) => AddTaskForm(),
      },
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> taskList;

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> result = prefs.getStringList('taskList');
    if (result != null) {
      List<Task> tasks =
          result.map((t) => Task.fromJson(json.decode(t))).toList();
      setState(() {
        taskList = tasks;
      });
    } else {
      print("You have no Task to complete right now");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (taskList != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('pomodoro'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: _cards(),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/addTask").then((value) {
              setState(() {
                getData();
              });
            });
          },
          label: Text('Add Task'),
          tooltip: 'Increment',
          icon: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('pomodoro'),
          centerTitle: true,
        ),
        body: Center(
          child: Text("No Task"),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/addTask").then((value) {
              setState(() {
                getData();
              });
            });
          },
          label: Text('Add Task'),
          tooltip: 'Increment',
          icon: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
  }

  List<Widget> _cards() {
    return taskList
        .map((task) => Container(
              width: 100,
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
                    task.taskName,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    task.workInterval,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(task.breakInterval,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
            ))
        .toList();
  }
}
