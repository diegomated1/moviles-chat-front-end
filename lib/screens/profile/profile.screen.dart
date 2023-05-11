import 'package:chat_client/models/user.model.dart';
import 'package:chat_client/screens/profile/widgets/profile-other.user.widget.dart';
import 'package:chat_client/screens/profile/widgets/profile-user.widget.dart';
import 'package:chat_client/screens/users/users.screen.dart';
import 'package:chat_client/widgets/IconImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/chat-api-service.dart';
import '../../widgets/button.dart';
import '../../widgets/input.dart';
import '../login/login.screen.dart';
import '../users/widgets/tarjeta.dart';

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile>{

  UserModel? user;
  bool isUser = false;

  @override
  void initState() {
    super.initState();
    handleAuth() async {
      try{
        final String? email = Get.arguments;
        if(email!=null){
          var userApi = await ChatApi().getByEmail(email: email);
          setState(() {
            user = userApi;
          });
        }else{
          final prefs = await SharedPreferences.getInstance();
          final sessionToken = prefs.getString('sessionToken');
          if(sessionToken!=null){
            var userApi = await ChatApi().auth(sessionToken: sessionToken);
            setState(() {
              user = userApi;
              isUser = true;
            });
          }else{
            Get.to(()=>const Login());
          }
        }
      }catch(error){
        Get.to(()=>const Login());
      }
    }
    handleAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: FittedBox(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: IconImage(
                  image: (user!=null)?user!.email:null,
                  width: 140, height: 140,
                )
              ),
              const SizedBox(height: 20,),
              (user!=null) ?
                (isUser) ? 
                  ProfileUser(user: user!) :
                  ProfileOtherUser(user: user!)
              : const Text('cargando')
            ],
          )
        ),
      ),
    );
  }
}

