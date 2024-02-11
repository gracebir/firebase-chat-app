import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  ChatBubble({super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
