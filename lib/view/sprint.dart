import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pomodoro/model/Task.dart';

import 'addTask.dart';

// The Sprint Screen widget
class SprintScreen extends StatefulWidget {
  final Task task;

  SprintScreen({Key key, @required this.task}) : super(key: key);

  @override
  SprintScreenState createState() {
    return SprintScreenState();
  }
}

class SprintScreenState extends State<SprintScreen> {
  // Task object to keep track if user updates the task.
  Task currentTask;

  // This will handle the UI. True if user is idle and next phase
  // is work phase.
  bool isWorkTime = true;
  String topLabel, startLabel;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentTask = widget.task;
      topLabel = isWorkTime ? "Work Time" : "Break Time";
      startLabel = isWorkTime ? "Start Work" : "Start Break";
    });
  }

  _changeState() {
    setState(() {
      topLabel = isWorkTime ? "Work Time" : "Break Time";
      startLabel = isWorkTime ? "Start Work" : "Start Break";
    });
  }

  // Executed after pressing Gear button.
  _editTask(Task task) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddTaskForm(oldTask: widget.task),
        )).then((value) {
      setState(() {
        // Takes edited Task and sets it into state
        if (value != null) currentTask = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sprint'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  // MediaQuery is used to get current screens dimensions
                  // and set width and height of widgets accordingly.
                  width: (MediaQuery.of(context).size.width) * 0.8,
                  child: Text(
                    currentTask.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                isWorkTime
                    ? Container(
                        padding: EdgeInsets.all(4),
                        width: (MediaQuery.of(context).size.width) * 0.2,
                        child: IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            onPressed: () => _editTask(currentTask)),
                      )
                    : Container() // Hide Gear Icon if user is not idle.
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Center(
              child:
                  Text(topLabel, style: Theme.of(context).textTheme.headline6),
            ),
          ),
          // Expanded widget automatically handles the dimensions of
          // wrapped widget if other widgets have fixed dimensions
          // and UI is going outside the screen.
          Expanded(
              child: Container(
            height: (MediaQuery.of(context).size.height) * 0.5,
            child: Center(
              child: Text(
                // This needs improvements.
                currentTask.workDuration.toString(),
                style: TextStyle(
                    fontSize: 82,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2),
              ),
            ),
          )),
          Container(
            height: (MediaQuery.of(context).size.height) * 0.25,
            child: Column(
              children: [
                Container(
                  child: ElevatedButton(
                    child: Text(startLabel.toUpperCase(),
                        style: TextStyle(letterSpacing: 2)),
                    onPressed: () {
                      setState(() {
                        // FOR DEBUG ONLY
                        isWorkTime = !isWorkTime;
                        // Update labels.
                        _changeState();
                      });
                    },
                  ),
                ),
                isWorkTime
                    ? Container(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 24),
                        child: ElevatedButton(
                          child: Text("Quit Sprint".toUpperCase(),
                              style: TextStyle(letterSpacing: 2)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    : Container()
                // Hide quit sprint button if user is not Idle.
              ],
            ),
          )
        ],
      ),
    );
  }
}
