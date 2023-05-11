import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.type = TextInputType.text,
    this.width = 330,
    this.padding = 10.0,
    this.hidden = false,
    this.icon = Icons.person,
    required this.labelText,
    required this.handler,
  });

  final TextInputType type;
  final String labelText;
  final double padding;
  final bool hidden;
  final double width;
  final IconData icon;
  final Function(String labelText, String newValue) handler;

  @override
  Widget build(BuildContext context) { 
    return Container (
      width: width,
      padding: EdgeInsets.all(padding),
      child: TextFormField(
        keyboardType: type,
        onSaved: (value){
          handler(labelText, value!);
        },
        validator: (value) {
          if(value!.isEmpty) {
            return "Llena este campo";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
        ),
        obscureText: hidden,
      ),
    );
  } 
}