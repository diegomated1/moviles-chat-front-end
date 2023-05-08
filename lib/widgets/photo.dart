import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../utils/utils.dart';

class Photo extends StatelessWidget {
  const Photo({
    super.key,
    required this.id
  });

  final String id;

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    String url = 'http://10.153.50.46:3000/images/products';

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 4.0,
            offset: Offset(0.0, 0.75)
          )
        ],
        color: Color.fromARGB(255, 234, 234, 234),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: 
        CachedNetworkImage(
          imageUrl: '$url/$id',
          fit: BoxFit.fill,
          errorWidget: ((context, url, error) {
            return Container(
              color: getColor(),
              child: Icon(
                Icons.person,
                size: (width >= 380) ? 90 : (width*90)/380,
              ),
            );
          }),
        )
      )
    );
  }
  
}