import 'package:chat_client/models/user.model.dart';
import 'package:chat_client/screens/users/users.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/chat-api-service.dart';
import '../../widgets/button.dart';
import '../../widgets/input.dart';
import '../login/login.screen.dart';

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile>{

  late UserModel? user;

  @override
  void initState() {
    super.initState();
    handleAuth() async {
      final prefs = await SharedPreferences.getInstance();
      final sessionToken = prefs.getString('sessionToken');
      if(sessionToken!=null){
        final userApi = await ChatApi().auth(sessionToken: sessionToken);
        if(userApi!=null){
          user = userApi;
        }else{
          Get.to(()=>const Login());
        }
      }else{
        Get.to(()=>const Login());
      } 
    }
    handleAuth();
  }


  handleLogout() async {
    if(user!=null){
      await ChatApi().deleteToken(email: user!.email, tokenFCM: '123');
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('sessionToken');
      Get.to(()=>const Login());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: FittedBox(
          child: Column(
            children: [
              Text(
                (user!=null)?'Bienvenido ${user!.name}':'',
                style: const TextStyle(
                  fontSize: 20
                ),
              ),
              const SizedBox(height: 20,),
              Button(labelText: 'usaurios', handler: (){
                Get.to(()=>const Users());
              },),
              Button(labelText: 'Cerrar sesion', handler: handleLogout,),
            ],
          ),
        ),
      ),
    );
  }
}