import 'package:flutter/material.dart';
import 'package:pomodoro/model/Storage.dart';
import 'view/addTask.dart';
import 'view/home.dart';

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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        primarySwatch: buildMaterialColor(Color(0xFF884aee)),
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

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
