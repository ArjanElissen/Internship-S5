import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:localnotes/api/sqlsavetimes.dart';
import 'package:localnotes/getdata.dart';
// import 'package:localnotes/api/sqlsavetimes.dart';
import 'package:localnotes/local_note.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

List<TimeOfDay?> selectedTimes = List.filled(3, null); // Create a list of selectedTimes

const InputDecoration commonInputDecoration = InputDecoration(
  labelText: 'Select a time', // Optional label
  hintText: 'Select a time',
  border: OutlineInputBorder(), // Add a border
);

class TextfieldForm extends StatefulWidget {
  const TextfieldForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TextfieldFormState createState() => _TextfieldFormState();
}

class _TextfieldFormState extends State<TextfieldForm> {
  @override
  void initState() {
    super.initState();
    // loadSavedTimes();
  }

  @override
  Widget build(BuildContext context) {
    // loadSavedTimes();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: commonInputDecoration,
                controller: TextEditingController(
                  text: selectedTimes[0] != null
                      ? selectedTimes[0]!.format(context)
                      : '',
                ),
                readOnly: true,
                onTap: () => _selectTime(context, 0), // Pass index 0
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: commonInputDecoration,
                controller: TextEditingController(
                  text: selectedTimes[1] != null
                      ? selectedTimes[1]!.format(context)
                      : '',
                ),
                readOnly: true,
                onTap: () => _selectTime(context, 1), // Pass index 1
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: commonInputDecoration,
                controller: TextEditingController(
                  text: selectedTimes[2] != null
                      ? selectedTimes[2]!.format(context)
                      : '',
                ),
                readOnly: true,
                onTap: () => _selectTime(context, 2), // Pass index 2
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _saveTimesLocally();
                        _printSavedTimes();
                        saveTimesOnServer(selectedTimes);
                        showLocalNotification();
                        // saveTimesOnServer(selectedTimes);
                        // Handle saving the selected times
                        // You can access selectedTimes[0], selectedTimes[1], selectedTimes[2] for the values
                      },
                      child: const Text("Save time"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTimes[index] ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTimes[index] = picked;
      });
    }
  }

void _saveTimesLocally() async {
  final prefs = await SharedPreferences.getInstance();
  for (int i = 0; i < selectedTimes.length; i++) {
    if (selectedTimes[i] != null) {
      final timeString = '${selectedTimes[i]!.hour}:${selectedTimes[i]!.minute}';
      
      // Controleer of de waarde al is opgeslagen voordat je deze opnieuw opslaat
      final existingValue = prefs.getString('selectedTime$i');
      if (existingValue != timeString) {
        prefs.setString('selectedTime$i', timeString);
      }
    }
  }
}

  void _printSavedTimes() {
    for (int i = 0; i < selectedTimes.length; i++) {
      final time = selectedTimes[i];
      if (time != null) {
        print('Geselecteerde tijd $i: ${time.format(context)}');
      } else {
        print('Geselecteerde tijd $i is niet ingesteld');
      }
    }
  }
}

 // Variabele om bij te houden of de notificatie al is getoond

Future<void> checkNotificationTime() async {
  print("functie draait");
  bool notificationShown = false;
  final now = tz.TZDateTime.now(tz.UTC); // Haal de lokale tijd op
  final savedTimes = await loadSavedTimesFromAPI();
  print(now);
  for (final time in savedTimes) {
    // ignore: unnecessary_null_comparison
    if (time != null) {
      final savedHour = time.hour;
      final savedMinute = time.minute;
      // print("savedHour: $savedHour, savedMinute: $savedMinute"); // Voeg deze regel toe

      // Controleer of het huidige tijdstip exact overeenkomt met de opgeslagen tijd
      if (now.hour == savedHour && now.minute == savedMinute && !notificationShown) {
        print('je ontvangt meldingen');
        // Het is tijd om de notificatie te tonen op de opgeslagen tijd
        showLocalNotification();
        notificationShown = true;  // Markeer de notificatie als getoond
        break; // Als je slechts één notificatie wilt tonen, kun je uit de lus breken.
      }
    }
  }
  notificationShown = false;
}

