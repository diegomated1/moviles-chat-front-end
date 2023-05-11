import 'package:chat_client/models/user.model.dart';
import 'package:chat_client/screens/profile/profile.screen.dart';
import 'package:chat_client/services/chat-api-service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/button.dart';
import '../../widgets/input.dart';
import '../loading/loading.screen.dart';
import '../login/login.screen.dart';

class Register extends StatefulWidget{
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {

  late Map<String, dynamic> userInfo = {
    "email": '',
    "name": '',
    "second_name": '',
    "job_ocupation": '',
    "number_phone": '',
    "password": ''
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
      var sessionToken = await ChatApi().register(user: UserModel.fromJson({...userInfo, "tokens": []}), token: fcmToken!, password: userInfo['password']);
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
                Input(labelText: 'Email', handler: change, width: 330),
                Row(
                  children: [
                    Input(labelText: 'Name', handler: change, width: 165,),
                    Input(labelText: 'Second Name', handler: change, width: 165,),
                  ],
                ),
                Input(labelText: 'Job Ocupation', handler: change, width: 330),
                Input(labelText: 'Number Phone', handler: change, type: TextInputType.number, width: 330),
                Input(labelText: 'Password', handler: change, hidden: true, width: 330),
                Button(labelText: 'Register', handler: (){
                  submit(context);
                }),
                Button(labelText: 'Login', handler: (){
                  Get.to(()=>const Login());
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }

}