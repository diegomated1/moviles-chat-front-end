

import 'dart:io';

import 'package:chat_client/models/message.model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.model.dart';

class ChatApi {
  String url = dotenv.env['CHAT_SERVER_URL']!;

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
      var body = json.encode({"email": email, "password": password, "tokenFCM": tokenFCM});
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

  Future<String?> register({required UserModel user, required String token, required String password, File? imageFile}) async {
    try{
      var headers = {
        "Content-type": "multipart/form-data",
      };
      Map<String, String> body = {...user.toMap(), "token": token, "password": password};
      final request = http.MultipartRequest('POST', Uri.parse('$url/register'));
      request.headers.addAll(headers);

      if(imageFile!=null){
        final image = await http.MultipartFile.fromPath('user_image', imageFile.path);
        request.files.add(image);
      }

      request.fields.addAll(body);

      var response = await request.send();
      if(response.statusCode == 200){
        final responseBody = await response.stream.bytesToString();
        return json.decode(responseBody)['data'];
      } else {
        return null;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<UserModel?> getByEmail({required String email}) async {
    try{
      var headers = {
        "Content-type": "application/json",
      };

      var response = await http.get(Uri.parse('$url/users/$email'), headers: headers);
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

  Future<bool> deleteToken({required String email, required String tokenFCM}) async {
    try{
      var headers = {
        "Content-type": "application/json",
      };
      var body = json.encode({"token": tokenFCM});
      var response = await http.put(Uri.parse('$url/users/$email'), headers: headers, body: body);
      if(response.statusCode == 200){
        return true;
      } else {
        return false;
      }
    }catch(e){
      print(e.toString());
      return false;
    }
  }

}

