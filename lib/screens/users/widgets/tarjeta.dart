library tarjeta;

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_client/screens/profile/profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../../widgets/photo.dart';

class Tarjeta extends StatefulWidget{
  const Tarjeta({
    super.key,
    required this.email,
    required this.fullname,
    required this.jobOcupation,
    required this.numberPhone
  });
  
  final String email;
  final String fullname;
  final String jobOcupation;
  final String numberPhone;

  @override
  State<StatefulWidget> createState() => _Tarjeta();
}

class _Tarjeta extends State<Tarjeta>{

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return SizedBox(
        height: (width >= 380) ? 150 : (width*150)/380,
        child: Center(
          child: 
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 5.0,
                )
              ]
            ),
            width: 360,
            height: (width >= 380) ? 120 : (width*120)/380,
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      //width: 120,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Photo(email: widget.email,),
                      )
                    ),
                    Expanded(
                      flex: 2,
                      //width: 240,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Color.fromARGB(255, 234, 234, 234),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Info(title: 'Nombre completo', text: widget.fullname),
                              const Divider(height: 0.5, thickness: 1,),
                              Info(title: 'Cargo', text: widget.jobOcupation),
                              const Divider(height: 0.5, thickness: 1,),
                              Info(title: 'Telefono', text: widget.numberPhone),
                            ],
                          ),
                        ),
                      )
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    color: getColor(),
                    child: IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Get.to(()=>const Profile(), arguments: widget.email);
                      },
                    ),
                  )
                )
              ]
            ),
          ),
        )
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.title,
    required this.text
  });

  final String title;
  final String text;
  
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 6.0, left: 5.0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 3.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: (width >= 380) ? 8 : (width*8)/380,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: (width >= 380) ? 15 : (width*15)/380
                ),
              )
            ),
          ],
        )
      )
    ); 
  }

}