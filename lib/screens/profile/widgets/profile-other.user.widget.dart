

import 'package:chat_client/models/user.model.dart';
import 'package:chat_client/screens/chat/chat.screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/chat-api-service.dart';
import '../../../widgets/button.dart';
import '../../login/login.screen.dart';
import '../../users/users.screen.dart';

class ProfileOtherUser extends StatelessWidget{
  const ProfileOtherUser({
    super.key,
    required this.user
  });

  final UserModel user;

  Widget _buildInfoRow(String label, String value) {
    return SizedBox(
      child: Row(
        children: [
          Text('$label: '),
          Text(value)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow("Nombre", user.name),
        _buildInfoRow("Email", user.email),
        _buildInfoRow("Teléfono", user.numberPhone),
        _buildInfoRow("Cargo", user.jobOcupation),
        const SizedBox(height: 20,),
        Button(labelText: 'Chat', handler: (){
          Get.to(()=> Chat(), arguments: user.email);
        },),
      ],
    );
  }
}


