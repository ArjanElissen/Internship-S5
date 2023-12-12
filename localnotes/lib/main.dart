import 'dart:async';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localnotes/getdata.dart';
import 'package:localnotes/homepage.dart';
import 'package:localnotes/local_note.dart';
import 'package:localnotes/stats.dart';
import 'package:localnotes/takemedicine.dart';
import 'package:localnotes/textfield_for_settings.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

Future<tz.TZDateTime> getTime() async {
  print("de tijd ophalen lukt");
  return tz.TZDateTime.now(tz.local).toLocal();
}

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     print("Native called background task: $task");
//     // loadSavedTimesFromAPI();
//     print('functie werkt');
//     await loadSavedTimesFromAPI();
//     final currentTime = await getTime();
//     // await setTimeForNotes();
//     // await checkNotificationTime(currentTime);
//     // await showLocalNotification();
//     // await checkNotificationTime();
//     print('task succesvol');
//     return Future.value(true);
//   });
// }

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  //   Workmanager().initialize(
  //   callbackDispatcher, // The top level function, aka callbackDispatcher
  //   isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  // );
  // Workmanager().registerPeriodicTask("task-identifier", "simpleTask", frequency: const Duration(minutes: 15));

  tzdata.initializeTimeZones();

  // await AndroidAlarmManager.initialize();
  // const int checkNotificationAlarmID = 1; // Kies een unieke ID
  // await AndroidAlarmManager.periodic(const Duration(seconds: 10), checkNotificationAlarmID, checkNotificationTime);

  // AwesomeNotifications().initialize(
  //   'resource://drawable/ic_launcher', // Vervang door het juiste pictogram
  //   [
  //     NotificationChannel(
  //       channelKey: 'notes',
  //       channelName: 'notes',
  //       channelDescription: 'Default Channel for Notifications',
  //       defaultColor: const Color(0xFF9D50DD),
  //       ledColor: Colors.red,
  //       importance: NotificationImportance.High,
  //     ),
  //   ],
  // );

  AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
  
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
       AndroidInitializationSettings('ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   onDidReceiveNotificationResponse: onSelectNotification,
  // );

  loadSavedTimes(selectedTimes);
  loadYesNo();
  loadSavedTimesFromAPI();
  showLocalNotification();

// final currentTime = await getTime();

// const oneMinute = Duration(minutes:1);
// Timer.periodic(oneMinute, (Timer timer) {
//   checkNotificationTime();
// });
}

class MyApp extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Hier stel je de navigatorKey in
      home: const HomePage(),
      routes: {
        '/stats': (context) => const CheckStats(),
        '/takemeds': (context) => const TakeMedicationPage(),
      },
    );
  }
}


