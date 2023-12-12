import 'package:flutter/material.dart';
import 'package:fluttertryouts/strings/strings.dart';
// import 'package:fluttertryouts/components/settimepopup.dart';
import 'package:fluttertryouts/timefunctions/savetime.dart';
// import 'package:fluttertryouts/timefunctions/savetime.dart';

List<TimeOfDay> medicationTimes = [TimeOfDay.now()]; // Initialize with current time
String chosenMedicine = medicineChoice;

String formatTimeOfDay(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

void pushNotesmenu(BuildContext context) {
  int numberOfMedicationsPerDay = 1; // Default value

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: 200,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Herinneringen',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20),
                Text(
                  'Wilt u meldingen aanzetten die helpen bij het gebruik van $chosenMedicine?',
                  style: const TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  height: 600,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Tijdsloten meldingen',
                                        style: TextStyle(fontSize: 16.0),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        width: 130,
                                        child: TextFormField(
                                          readOnly: true,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'Aantal per dag',
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.arrow_upward),
                                                  onPressed: () {
                                                    setState(() {
                                                      numberOfMedicationsPerDay++;
                                                      medicationTimes.add(TimeOfDay.now());
                                                    });
                                                  },
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.arrow_downward),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (numberOfMedicationsPerDay > 1) {
                                                        numberOfMedicationsPerDay--;
                                                        medicationTimes.removeLast();
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          controller: TextEditingController(
                                              text: numberOfMedicationsPerDay.toString()),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: medicationTimes.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Tijd ${index + 1}:',
                                                    style: const TextStyle(fontSize: 16.0),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      TimeOfDay? selectedTime = await showTimePicker(
                                                        context: context,
                                                        initialTime: medicationTimes[index],
                                                        builder: (BuildContext context, Widget? child) {
                                                          return MediaQuery(
                                                            data: MediaQuery.of(context).copyWith(
                                                              alwaysUse24HourFormat: true,
                                                            ),
                                                            child: child!,
                                                          );
                                                        },
                                                      );

                                                      if (selectedTime != null) {
                                                        setState(() {
                                                          medicationTimes[index] = selectedTime;
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      formatTimeOfDay(medicationTimes[index]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.green),
                                                ),
                                                onPressed: () {
                                                  // Roep de saveMedicationTimes-functie aan uit SetupPushNotes en gebruik de juiste context.
                                                  saveMedicationTimes(medicationTimes);
                                                  Navigator.pop(context); // Als dat nodig is.
                                                },
                                                child: const Text("Opslaan"),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.red),
                                                ),
                                                onPressed: () {
                                                  // Roep Navigator.pop aan om het scherm te sluiten.
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Annuleren"),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: const Text("Ja"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Nee"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
