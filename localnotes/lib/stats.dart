import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:localnotes/getdata.dart';

class CheckStats extends StatefulWidget {
  const CheckStats({Key? key}) : super(key: key);

  @override
  _CheckStatsState createState() => _CheckStatsState();
}

class _CheckStatsState extends State<CheckStats> {
  String statusText = '';
  int currentWeek = 1;
  Map<int, Map<String, int>> weeklyData = {};

  void goToNextWeek() {
    setState(() {
      currentWeek = (currentWeek % 52) + 1;
    });
  }

  void goToPreviousWeek() {
    setState(() {
      if (currentWeek == 1) {
        currentWeek = 52;
      } else {
        currentWeek--;
      }
    });
  }

  void updateWeeklyData() {
    // Roep de functie aan om de gegevens op te halen
    loadYesNo2().then((data) {
      if (data != null) {
        setState(() {
          weeklyData = data;
          checkAndPrintStatus();
        });
      }
    });
  }

  void checkAndPrintStatus(){
  final totalJa = weeklyData[currentWeek]?['ja'] ?? 0;
  final totalNee = weeklyData[currentWeek]?['nee'] ?? 0;
  final total = totalJa + totalNee;
  final percentageJa = total > 0 ? (totalJa / total) * 100 : 0;

  if (percentageJa >= 90) {
    statusText = 'Je bent goed bezig';
  } else if(percentageJa <= 60) {
    statusText = 'je bent niet goed bezig';
  }
  else if(totalJa == 0 && totalNee == 0){
    statusText = 'er is (nog) geen data beschikbaar';
  }else{
    statusText = 'Probeer je reeks voort te zetten';
    }
}

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final year = now.year;
    final firstDayOfYear = DateTime(year, 1, 1);
    final days = now.difference(firstDayOfYear).inDays;
    currentWeek = (days / 7).ceil();

    updateWeeklyData();
    checkAndPrintStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistieken - Week $currentWeek"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text("Aantal x ingenomen"),
                      const SizedBox(height: 20),
                      // Gebruik de gegevens per week om "ja" weer te geven
                      Text("${weeklyData[currentWeek]?['ja'] ?? 0}", style: const TextStyle(fontSize: 30),),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text("Aantal x niet ingenomen"),
                      const SizedBox(height: 20),
                      // Gebruik de gegevens per week om "nee" weer te geven
                      Text("${weeklyData[currentWeek]?['nee'] ?? 0}", style: const TextStyle(fontSize: 30),),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60,),
            Container(child: Text(statusText, style: const TextStyle(fontSize: 24),),)
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                goToPreviousWeek();
                updateWeeklyData(); // Haal gegevens op voor de nieuwe week
              },
            ),
            Text("Week $currentWeek"),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                goToNextWeek();
                updateWeeklyData(); // Haal gegevens op voor de nieuwe week
              },
            ),
          ],
        ),
      ),
    );
  }
}

