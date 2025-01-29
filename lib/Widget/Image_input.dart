import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickedimage});

  final void Function(File image) onPickedimage;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  Future<String> saveImageLocally(File image) async {
    final directory = await getApplicationDocumentsDirectory();

    String fileName = path.basename(image.path);

    final localImage = File('${directory.path}/$fileName');

    await image.copy(localImage.path);

    return localImage.path;
  }

  File? selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final takenImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (takenImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(takenImage.path);
    });

    if (selectedImage != null) {
      saveImageLocally(selectedImage!);
    }
    widget.onPickedimage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      label: Text('add your image '),
      icon: Icon(Icons.camera),
    );
    if (selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
      ),
      alignment: Alignment.center,
      child: content,
    );
  }
}
