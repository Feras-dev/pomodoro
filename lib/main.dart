import 'package:flutter/material.dart';
import 'package:pomodoro/addTask.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
  String _taskName = '';
  String _workInterval = '';
  String _breakInterval = '';

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('taskName');
    prefs.getString('workInterval');
    prefs.getString('breakInterval');
    setState(() {
      _taskName = prefs.getString('taskName');
      _workInterval = prefs.getString('workInterval');
      _breakInterval = prefs.getString('breakInterval');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pomodoro'),
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
