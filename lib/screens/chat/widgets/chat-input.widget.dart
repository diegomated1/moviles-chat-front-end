

import 'package:chat_client/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/utils.dart';
import '../../../widgets/button.dart';

class ChatInput extends StatefulWidget{
  const ChatInput({
    super.key,
    required this.sendMessage,
    required this.user,
    required this.otherUser
  });

  final Function({
    required String emailUserAddresse,
    required String emailUserSender,
    required String title,
    required String message,
  }) sendMessage;
  final UserModel? user;
  final UserModel? otherUser;

  @override
  State<StatefulWidget> createState() => _ChatInput();
}

class _ChatInput extends State<ChatInput>{

  final TextEditingController textController = TextEditingController();
  var sendForm = GlobalKey<FormState>();
  String mensaje = "";

  submit(BuildContext context)async{
    if(widget.user!=null && widget.otherUser!=null){
      if(sendForm.currentState!.validate()){
        sendForm.currentState!.save();
        widget.sendMessage(
          emailUserAddresse: widget.otherUser!.email,
          emailUserSender: widget.user!.email,
          title: "titulo",
          message: mensaje
        );
        textController.clear();
        setState(() {
          mensaje = "";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Form(
          key: sendForm,
          child: Container (
            width: 320,
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: textController,
              onSaved: (value){
                mensaje = value ?? '';
              },
              decoration: InputDecoration(
                labelText: 'Envia un mensaje...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              ),
            ),
          ),
        ),
        Button(
          width: 70, height: 70, radius: 50, handler: (){submit(context);},
          child: const Icon(Icons.send),
        )
      ],
    );
  }
}
