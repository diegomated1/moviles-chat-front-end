import 'package:chat_client/models/message.model.dart';
import 'package:chat_client/screens/chat/widgets/chat.widget.dart';
import 'package:chat_client/screens/users/users.screen.dart';
import 'package:chat_client/services/socket.service.dart';
import 'package:chat_client/widgets/button.dart';
import 'package:chat_client/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.model.dart';
import '../../services/chat-api-service.dart';
import '../../utils/utils.dart';
import '../login/login.screen.dart';


class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Chat();
}

class _Chat extends State<Chat>{

  UserModel? user;
  UserModel? otherUser;
  MessagesModel messages = MessagesModel.fromJson([]);
  SocketConnection? socket;

  var sendForm = GlobalKey<FormState>();
  String mensaje = "";

  submit(BuildContext context)async{
    if(user!=null && otherUser!=null){
      if(sendForm.currentState!.validate()){
        sendForm.currentState!.save();
        sendMessage(
          emailUserAddresse: otherUser!.email,
          emailUserSender: user!.email,
          title: "titulo",
          message: mensaje
        );
        setState(() {
          mensaje = "";
        });
      }
    }
  }
   
  @override
  void initState() {
    super.initState();
    handleAllInfo() async {
      try{
        final String? email = Get.arguments;
        final prefs = await SharedPreferences.getInstance();
        final sessionToken = prefs.getString('sessionToken');
        if(sessionToken==null){
          Get.to(()=>const Login());
          return;
        }
        if(email!=null){
          var selfUserApi = await ChatApi().auth(sessionToken: sessionToken);
          var otherUserApi = await ChatApi().getByEmail(email: email);
          if(selfUserApi==null){
            Get.to(()=>const Login());
            return;
          }
          if(otherUserApi==null){
            Get.to(()=>const Users());
            return;
          }
          var messagesApi = await ChatApi().getMessages(
            sender: selfUserApi.email,
            addressee: otherUserApi.email
          );
          if(mounted){
            setState(() {
              user = selfUserApi;
              otherUser = otherUserApi;
              messages = messagesApi;
              socket = SocketConnection(selfUserApi.email, otherUserApi.email);
            });
            socketEvents();
          }
        }else{
          Get.to(()=>const Users());
        }
      }catch(error){
        print(error.toString());
        Get.to(()=>const Login());
      }
    }
    handleAllInfo();
  }

  sendMessage({
		required String emailUserAddresse,
		required String emailUserSender,
		required String title,
		required String message	
	}){
    if(socket!=null){
      Map<String, String> newMessage = {
        "email_user_addresse": emailUserAddresse,
        "email_user_sender": emailUserSender,
        "title": title,
        "message": message
      };
      socket!.socket!.emit('chat:message', newMessage);
    }
  }

  socketEvents(){
    if(socket!=null){
      socket!.socket!.on('chat:message', (newMessage) {
        MessageModel message = MessageModel.fromJson(newMessage);
        if(mounted){
          setState(() {
            messages.messages.add(message);
          });
        }
      });
      socket!.socket!.on('chat:error', (message){
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$message'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((otherUser!=null) ? otherUser!.email : 'Chat'),
      ),
      body: (user!=null) ?
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: getColor(),
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: ChatWidget(messages: messages, sender: user!.email)
              ),
            ),
            SizedBox(
              height: 100,
              child: Container(
                color: getColor(),
                child: Row(
                  children: [
                    Form(
                      key: sendForm,
                      child: Container (
                        width: 300,
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onSaved: (value){
                            mensaje = value ?? '';
                          },
                          decoration: const InputDecoration(
                            labelText: 'Escribe un mensaje',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Button(labelText: '>', width: 80, height: 80, handler: (){
                      submit(context);
                    })
                  ],
                ),
              ),
            )
          ],
        )
        : const Center(child: Text('Cargando'),)
    );
  }
}