import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionSwitch extends StatefulWidget {
  const NotificationPermissionSwitch({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPermissionSwitchState createState() =>
      _NotificationPermissionSwitchState();
}

class _NotificationPermissionSwitchState
    extends State<NotificationPermissionSwitch> {
  bool notificationPermission = false;

  @override
  void initState() {
    super.initState();
    checkNotificationPermissionStatus();
  }

  Future<void> checkNotificationPermissionStatus() async {
    var status = await Permission.notification.status;
    setState(() {
      notificationPermission = status.isGranted;
    });
  }

  Future<void> requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      var result = await Permission.notification.request();
      if (result.isGranted) {
        // Toestemming is verleend
        setState(() {
          notificationPermission = true;
        });
      } else {
        // Toestemming is geweigerd
        setState(() {
          notificationPermission = false;
        });
      }
    }
  }

    Future<void> disableNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isGranted) {
      var status = await Permission.notification.request();
      if (status.isDenied) {
        // Toestemming is ingetrokken
        setState(() {
          notificationPermission = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: notificationPermission,
      onChanged: (value) {
        setState(() {
          notificationPermission = value;
        });
        if(value){
        requestNotificationPermission();
        } else{
          disableNotificationPermission();
        }
      },
    );
  }
}
