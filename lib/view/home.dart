import 'package:flutter/material.dart';
import 'package:pomodoro/model/Storage.dart';
import 'package:pomodoro/model/Task.dart';
import 'package:pomodoro/view/deleteTask.dart';
import 'package:pomodoro/view/addTask.dart';

class HomeScreen extends StatefulWidget {
  @override
  // HomeScreen is a stateful widget, that is, it holds values
  // obtained dynamically.
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> taskList;

  // initState is called exactly once during lifecycle of the
  // page.
  @override
  void initState() {
    super.initState();
    getData();
  }

  // Gets the data from shared_preferences and sets it to
  // the state object.
  getData() {
    setState(() {
      taskList = Storage().getTasks();
      // taskList.forEach((element) {
      //   print(element.priorityLevel.index);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: _cards(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF20dac5),
        onPressed: () {
          // Navigator pushes based on the string we have given
          // in the routes object. The then function is called when
          // AddTask page is popped off the navigator. This triggers
          // the function given as an argument.
          Navigator.pushNamed(context, "/addTask").then((value) {
            setState(() {
              getData();
            });
          });
        },
        label: Text(
          'Add Task',
          style: TextStyle(color: Color(0xFF04433d)),
        ),
        tooltip: 'Increment',
        icon: Icon(Icons.add, color: Color(0xFF04433d)),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> _cards() {
    return taskList
        .map((task) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onLongPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTaskForm(oldTask: task),
                          )).then((value) {
                        setState(() {
                          getData();
                        });
                      });
                    },
                    child: Container(
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
                            task.name,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            task.workDuration.toString(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            task.breakDuration.toString(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.grey,
                            //size: 24.0,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DeleteTaskScreen(task: task),
                                  )).then((value) {
                                setState(() {
                                  getData();
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ]))
        .toList();
  }
}
