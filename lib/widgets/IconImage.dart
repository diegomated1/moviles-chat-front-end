


import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/utils.dart';

class IconImage extends StatelessWidget{
  IconImage({
    super.key,
    this.height = 40,
    this.width = 40,
    required this.image
  });

  final double height;
  final double width;
  final dynamic image;
  String url = dotenv.env['CHAT_SERVER_URL']!;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: getColor(),  
        borderRadius: BorderRadius.circular(height)
      ),
      child: (image is File) ? 
        ClipOval(
          child: Image.file(
            File(image!.path),
            fit: BoxFit.cover,
          ),
        ) :
        (image is String) ?
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: '$url/images/$image',
            fit: BoxFit.cover,
            errorWidget: ((context, url, error) {
              return const Icon(Icons.person);
            }),
          )
        ) :
        const Icon(Icons.person)
    );
  }
}


