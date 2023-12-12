import 'package:flutter/material.dart';
import 'package:fluttertryouts/components/setuppushnotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Save the times
Future<void> saveMedicationTimes(List<TimeOfDay> times) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  for (int i = 0; i < times.length; i++) {
    String formattedTime = formatTimeOfDay(times[i]);
    print('Saving medication time $i: $formattedTime');
    await prefs.setString('medication_time_$i', formattedTime);
  }

  // Save the total number of medication times
  await prefs.setInt('medication_times_count', times.length);
}

// Call the times
Future<List<TimeOfDay>> getMedicationTimes() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int medicationTimesCount = prefs.getInt('medication_times_count') ?? 0;

  List<TimeOfDay> medicationTimes = [];

  for (int i = 0; i < medicationTimesCount; i++) {
    String? formattedTime = prefs.getString('medication_time_$i');
    if (formattedTime != null) {
      List<String> parts = formattedTime.split(':');
      if (parts.length == 2) {
        int hour = int.tryParse(parts[0]) ?? 0;
        int minute = int.tryParse(parts[1]) ?? 0;
        medicationTimes.add(TimeOfDay(hour: hour, minute: minute));
      }
    }
  }

  return medicationTimes;
}

// Get items individually
Future<TimeOfDay?> getIndividualMedicationTime(int index) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? formattedTime = prefs.getString('medication_time_$index');
  if (formattedTime != null) {
    List<String> parts = formattedTime.split(':');
    if (parts.length == 2) {
      int hour = int.tryParse(parts[0]) ?? 0;
      int minute = int.tryParse(parts[1]) ?? 0;
      return TimeOfDay(hour: hour, minute: minute);
    }
  }
  print('qwakka');
  return null;
}
