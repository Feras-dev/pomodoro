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
        primarySwatch: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Pomodoro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _gotoAddTask() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyAddTaskForm()));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'No tasks to complete.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 6)),
            Text(
              'Press Add Task to add a new one!',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
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
