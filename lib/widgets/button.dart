import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.width = 80,
    this.height = 330,
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
      height: width,
      width: height,
      child: ElevatedButton(
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