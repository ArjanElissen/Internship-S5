import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localnotes/api/sqlsavetimes.dart';
import 'package:localnotes/getdata.dart';
import 'package:localnotes/main.dart';
import 'package:timezone/timezone.dart' as tz;

tz.TZDateTime scheduledTime = tz.TZDateTime.now(tz.local);

Future<void> setTimeForNotes() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await Future.delayed(const Duration(seconds: 5)); // Wacht 5 seconden

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'Chat Maatje', // Titel van de notificatie
    'Het is weer tijd om je medicatie in te nemen.', // Inhoud van de notificatie
    platformChannelSpecifics,
    payload: 'item xx',
  );
}

Future<void> showLocalNotification() async {
  final savedTimes = await loadSavedTimesFromAPI();

  for (final time in savedTimes) {
    AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher',
      [
        NotificationChannel(
          channelKey: 'notes',
          channelName: 'notes',
          channelDescription: 'Default Channel for Notifications',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.red,
          importance: NotificationImportance.High,
        ),
      ],
    );

    final notificationId = time.hashCode; // Use a unique identifier for each notification
    print(notificationId);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'notes',
        title: 'Neem uw medicatie!',
        body: "Heeft u uw medicatie ingenomen?",
        largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
        notificationLayout: NotificationLayout.BigPicture,
        payload: {'notificationId': notificationId.toString()}, // Keep the payload as a map
      ),
      schedule: NotificationCalendar(
        hour: time.hour,
        minute: time.minute,
      ),
      actionButtons: [
        NotificationActionButton(key: 'ja_action', label: 'JA', actionType: ActionType.Default),
        NotificationActionButton(key: 'nee_action', label: 'NEE'),
      ],
    );
  }
}

Future<void> showLocalNotificationInstant() async {

    AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher',
      [
        NotificationChannel(
          channelKey: 'notes',
          channelName: 'notes',
          channelDescription: 'Default Channel for Notifications',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.red,
          importance: NotificationImportance.High,
        ),
      ],
    );

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'notes',
        title: 'Neem uw medicatie!',
        body: "Heeft u uw medicatie ingenomen?",
        largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
        notificationLayout: NotificationLayout.BigPicture,
        payload: {'notificationId': 'instantNote'}, // Keep the payload as a map
      ),
      actionButtons: [
        NotificationActionButton(key: 'ja_action2', label: 'JA', actionType: ActionType.Default),
        NotificationActionButton(key: 'nee_action2', label: 'NEE'),
      ],
    );
}

// Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  // print('deze functie werkt!');
  // print('dit is de $receivedAction');
  // if (receivedAction.buttonKeyPressed == 'nee_action') {
    // print('nee werkt');
    // updateNeeTeller();
    // loadYesNo();
  // } else if (receivedAction.buttonKeyPressed == 'ja_action') {
    // print("ja werkt");
    // updateJaTeller();
    // loadYesNo();
  // } else if (receivedAction.payload!['notificationId'] == '1234567890') {
    // print('melding werkt');
    // onActionReceivedImplementationMethod(receivedAction);
    // loadYesNo();
  // }
// }

Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
   final notificationId = int.parse(receivedAction.payload!['notificationId'] ?? '');

  print('deze functie werkt!');
  print('dit is de $receivedAction');
  if (receivedAction.buttonKeyPressed == 'nee_action') {
    print('nee werkt');
    updateNeeTeller();
    loadYesNo();
  } else if (receivedAction.buttonKeyPressed == 'ja_action') {
    print("ja werkt");
    updateJaTeller();
    loadYesNo();
  } else if (notificationId == int.parse(receivedAction.payload!['notificationId'] ?? '') || receivedAction.payload!['notificationId'] == 'instantNote') {
    print('melding werkt');
    onActionReceivedImplementationMethod(receivedAction);
    loadYesNo();
  }
}

Future<void> onActionReceivedImplementationMethod(
  ReceivedAction receivedAction) async {
  print('Deze functie zou je naar een nieuwe pagina moeten leiden');

  MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
    '/takemeds',
    (route) => (route.settings.name != '/takemeds') || route.isFirst,
    arguments: receivedAction,
  );
}