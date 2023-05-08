import 'package:chat_client/models/message.model.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {

  ChatWidget({
    super.key,
    required this.messages,
    required this.sender
  });
  
  final MessagesModel messages;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.messages.length,
      itemBuilder: (context, index) {
        final message = messages.messages[index];

        return Align(
          alignment: message.emailUserSender==sender ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: message.emailUserSender==sender ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message.message,
              style: TextStyle(
                color: message.emailUserSender==sender ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
