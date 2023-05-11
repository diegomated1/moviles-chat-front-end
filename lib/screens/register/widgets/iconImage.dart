

import 'dart:io';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class IconImage extends StatelessWidget{
  const IconImage({
    super.key,
    required this.image,
    required this.handler
  });

  final File? image;
  final dynamic Function() handler;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: getColor(),  
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: (image!=null) ? 
            ClipOval(
              child: Image.file(
                File(image!.path),
                fit: BoxFit.cover,
              ),
            ) :
            const Icon(Icons.person)
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: handler,
        ),
      ],
    );
  }

}


