// I create a receivedbubble which I can use in different files

import 'package:flutter/material.dart';

class ReceivedMessageBubble extends StatelessWidget {
  final String message;
  const ReceivedMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 3.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ),
    );
  }
}
