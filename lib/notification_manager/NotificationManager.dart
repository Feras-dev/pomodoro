// imports
// import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import '../state_machine/StatesMachineConstants.dart';

// String jsonFile = 'lib/notification_manager/NotificationManagerConstants.json';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');

// class definition
class NotificationManager {
  // attributes
  DateTime lastNotificationTimestamp;
  int minTimeBetweenNotifications = 2; // notifications throttle in seconds
  Map<String, dynamic> nmconsts; // map to hold notification contstants
  int currNotificationId =
      0; // increment to avoide overwritting the same notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // State state;

  /// constructor
  NotificationManager(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;

    // set last notification timestamp to current time
    lastNotificationTimestamp = DateTime.now();

    // // load notification manager constants
    // nmconsts = await getJson(jsonFile);
    // if (nmconsts == null) {
    //   currNotificationId += 1;
    //   _showNotification(currNotificationId, 'notification manager init',
    //       'notification initlization failed');
    // }

    currNotificationId += 1;
    _showNotification(currNotificationId, 'notification manager init',
        'notification initlization success');
  }

  /// notify the user that the state has changed.
  /// @return: true if notification is pushed successfully. false otherwise.
  bool notifyUserAboutStateChange(String oldState, String newState) {
    // currNotificationId += 1;
    // String title = nmconsts['stateChange']['title'];

    // if(oldState == ) {

    // }

    // _showNotification(currNotificationId, ,
    //     nmconsts['stateChange']['success']);
    return true;
  }

  /// notify the user that the timer for a work or break state is up.
  /// @return: true if notification is pushed successfully. false otherwise.
  bool notifyUserOfTimerLimit(String taskName, String currState) {
    return true;
  }

  /// throttle number of notifications pushed to the user to avoid spamming.
  /// @return: true if pushing now won't spam the user with notifications.
  ///         false otherwise.
  bool notificationsThrottleControl() {
    int diffSeconds =
        lastNotificationTimestamp.difference(DateTime.now()).inSeconds;
    return (diffSeconds < minTimeBetweenNotifications) ? false : true;
  }

  /// private method to push notification
  Future<void> _showNotification(int i, String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            '507', 'Pomodoro', 'Pomodoro notifification channel',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true); // show notification timestamp
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(i, title, body, platformChannelSpecifics, payload: 'item: x');
  }

  // /// read json file and store it as a map
  // Future<Map<String, dynamic>> getJson(String jsonFileName) async {
  //   Future<String> myStr = rootBundle.loadString(jsonFileName);

  //   Map<String, dynamic> myMap = jsonDecode(await myStr);

  //   return myMap;
  // }
}

/// call from entry-point functiona (most commonly main)
Future<FlutterLocalNotificationsPlugin>
    initNotificationManagerDependencies() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(/*'@mipmap-hdpi*/'ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  return flutterLocalNotificationsPlugin;
}
