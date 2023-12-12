import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

final Uri apiUrl = Uri.parse('http://192.168.24.101/api_service_chatbot/connection_api.php'); 

// Voeg deze functie toe om de tijden naar de server te sturen
Future<void> saveTimesOnServer(List<TimeOfDay?> selectedTimes) async {
  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  // Hier formatteer je de tijden als TIME
  final List<String> formattedTimes = [];
  for (TimeOfDay? timeOfDay in selectedTimes) {
    if (timeOfDay != null) {
      final formattedTime = '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
      formattedTimes.add(formattedTime);
    } else {
      formattedTimes.add('00:00'); // Voeg een lege tijd in als de waarde leeg is
    }
  }

  final Map<String, dynamic> requestBody = {
    'action': 'saveTimesOnServer', // Voeg de "action" parameter toe
    'saved_time1': formattedTimes[0],
    'saved_time2': formattedTimes[1],
    'saved_time3': formattedTimes[2],
  };

  final response = await http.post(apiUrl, headers: headers, body: requestBody);

  if (response.statusCode == 200) {
    print('Tijden succesvol opgeslagen in de database.\n$requestBody');
  } else {
    print('Fout bij het opslaan van tijden in de database. Statuscode: ${response.statusCode}');
  }
}


void updateJaTeller() async {
  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  final String currentTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  final Map<String, dynamic> requestBody = {
    'action': 'updateJaTeller',
    'response': '1',
    'timestamp': currentTimestamp, // Gebruik de huidige tijdstempel
  };

  final response = await http.post(apiUrl, headers: headers, body: requestBody);

  if (response.statusCode == 200) {
    print('Ja-teller succesvol bijgewerkt in de database.');
  } else {
    print('Fout bij het bijwerken van de Ja-teller in de database: ${response.body}');
  }
}

void updateNeeTeller() async {
  final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  final String currentTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  final Map<String, dynamic> requestBody = {
    'action': 'updateNeeTeller',
    'response': '1',
    'timestamp': currentTimestamp, // Gebruik de huidige tijdstempel
  };

  final response = await http.post(apiUrl, headers: headers, body: requestBody);

  if (response.statusCode == 200) {
    print('nee-teller succesvol bijgewerkt in de database.');
  } else {
    print('Fout bij het bijwerken van de nee-teller in de database: ${response.body}');
  }
}




