import 'package:chat_client/screens/users/widgets/lista.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class Users extends StatelessWidget{
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Container(
        color: getColor(),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: const Lista(),
      )
    );
  }
}