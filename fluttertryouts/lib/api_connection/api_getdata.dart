// In this file I get information from the database I am using.

import 'package:fluttertryouts/strings/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

int totalMessages = 0;
  // Initialize a variable to store the info for Benazepril
  // String selectedMedicationInfo = '';

// Fetch data function
Future<void> fetchData() async {
  // Make variables to use
  final Uri url = Uri.parse('http://192.168.24.101/api_service_chatbot/connection_api.php');
  // Get data from the url
  final response = await http.get(url);

  // Checking if the response is okay
  if (response.statusCode == 200) {
    // Decode JSON into a map
    Map<String, dynamic> jsonData = json.decode(response.body);
    // Collect data and process it
    List<dynamic> data_hartmedicijn = jsonData['hartmedicijn'];
    List<dynamic> data_savedmessages = jsonData['savedmessages'];
    // List<dynamic> data_savedtimes = jsonData['savedtimes'];
    // print(data);

    int numberMessages = data_savedmessages.length;
    print(numberMessages);

    totalMessages = numberMessages;
    

    // Find the info for Benazepril
    // for (var item in data) {
    //   String medicijnNaam = item['medicijn_naam'];
    //   String medicijnInfo = item['info'];
    //   // When the name is in the database the selected medicine from the popup will giv its info and saves it in selectedMedicationInfo
    //   if (medicijnNaam == medicineChoice) {
    //     selectedMedicationInfo = medicijnInfo;
    //     break;
    //   }
    // }
// Making a for loop to search for data and to put it into item.
    for (var item in data_hartmedicijn) {
      String medicijnNaam = item['medicijn_naam'];
      String medicijnInfo = item['info'];
      String medicijnAndereMedicatie = item['andere_medicatie'];
      String medicijnBijwerkingen = item['bijwerkingen'];
      String medicijnGebruik = item['gebruik'];
      String medicijnInnameTijd = item['inname_tijd'];
      String medicijnVergeten = item['vergeten'];
      String medicijnStoppen = item['stoppen'];
      String medicijnRecept = item['recept'];

      medicationInfoMap[medicijnNaam] = medicijnInfo;
      medicationAndereMedMap[medicijnNaam] = medicijnAndereMedicatie;
      medicationBijwerkingenMap[medicijnNaam] = medicijnBijwerkingen;
      medicationGebruikMap[medicijnNaam] = medicijnGebruik;
      medicationInnameTijdMap[medicijnNaam] = medicijnInnameTijd;
      medicationVergetenMap[medicijnNaam] = medicijnVergeten;
      medicationStoppenMap[medicijnNaam] = medicijnStoppen;
      medicationReceptMap[medicijnNaam] = medicijnRecept;
    }
    // Collect the data_hartmedicijn from the map with the chosen name of the medicine and puts it into the string selectedmedicationinfo
    
    // Print the information for the selected medication
    // print('Info over geselecteerde medicatie: $selectedMedicationInfo');
    // print('Andere medicatie voor geselecteerde medicatie: $selectedMedicationAndere');
    // print('Bijwerkingen van geselecteerde medicatie: $selectedMedicationBijwerkingen');
    // print('Gebruik van geselecteerde medicatie: $selectedMedicationGebruik');
    // print('Inname tijd van geselecteerde medicatie: $selectedMedicationInnameTijd');
    // print('Vergeten van geselecteerde medicatie: $selectedMedicationVergeten');
    // print('Stoppen met geselecteerde medicatie: $selectedMedicationStoppen');
    // print('Recept voor geselecteerde medicatie: $selectedMedicationRecept');

    // Print the info for Benazepril
    // print('Info over Benazepril: $selectedMedicationInfo');

    // Create a for loop to collect all the data_hartmedicijn
    // This loop is for all the info about the medicine
    for (var item in data_hartmedicijn) {
      // Add the medicine name to the list
      String medicijnNaam = item['medicijn_naam'];
      String medicijnInfo = item['info'];
      if (!medicijnNamenGlobal.contains(medicijnNaam)) {
        medicijnNamenGlobal.add(medicijnNaam);
      }
      if(!medicijnInfoGlobal.contains(medicijnInfo)){
        medicijnInfoGlobal.add(medicijnInfo);
      }
    }

    // print('Fetched data_hartmedicijn: $data_hartmedicijn');
    
    // This one is for the use with other medication
    for (var item in data_hartmedicijn) {
      // Add the medicine name to the list
      String medicijnNaam = item['medicijn_naam'];
      String medicijnAndereMedicatie = item['andere_medicatie'];
      if (!medicijnAndereMedsGlobal.contains(medicijnNaam)) {
        medicijnAndereMedsGlobal.add(medicijnNaam);
      }
      if(!medicijnAndereMedsGlobal.contains(medicijnAndereMedicatie)){
        medicijnAndereMedsGlobal.add(medicijnAndereMedicatie);
      }
    }

    // This one is for the side effects
    for (var item in data_hartmedicijn) {
      // Add the medicine name to the list
      String medicijnNaam = item['medicijn_naam'];
      String medicijnBijwerkingen = item['bijwerkingen'];
      if (!medicijnBijwerkingenGlobal.contains(medicijnNaam)) {
        medicijnBijwerkingenGlobal.add(medicijnNaam);
      }
      if(!medicijnBijwerkingenGlobal.contains(medicijnBijwerkingen)){
        medicijnBijwerkingenGlobal.add(medicijnBijwerkingen);
      }
    }

    // This one is for the use use of the medication
    for (var item in data_hartmedicijn) {
      // Add the medicine name to the list
      String medicijnNaam = item['medicijn_naam'];
      String medicijnGebruik = item['gebruik'];
      if (!medicijnGebruikGlobal.contains(medicijnNaam)) {
        medicijnGebruikGlobal.add(medicijnNaam);
      }
      if(!medicijnGebruikGlobal.contains(medicijnGebruik)){
        medicijnGebruikGlobal.add(medicijnGebruik);
      }
    }

    // This one is for the time of use
    for (var item in data_hartmedicijn) {
      // Add the medicine name to the list
      String medicijnNaam = item['medicijn_naam'];
      String medicijnInnameTijd = item['inname_tijd'];
      if (!medicijnInnameTijdGlobal.contains(medicijnNaam)) {
        medicijnInnameTijdGlobal.add(medicijnNaam);
      }
      if(!medicijnInnameTijdGlobal.contains(medicijnInnameTijd)){
        medicijnInnameTijdGlobal.add(medicijnInnameTijd);
      }
    }

    // This one is for if you forgot your medicine
    for (var item in data_hartmedicijn) {
      // Add the medicine name to the list
      String medicijnNaam = item['medicijn_naam'];
      String medicijnVergeten = item['vergeten'];
      if (!medicijnVergetenGlobal.contains(medicijnNaam)) {
        medicijnVergetenGlobal.add(medicijnNaam);
      }
      if(!medicijnVergetenGlobal.contains(medicijnVergeten)){
        medicijnVergetenGlobal.add(medicijnVergeten);
      }
    }
    
    // This one is for if you forgot your doses.
    for (var item in data_hartmedicijn) {
      // Add the medicine name to the list
      String medicijnNaam = item['medicijn_naam'];
      String medicijnStoppen = item['stoppen'];
      if (!medicijnStoppenGlobal.contains(medicijnNaam)) {
        medicijnStoppenGlobal.add(medicijnNaam);
      }
      if(!medicijnStoppenGlobal.contains(medicijnStoppen)){
        medicijnStoppenGlobal.add(medicijnStoppen);
      }
    }

    // This one is for if you need a recepy for the medicine
    for (var item in data_hartmedicijn) {
      // Add the medicine name to the list
      String medicijnNaam = item['medicijn_naam'];
      String medicijnRecept = item['recept'];
      if (!medicijnReceptGlobal.contains(medicijnNaam)) {
        medicijnReceptGlobal.add(medicijnNaam);
      }
      if(!medicijnReceptGlobal.contains(medicijnRecept)){
        medicijnReceptGlobal.add(medicijnRecept);
      }
    }

    // Print all medicine names
    // print('Alle medicijnnamen: $medicijnNamenGlobal');
    // print('Alle info: $medicijnInfoGlobal');
  } else {
    // If not can be loaded
    throw Exception('Failed to load data_hartmedicijn');
  }
}






