import 'package:flutter/material.dart';
import 'package:localnotes/api/sqlsavetimes.dart';
import 'package:localnotes/getdata.dart';

class TakeMedicationPage extends StatelessWidget {
  const TakeMedicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication"),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(children: [
              const Text("Heeft u uw medicatie ingenomen?"),
              const SizedBox(height: 20,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: ()async{
                      updateJaTeller();
                      await loadYesNo();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacementNamed('/stats');
                    }, child: const Text('JA')),
                    const SizedBox(width: 20),
                    ElevatedButton(onPressed: () async{
                      updateNeeTeller();
                      await loadYesNo();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushReplacementNamed('/stats');
                    }, child: const Text('NEE'))
                ],),
              )
            ]),
          ),
        ],
      ),
    );
  }
}