import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.width = 200,
    this.height = 60,
    this.fontSize = 22,
    this.labelText = 'Empty',
    this.padding = 10.0,
    this.radius = 16.0,
    this.child,
    required this.handler
  });

  final double radius;
  final String labelText;
  final double width;
  final double height;
  final double fontSize;
  final double padding;
  final Function() handler;

  final Widget? child;

  @override
  Widget build(BuildContext context) { 
    return Container (
      padding: EdgeInsets.all(padding),
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: handler,
        child: 
        (child!=null) ? 
          child : 
          Text(
            labelText,
            style: TextStyle(
              fontSize: fontSize
            ),  
          ), 
      ),
    );
  } 
}