import 'dart:io';

import 'package:chat_client/models/user.model.dart';
import 'package:chat_client/screens/profile/profile.screen.dart';
import 'package:chat_client/screens/register/widgets/iconEditImage.dart';
import 'package:chat_client/screens/register/widgets/modalImage.dart';
import 'package:chat_client/services/chat-api-service.dart';
import 'package:chat_client/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  File? _imageFile;

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
      var sessionToken = await ChatApi().register(
        user: UserModel.fromJson({...userInfo, "tokens": []}),
        token: fcmToken!,
        password: userInfo['password'],
        imageFile: _imageFile
      );
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

  void setImage(File? newImage){
    setState(() {
      _imageFile = newImage;
    });
  }

  void showModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalSelectTypeImage(setImage: setImage,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: FittedBox(
          child: Form(
            key: loginForm,
            child: Column(
              children: [
                SizedBox(
                  width: 330,
                  height: 80,
                  child: Align(
                    alignment: Alignment.center,
                    child: IconEditImage(
                      image: _imageFile, 
                      handler: () {
                        showModal();
                      },
                    )
                  )
                ),
                Input(labelText: 'Email', handler: change, icon: Icons.email,),
                Row(
                  children: [
                    Input(labelText: 'Name', handler: change, width: 165,),
                    Input(labelText: 'Second Name', handler: change, width: 165,),
                  ],
                ),
                Input(labelText: 'Job Ocupation', handler: change, icon: Icons.work,),
                Input(labelText: 'Number Phone', handler: change, type: TextInputType.number, icon: Icons.numbers),
                Input(labelText: 'Password', handler: change, hidden: true, icon: Icons.lock),
                Button(labelText: 'Register', handler: (){
                  submit(context);
                }),
                const SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    text: '¿Ya tienes una cuenta? ',
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Inicia Sesion',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(()=> const Login());
                          },
                      ),
                    ]
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}