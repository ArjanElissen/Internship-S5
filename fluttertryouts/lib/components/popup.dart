import 'package:fluttertryouts/components/setuppushnotes.dart';
import 'package:fluttertryouts/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertryouts/standaardtext.dart/berichten.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Popup {
  static String? selectedMedication;
  String welcomeMessage = MessageResponses.getWelcomeMessage();

  static void showPopup(BuildContext context, List<String> medicijnNamen, Function() onConfirm) {
    // Retrieve the saved medication from SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      selectedMedication = prefs.getString('selectedMedication');
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Kies uw medicatie',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(height: 0),
                  Expanded(
                    child: ListView(
                      children: [
                        ExpansionTile(
                          title: const Text('Hartfalen'),
                          children: medicijnNamen.map((String value) {
                            return ListTile(
                              title: Row(
                                children: [
                                  Text(value),
                                  const Spacer(),
                                  if (value == selectedMedication)
                                    const Icon(Icons.check, color: Colors.green),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  // Toggle the selected medication
                                  selectedMedication = value == selectedMedication ? null : value;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: selectedMedication != null
                        ? () async {
                            // Close the bottom sheet and return the selected medication
                            Navigator.of(context).pop(selectedMedication);
                            onConfirm();
                            pushNotesmenu(context);

                            // Save the selected medication locally using SharedPreferences
                            await saveSelectedMedication(selectedMedication);

                            if (selectedMedication != null) {
                              medicineChoice = selectedMedication!;
                              print(selectedMedication);
                              processDataChoice(selectedMedication);
                              print(selectedMedicationInfo);
                            } else {
                              print('Geen medicatie geselecteerd.');
                            }
                          }
                        : null,
                    child: const Text('Bevestigen'),
                  ),
                ],
              );
            },
          );
        },
      ).then((value) {});
    });
  }

  // Functions to save the chosen medicine
  static Future<void> saveSelectedMedication(String? medication) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (medication != null) {
      await prefs.setString('selectedMedication', medication);
      print('hello: $selectedMedicationInfo');
    } else {
      await prefs.remove('selectedMedication');
    }
     print('Selected medication saved: $medication');
     print(selectedMedicationInfo);
  }

  // Function to call the saved medicine
  static Future<String?> getSavedMedication() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('selectedMedication');
}
}
