import 'package:chat_client/screens/loading/loading.screen.dart';
import 'package:chat_client/screens/login/login.screen.dart';
import 'package:chat_client/screens/register/register.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _showNotification(RemoteMessage message) async {
  final title = message.data['title'];
  final body = message.data['message'];
  const notiDetails = AndroidNotificationDetails(
    'your channel id', 'your channel name',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker'
  );
      
  const platformChannelSpecifics = NotificationDetails(android: notiDetails);
  await FlutterLocalNotificationsPlugin().show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: message.data.toString()
  );
}


Future<dynamic> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Mensaje recibido en segundo plano: ${message.data}");
  await _showNotification(message);
  return Future.value(true);
}

void main() async {

  

  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  var androidIni = const AndroidInitializationSettings('mipmap/ic_launcher');
  var iniSet = InitializationSettings(android: androidIni);
  await FlutterLocalNotificationsPlugin().initialize(iniSet);
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("FcmToken", fcmToken??'123');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingScreen()
    );
  }
}
