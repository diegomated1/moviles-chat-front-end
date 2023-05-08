import 'package:chat_client/models/user.model.dart';
import 'package:chat_client/screens/login/login.screen.dart';
import 'package:chat_client/screens/profile/profile.screen.dart';
import 'package:chat_client/services/chat-api-service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreen();
}

class _LoadingScreen extends State<LoadingScreen> {


  @override
  void initState() {
    super.initState();
    handleAuth() async {
      final prefs = await SharedPreferences.getInstance();
      final sessionToken = prefs.getString('sessionToken');
      if(sessionToken!=null){
        final user = await ChatApi().auth(sessionToken: sessionToken);
        if(user!=null){
          Get.to(()=>const Profile());
        }else{
          Get.to(()=>const Login());
        }
      }else{
        Get.to(()=>const Login());
      } 
    }
    handleAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Verificando sesión...'),
          ],
        ),
      ),
    );
  }
}