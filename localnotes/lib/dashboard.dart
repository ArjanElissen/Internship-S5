import 'package:flutter/material.dart';
import 'package:localnotes/textfield_for_settings.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
        String formatTime(TimeOfDay? time) {
      if (time != null) {
        return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
      } else {
        return '';
      }
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                  children: [
                    Text('Meldingen:\nTijdstip 1: ${formatTime(selectedTimes[0])} \nTijdstip 2: ${formatTime(selectedTimes[1])}\nTijdstip 3: ${formatTime(selectedTimes[2])}', textAlign: TextAlign.left,),
                  ],
                ),
            ),
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pushNamed('/stats');
                  }, child: const Text("check stats"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}