import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  const Modal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(), // Muestra un indicador de carga circular.
          SizedBox(height: 16), // Añade un espacio vertical de 16 píxeles.
          Text('Verificando sesión...'), // Muestra el mensaje "Verificando sesión...".
        ],
      ),
    );
  }
}