import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/addTask.dart';
import 'view/home.dart';

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
        // All the available routes in the app.
        '/home': (context) => HomeScreen(),
        '/addTask': (context) => AddTaskForm(),
      },
      // The app's entry page.
      home: HomeScreen(),
    );
  }
}
