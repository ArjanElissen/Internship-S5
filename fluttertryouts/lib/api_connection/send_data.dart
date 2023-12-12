// import 'package:fluttertryouts/strings/strings.dart';
import 'package:http/http.dart' as http;

// Future<void> saveUserMessage() async {
//   const String url = 'http://192.168.24.101/api_service_chatbot/connection_api.php'; // Vervang dit door de juiste URL van je server

//   // Stuur een POST-verzoek naar de server met alleen de tekst als de aanvraagbody
//   final response = await http.post(Uri.parse(url), body: {'saved_message': saveTheMessageToSendToDatabase});

//   if (response.statusCode == 200) {
//     // Het bericht is succesvol verzonden en opgeslagen in de database
//     print('Bericht succesvol verzonden en opgeslagen.');
//     // print(saveTheMessageToSendToDatabase);
//   } else {
//     // Er is een fout opgetreden bij het opslaan van het bericht
//     print('Fout bij het verzenden en opslaan van het bericht: ${response.statusCode}');
//   }
//   // print(saveTheMessageToSendToDatabase);
// }

Future<void> saveUserMessage(String message) async {
  const String url = 'http://192.168.24.101/api_service_chatbot/connection_api.php'; // Vervang dit door de juiste URL van je server

  // Stuur een POST-verzoek naar de server met alleen de tekst als de aanvraagbody
  final response = await http.post(Uri.parse(url), body: {'action': 'saveChatMessage', 'saved_message': message});

  if (response.statusCode == 200) {
    // Het bericht is succesvol verzonden en opgeslagen in de database
    print('Bericht succesvol verzonden en opgeslagen.');
  } else {
    // Er is een fout opgetreden bij het opslaan van het bericht
    print('Fout bij het verzenden en opslaan van het bericht: ${response.statusCode}');
  }
}

