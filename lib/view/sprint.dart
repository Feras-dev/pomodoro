import 'dart:async';

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

  // These two booleans will handle the UI.
  bool isWorkTime = true, isBreakTime = false;
  String topLabel, startLabel;

  // Variables to keep track of time.
  int currentMinutes, currentSeconds;

  // Current instance of Timer class.
  // Updated everytime timer starts.
  Timer currentTimer;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentTask = widget.task;
      // Initially, minutes will always be current task's
      // work duration and seconds will be 0.
      currentMinutes = currentTask.workDuration;
      currentSeconds = 0;
      _changeState();
    });
  }

  _changeState() {
    setState(() {
      topLabel = isWorkTime
          ? "Work Time"
          : isBreakTime
              ? "Work Time"
              : "Break Time";
      startLabel = isWorkTime
          ? "Start Work"
          : isBreakTime
              ? "Stop Work/Start Break"
              : "Stop Break";
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

  Widget _taskName() {
    return Container(
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
    );
  }

  Widget _taskEdit() {
    return isWorkTime
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
        : Container(); // Hide Gear Icon if user is not idle.
  }

  Widget _topLabel() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Center(
        child: Text(topLabel, style: Theme.of(context).textTheme.headline6),
      ),
    );
  }

  _startTimer() async {
    await _stopTimer();
    currentTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (currentSeconds == 0) {
          if (currentMinutes == 0) {
            // If both, minutes and seconds are zero,
            // stop the timer.
            timer.cancel();
          } else {
            // This implies that timer has reached to 0 seconds
            // but there are one or more minutes remaining in the
            // countdown. So reset seconds to 59 and reduce the
            // minute by 1.
            currentSeconds = 59;
            --currentMinutes;
          }
        } else {
          // Reduce seconds to count down.
          --currentSeconds;
        }
      });
    });
  }

  _stopTimer() async {
    // Stop timer after checking for null.
    if (currentTimer != null && currentTimer.isActive) {
      currentTimer.cancel();
      setState(() {
        currentSeconds = 0;
      });
    }
  }

  Widget _timerDisplay() {
    // Expanded widget automatically handles the dimensions of
    // wrapped widget if other widgets have fixed dimensions
    // and UI is going outside the screen.

    String minutes = currentMinutes.toString();
    String seconds = currentSeconds.toString();

    // Add "0" if any number is in between 0 to 9.
    minutes = minutes.length > 1 ? minutes : "0" + minutes;
    seconds = seconds.length > 1 ? seconds : "0" + seconds;

    String time = minutes + ":" + seconds;

    return Expanded(
        child: Container(
      height: (MediaQuery.of(context).size.height) * 0.5,
      child: Center(
        child: Text(
          // This needs improvements.
          time,
          style: TextStyle(
              fontSize: 82, fontWeight: FontWeight.w600, letterSpacing: 2),
        ),
      ),
    ));
  }

  Widget _sprintControls() {
    return Container(
      child: ElevatedButton(
        child:
            Text(startLabel.toUpperCase(), style: TextStyle(letterSpacing: 2)),
        onPressed: () {
          setState(() {
            if (isWorkTime) {
              // This indicates that user has pressed Start Work.
              isWorkTime = false;
              isBreakTime = true;
              currentMinutes = currentTask.workDuration;
              _startTimer();
            } else if (isBreakTime && !isWorkTime) {
              // This indicates that user has pressed Stop Work/Start Break.
              isBreakTime = false;
              currentMinutes = currentTask.breakDuration;
              _startTimer();
            } else if (!isBreakTime && !isWorkTime) {
              // This indicates that user has pressed Stop Break.
              isBreakTime = false;
              isWorkTime = true;
              currentMinutes = currentTask.workDuration;
              _stopTimer();
            }
          });

          // Update labels.
          _changeState();
        },
      ),
    );
  }

  Widget _quitSprint() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 12, 0, 24),
      child: ElevatedButton(
        child: Text("Quit Sprint".toUpperCase(),
            style: TextStyle(letterSpacing: 2)),
        onPressed: () {
          Navigator.pop(context);
          _stopTimer();
        },
      ),
    );
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
              children: [_taskName(), _taskEdit()],
            ),
          ),
          _topLabel(),
          _timerDisplay(),
          Container(
            height: (MediaQuery.of(context).size.height) * 0.25,
            child: Column(
              children: [_sprintControls(), _quitSprint()],
            ),
          )
        ],
      ),
    );
  }
}
