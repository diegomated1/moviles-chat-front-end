import 'package:chat_client/models/user.model.dart';
import 'package:chat_client/screens/profile/profile.screen.dart';
import 'package:chat_client/services/chat-api-service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/button.dart';
import '../../widgets/input.dart';

class Register extends StatefulWidget{
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {

  late Map<String, String> userInfo = {
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
      var sessionToken = await ChatApi().register(user: UserModel.fromJson(userInfo));
      if(sessionToken!=null){
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('sessionToken', sessionToken);
        Get.to(()=>const Profile());
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
                Input(labelText: 'Email', handler: change),
                Row(
                  children: [
                    Input(labelText: 'Name', handler: change, width: 165,),
                    Input(labelText: 'Second Name', handler: change, width: 165,),
                  ],
                ),
                Input(labelText: 'Job Ocupation', handler: change),
                Input(labelText: 'Number Phone', handler: change, type: TextInputType.number,),
                Input(labelText: 'Password', handler: change, hidden: true,),
                Button(labelText: 'Register', handler: (){
                  submit(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

}