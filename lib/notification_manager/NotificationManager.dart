// imports
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart' show rootBundle;
// import '../state_machine/StatesMachineConstants.dart';

String jsonFile = 'lib/notification_manager/NotificationManagerConstants.json';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// class definition
class NotificationManager {
  // attributes
  DateTime lastNotificationTimestamp;
  int minTimeBetweenNotifications = 2; // notifications throttle in seconds
  Map<String, dynamic> nmconsts; // map to hold notification contstants
  int currNotificationId = 0; // increment to avoide overwritting the same notification
  // State state;

  NotificationManager() {
    // initNotificationManager();
  }

  // methods
  ///initialize notification manager. call only once upon app launching.
  ///@return: true if initialized successfully. false otherwise.
  Future<bool> initNotificationManager() async {
    // set last notification timestamp to current time
    lastNotificationTimestamp = DateTime.now();

    // load notification manager constants
    nmconsts = await getJson(jsonFile);
    if (nmconsts == null) {
      currNotificationId += 1;
      _showNotification(currNotificationId, nmconsts['init']['title'],
          nmconsts['init']['failure']);
    }

    currNotificationId += 1;
    _showNotification(currNotificationId, nmconsts['init']['title'],
        nmconsts['init']['success']);

    return true;
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
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(i, title, body, platformChannelSpecifics, payload: 'item: x');
  }

  /// read json file and store it as a map
  Future<Map<String, dynamic>> getJson(String jsonFileName) async {
    Future<String> myStr = rootBundle.loadString(jsonFileName);

    Map<String, dynamic> myMap = jsonDecode(await myStr);

    return myMap;
  }
}
