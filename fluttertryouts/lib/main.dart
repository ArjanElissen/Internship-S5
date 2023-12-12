import 'package:flutter/material.dart';
import 'package:fluttertryouts/api_connection/api_connect.dart';
import 'package:fluttertryouts/api_connection/api_getdata.dart';
import 'package:fluttertryouts/components/popup.dart';
// import 'package:fluttertryouts/connect_mysql.dart';
import 'package:fluttertryouts/pages/homePage.dart';
import 'package:fluttertryouts/strings/strings.dart';

// void main runs the project. without it the app won't run. I call fetchdata which collects the data from the database immediatly 
void main() async {
  // Ensure that Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch the data before running the app
  await fetchData();
  // Print API host connection
  print(API.hostConnection);

  // Get the saved medication name
  String? savedMedication = await Popup.getSavedMedication();

  // Check if there is already a savedmedicine and check it in the console
  if (savedMedication != null) {
    print('Saved medication: $savedMedication');
     savedMedication2 = savedMedication;
  } else {
    print('No saved medication found.');
  }

  // Run the app
  runApp(const MainApp());
  // Call the function for a saved value medicine
  processDataChoice(savedMedication);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Shows the homepage.dart when starting the app
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
