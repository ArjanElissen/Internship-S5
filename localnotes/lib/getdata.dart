import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

int jaAntwoord = 0;
int neeAntwoord = 0;

Future<bool> loadSavedTimes(List<TimeOfDay?> selectedTimes) async {
  final prefs = await SharedPreferences.getInstance();
  bool loaded = false;

  for (int i = 0; i < selectedTimes.length; i++) {
    final timeString = prefs.getString('selectedTime$i');
    if (timeString != null) {
      final parts = timeString.split(':');
      selectedTimes[i] = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
      loaded = true;
    }
  }
  return loaded;
}

Future<Map<String, int>?> loadYesNo() async {
  try {
    final response = await http.get(Uri.parse('http://192.168.24.101/api_service_chatbot/connection_api.php'));

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      print("Verbinding oke");

      if (responseData is Map<String, dynamic> && responseData.containsKey("antwoord_ja_nee")) {
        final antwoordJaNeeData = responseData["antwoord_ja_nee"] as List<dynamic>;

        if (antwoordJaNeeData.isNotEmpty) {
          // Neem aan dat the eerste rij in de lijst wordt gebruikt
          final firstRow = antwoordJaNeeData[0] as Map<String, dynamic>;

          final jaValue = int.parse(firstRow["ja"].toString());
          final neeValue = int.parse(firstRow["nee"].toString());

          final result = {
            "ja": jaValue,
            "nee": neeValue,
          };

          jaAntwoord = jaValue;
          neeAntwoord = neeValue;

          // print("Waarde voor ja: $jaValue");
          // print("Waarde voor nee: $neeValue");

          return result;
        }
      }
    }
    return null;
  } catch (e) {
    print('Fout bij het ophalen van gegevens: $e');
    return null;
  }
}

Future<List<TimeOfDay>> loadSavedTimesFromAPI() async {
  try {
    final response = await http.get(Uri.parse('http://192.168.24.101/api_service_chatbot/connection_api.php'));

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      print("Verbinding oke");

      if (responseData is Map<String, dynamic> && responseData.containsKey("savedtimes")) {
        final savedTimesData = responseData["savedtimes"] as List<dynamic>;

        if (savedTimesData.isNotEmpty) {
          // Neem aan dat de eerste rij in de lijst wordt gebruikt
          final firstRow = savedTimesData[0] as Map<String, dynamic>;

          final savedTime1 = firstRow["saved_time_1"].toString();
          final savedTime2 = firstRow["saved_time_2"].toString();
          final savedTime3 = firstRow["saved_time_3"].toString();

          final timeFormat = DateFormat("HH:mm");

          final result = [
            TimeOfDay.fromDateTime(timeFormat.parse(savedTime1)),
            TimeOfDay.fromDateTime(timeFormat.parse(savedTime2)),
            TimeOfDay.fromDateTime(timeFormat.parse(savedTime3)),
          ];

          // print("Tijd 1: $savedTime1");
          // print("Tijd 2: $savedTime2");
          // print("Tijd 3: $savedTime3");

          return result;
        }
      }
    }
    return [];
  } catch (e) {
    print('Fout bij het ophalen van gegevens: $e');
    return [];
  }
}


Future<Map<int, Map<String, int>>?> loadYesNo2() async {
  try {
    final response = await http.get(Uri.parse('http://192.168.24.101/api_service_chatbot/connection_api.php'));

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      // print("Verbinding oke");

      if (responseData is Map<String, dynamic> && responseData.containsKey("antwoord_ja_nee")) {
        final antwoordJaNeeData = responseData["antwoord_ja_nee"] as List<dynamic>;

        if (antwoordJaNeeData.isNotEmpty) {
          // Maak een kaart (Map) om gegevens per week op te slaan
          final weeklyData = <int, Map<String, int>>{};

          for (final row in antwoordJaNeeData) {
            final data = row as Map<String, dynamic>;
            final weeknummer = int.parse(data["weeknummer"].toString());

            if (!weeklyData.containsKey(weeknummer)) {
              weeklyData[weeknummer] = {
                "ja": 0,
                "nee": 0,
              };
            }

            final jaValue = int.parse(data["ja"].toString());
            final neeValue = int.parse(data["nee"].toString());

            // Voer null-checks uit voordat je de waarden toevoegt
            weeklyData[weeknummer]!["ja"] = (weeklyData[weeknummer]!["ja"] ?? 0) + jaValue;
            weeklyData[weeknummer]!["nee"] = (weeklyData[weeknummer]!["nee"] ?? 0) + neeValue;
          }

          print("Gegevens per week opgehaald: $weeklyData");

          return weeklyData;
        }
      }
    }
    return null;
  } catch (e) {
    print('Fout bij het ophalen van gegevens: $e');
    return null;
  }
}














