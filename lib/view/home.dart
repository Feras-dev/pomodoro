import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  // HomeScreen is a stateful widget, that is, it holds values
  // obtained dynamically.
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // These variables will hold values entered by the user
  // on AddTask page.
  String _taskName = '';
  String _workInterval = '';
  String _breakInterval = '';

  // initState is called exactly once during lifecycle of the
  // page.
  @override
  void initState() {
    getData();
  }

  // Gets the data from shared_preferences and sets it to
  // the state object.
  getData() async {
    // Get a reference to the SharedPreferences instance.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Set the user inputted data to the local variables if present.
      // Otherwise ask the user to add the task.
      _taskName = prefs.getString('taskName') ?? "No tasks to complete.";
      _workInterval = prefs.getString('workInterval') ?? "Press Add Task to add a new one!";
      _breakInterval = prefs.getString('breakInterval') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _taskName,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 6)),
            Text(
              _workInterval,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              _breakInterval,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
        label: Text('Add Task'),
        tooltip: 'Increment',
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}