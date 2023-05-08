import 'dart:math';

import 'package:flutter/material.dart';

Color getColor({double opa = 0.2}){
  Random rd = Random();
  return Color.fromRGBO(rd.nextInt(255), rd.nextInt(255), rd.nextInt(255), opa);
}