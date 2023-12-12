import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionHandler {
  static Future<bool> askForRequest(BuildContext context) async {
    var status = await Permission.notification.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      var result = await Permission.notification.request();
      status = await Permission.notification.status;

      if (result.isGranted) {
        return true; // Toestemming is verleend
      } else {
        // Toon een dialoogvenster om de gebruiker te informeren dat meldingen niet kunnen worden ingeschakeld zonder toestemming
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Meldingsrechten vereist'),
              content: const Text('Als u meldingen wilt ontvangen dan moet u toestemming verlenen aan de app.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Permission.notification.status;
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return false; // Toestemming is geweigerd
      }
    } else if (status.isGranted) {
      return true; // Toestemming is al verleend
    } else {
      return false; // Onbekende status
    }
  }

  static requestNotificationPermission(BuildContext context) {}
}

