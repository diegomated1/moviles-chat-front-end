import 'package:chat_client/models/user.model.dart';
import 'package:chat_client/services/chat-api-service.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import 'tarjeta.dart';



class Lista extends StatefulWidget{
  const Lista({super.key});

  @override
  State<Lista> createState() => _Lista();
}

class _Lista extends State<Lista> {

  late Future<UsersModel> users;

  @override
  void initState() {
    super.initState();
    handleGetUsers() async {
      final usersApi = ChatApi().getUsers();
      users = usersApi;
    }
    handleGetUsers();
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: users,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.users.length,
            itemBuilder: (BuildContext context, int index){
              return Tarjeta(
                email: snapshot.data!.users[index].email,
                fullname: '${snapshot.data!.users[index].name} ${snapshot.data!.users[index].secondName}',
                jobOcupation: snapshot.data!.users[index].jobOcupation,
                numberPhone: snapshot.data!.users[index].numberPhone
              );
            },
          );
        }else{
          return const Center(
            child: Text('Cargando...'),
          );
        }
      },
    );
  }
}