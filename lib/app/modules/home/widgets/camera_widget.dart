import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterflow_project/app/modules/home/home_store.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/styles/colors.dart';

class CameraWidget extends StatefulWidget {
  final HomeStore store;
  CameraWidget({super.key, required this.store});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed() async {
    try {
      widget.store.setIsLoading(true);
      final pickedFile = await _picker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
      setState(() {
        _imageFile = pickedFile;
      });

      widget.store.setIsLoading(false);
    } catch (e) {
      final _pickImageError = 'An error occurred: $e';
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Ops'),
              content: Text(_pickImageError),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: widget.store.isLoading
          ? CircularProgressIndicator()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _onImageButtonPressed();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.camera_alt),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: const Text('Take a selfie'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: _imageFile != null
                      ? Image.file(File(_imageFile!.path))
                      : Icon(
                          Icons.image,
                          size: 100,
                          color: AppColor.lightGrey,
                        ),
                ),
              ],
            ),
    );
  }
}
