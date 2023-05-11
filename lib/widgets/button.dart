import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.width = 200,
    this.height = 60,
    this.fontSize = 22,
    this.labelText = 'Empty',
    this.padding = 10.0,
    required this.handler
  });

  final String labelText;
  final double width;
  final double height;
  final double fontSize;
  final double padding;
  final Function() handler;

  @override
  Widget build(BuildContext context) { 
    return Container (
      padding: EdgeInsets.all(padding),
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // color de fondo del botón
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // margen interno del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // curvatura de los bordes
          ),
          
        ),
        onPressed: handler,
        child: Text(
          labelText,
          style: TextStyle(
            fontSize: fontSize
          ),  
        ),
      ),
    );
  } 
}