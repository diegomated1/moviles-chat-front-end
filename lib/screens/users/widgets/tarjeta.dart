library tarjeta;

import 'package:chat_client/screens/profile/profile.screen.dart';
import 'package:chat_client/widgets/IconImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../../widgets/button.dart';

class Tarjeta extends StatefulWidget{
  const Tarjeta({
    super.key,
    required this.fullname,
    required this.email,
  });

  final String fullname;
  final String email;

  @override
  State<StatefulWidget> createState() => _Tarjeta();
}

class _Tarjeta extends State<Tarjeta>{

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 100,
      child: Row(
        children: [
          IconImage(image: widget.email, width: 80, height: 80,),
          const SizedBox(width: 10,),
          SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.fullname,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(widget.email)
              ],
            ),
          ),
          Button(
            width: 70, height: 70, radius: 50, handler: (){
              Get.to(()=> const Profile(), arguments: widget.email);
            },
            child: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
