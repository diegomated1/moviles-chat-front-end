


import 'package:chat_client/models/user.model.dart';
import 'package:flutter/material.dart';

import '../../../widgets/IconImage.dart';

class ChatHeaderInfo extends StatelessWidget{
  const ChatHeaderInfo({
    super.key,
    required this.user
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconImage(image: (user!=null)?user!.email:null),
        const SizedBox(width: 10,),
        Column(
          children: [
            Text(
              user!=null?('${user!.name} ${user!.secondName}'):'',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              user!=null?user!.email:'',
              style: const TextStyle(fontSize: 12),
            )
          ],
        )
      ],
    );
  }
}

