

import 'package:chat_client/models/message.model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.model.dart';

class UsersApi {
  String url = dotenv.env['CHAT_SOCKET_URL']!;

  Future<UserModel?> auth({required String sessionToken}) async {
    try{
      var headers = {
        "Content-type": "application/json",
        "Authorization": "Bearer $sessionToken"
      };

      var response = await http.post(Uri.parse('$url/auth'), headers: headers);
      if(response.statusCode == 200){
        return UserModel.fromJson(json.decode(response.body)['data']);
      } else {
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<String?> login({required String email, required String password, required String tokenFCM}) async {
    try{
      var headers = {
        "Content-type": "application/json",
      };
      var body = json.encode({"email": email, "password": password, "token": tokenFCM});

      var response = await http.post(Uri.parse('$url/login'), headers: headers, body: body);
      if(response.statusCode == 200){
        return json.decode(response.body)['data'];
      } else {
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<String?> register({required UserModel user}) async {
    try{
      var headers = {
        "Content-type": "application/json",
      };
      var body = json.encode(user.toMap());

      var response = await http.post(Uri.parse('$url/register'), headers: headers, body: body);
      if(response.statusCode == 200){
        return json.decode(response.body)['data'];
      } else {
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<UsersModel> getUsers() async {
    try{
      var headers = {
        "Content-type": "application/json",
      };

      var response = await http.get(Uri.parse('$url/users'), headers: headers);
      if(response.statusCode == 200){
        return UsersModel.fromJson(json.decode(response.body)['data']);
      } else {
        return UsersModel.fromJson([]);
      }
    }catch(e){
      print(e.toString());
      return UsersModel.fromJson([]);
    }
  }

  Future<MessagesModel> getMessages({required String sender, required String addressee}) async {
    try{
      var headers = {
        "Content-type": "application/json",
      };

      var response = await http.get(Uri.parse('$url/users/$sender/messages/$addressee'), headers: headers);
      if(response.statusCode == 200){
        return MessagesModel.fromJson(json.decode(response.body)['data']);
      } else {
        return MessagesModel.fromJson([]);
      }
    }catch(e){
      print(e.toString());
      return MessagesModel.fromJson([]);
    }
  }

}

