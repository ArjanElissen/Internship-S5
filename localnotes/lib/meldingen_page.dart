import 'dart:async';
import 'package:flutter/material.dart';
import 'package:localnotes/getdata.dart';
import 'package:localnotes/local_note.dart';
import 'package:localnotes/request_permission.dart';
import 'package:localnotes/toggle.dart';

class Meldingen extends StatefulWidget {
  const Meldingen({super.key});

  @override
  _MeldingenState createState() => _MeldingenState();
}

class _MeldingenState extends State<Meldingen> {
  String formattedTime = '';
  String formatTime(DateTime dateTime) {
  final String hours = dateTime.hour.toString().padLeft(2, '0');
  final String minutes = dateTime.minute.toString().padLeft(2, '0');
  final String seconds = dateTime.second.toString().padLeft(2, '0');

  return "$hours:$minutes:$seconds";
}
  late Timer _timer; // Define the timer variable

  @override
void initState() {
  super.initState();
  _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (mounted) {
      final now = DateTime.now();
      formattedTime = formatTime(now); // Format the time using the function
      setState(() {});
      // print(now);
    }
  });
}

  @override
  void dispose() {
    // Cancel the timer in the dispose method to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Your build method remains unchanged
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            formattedTime,
            style: const TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: (){
              loadYesNo();
              loadYesNo2();
            }, 
            child: const Text('deze knop doet helemaal niets!')),
          ElevatedButton(
            onPressed: () {
              setTimeForNotes();
            },
            child: const Text('Melding na 30 seconden'),
          ),
          ElevatedButton(
            onPressed: () async {
              bool hasPermission =
                  await NotificationPermissionHandler.askForRequest(context);
              if (hasPermission) {
                // showLocalNotification();
                showLocalNotificationInstant();
              }
            },
            child: const Text('Directe Melding'),
          ),
          const NotificationPermissionSwitch(),
        ],
      ),
    );
  }
}
