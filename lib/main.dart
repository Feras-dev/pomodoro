import 'package:flutter/material.dart';
import 'package:pomodoro/model/Storage.dart';
import 'view/addTask.dart';
import 'view/home.dart';
import 'package:pomodoro/notification_manager/NotificationManager.dart';

void main() async {
  // If you're running an application and need to access the binary
  // messenger before `runApp()` has been called (for example, during
  // plugin initialization), then you need to explicitly call the
  // `WidgetsFlutterBinding.ensureInitialized()` first.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Get a SharedPreferences instance just to enable
  // SharedPreferences.
  await Storage().enableStorage();
  // Storage().removeAllTasks();

  await NotificationManager().initNotificationManager();

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
        '/addTask': (context) => AddTaskForm(oldTask: null),
      },
      // The app's entry page.
      home: HomeScreen(),
    );
  }
}
