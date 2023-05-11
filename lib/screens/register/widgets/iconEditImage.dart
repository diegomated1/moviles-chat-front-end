

import 'dart:io';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../../widgets/IconImage.dart';

class IconEditImage extends StatelessWidget{
  const IconEditImage({
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
        IconImage(image: image, width: 80, height: 80,),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: handler,
        ),
      ],
    );
  }

}


