import 'package:chat_client/models/message.model.dart';
import 'package:chat_client/screens/users/users.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.model.dart';
import '../../services/chat-api-service.dart';
import '../login/login.screen.dart';


class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _Chat();
}

class _Chat extends State<Chat>{

  UserModel? user;
  UserModel? otherUser;
  MessagesModel messages = MessagesModel.fromJson([]);

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
          setState(() {
            user = selfUserApi;
            otherUser = otherUserApi;
            messages = messagesApi;
          });
        }else{
          Get.to(()=>const Users());
        }
      }catch(error){
        Get.to(()=>const Login());
      }
    }
    handleAllInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Container()
    );
  }
}