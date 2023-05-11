import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ModalSelectTypeImage extends StatefulWidget {
  const ModalSelectTypeImage({
    super.key,
    required this.setImage
  });

  final void Function(File? image) setImage;

  @override
  State createState() => _ModalSelectTypeImage();
}

class _ModalSelectTypeImage extends State<ModalSelectTypeImage> {

  final picker = ImagePicker();

  // Función para tomar una foto con la cámara
  Future<void> _deletePhoto() async {
    widget.setImage(null);
    if(!mounted) return;
    Navigator.pop(context);
  }

  // Función para tomar una foto con la cámara
  Future<void> _takePhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    widget.setImage(File(pickedFile!.path));
    if(!mounted) return;
    Navigator.pop(context);
  }

  // Función para seleccionar una imagen de la galería
  Future<void> _chooseFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    widget.setImage(File(pickedFile!.path));
    if(!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.remove),
            title: const Text('Eliminar foto'),
            onTap: _deletePhoto,
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Tomar foto'),
            onTap: _takePhoto,
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Seleccionar de la galería'),
            onTap: _chooseFromGallery,
          ),
        ],
      ),
    );
  }
}
