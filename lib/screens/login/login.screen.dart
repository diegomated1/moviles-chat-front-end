import 'package:chat_client/screens/loading/loading.screen.dart';
import 'package:chat_client/screens/profile/profile.screen.dart';
import 'package:chat_client/screens/register/register.screen.dart';
import 'package:chat_client/services/chat-api-service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/button.dart';
import '../../widgets/input.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {

  late Map<String, String> userInfo = {
    "email": '',
    "password": '',
  };

  change(String label, String newValue){
    userInfo[label.split(' ').join('_').toLowerCase()] = newValue;
  }

  var loginForm = GlobalKey<FormState>();

  submit(BuildContext context)async{
    if(loginForm.currentState!.validate()){
      loginForm.currentState!.save();
      final prefs = await SharedPreferences.getInstance();
      String? fcmToken = prefs.getString('FcmToken');
      var sessionToken = await ChatApi().login(email: userInfo['email']!, password: userInfo['password']!, tokenFCM: fcmToken!);
      if(sessionToken!=null){
        prefs.setString('sessionToken', sessionToken);
        Get.to(()=>const LoadingScreen());
      }else{
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid credentials'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
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
          child: Form(
            key: loginForm,
            child: Column(
              children: [
                Input(labelText: 'Email', handler: change, width: 330,),
                Input(labelText: 'Password', handler: change, hidden: true, width: 330),
                Button(labelText: 'Login', handler: (){
                  submit(context);
                },),
                Button(labelText: 'Register', handler: (){
                  Get.to(()=>const Register());
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }

}