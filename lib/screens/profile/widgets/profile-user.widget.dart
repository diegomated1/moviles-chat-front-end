

import 'package:chat_client/models/user.model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/chat-api-service.dart';
import '../../../widgets/button.dart';
import '../../login/login.screen.dart';
import '../../users/users.screen.dart';

class ProfileUser extends StatelessWidget{
  const ProfileUser({
    super.key,
    required this.user
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Bienvenido ${user.email}',
          style: const TextStyle(
            fontSize: 20
          ),
        ),
        const SizedBox(height: 20,),
        Button(labelText: 'usuarios', handler: (){
          Get.to(()=>const Users());
        },),
        Button(labelText: 'Cerrar sesion', handler: ()async{
          await ChatApi().deleteToken(email: user.email, tokenFCM: '123');
          final prefs = await SharedPreferences.getInstance();
          prefs.remove('sessionToken');
          Get.to(()=>const Login());
        },)
      ],
    );
  }

}


