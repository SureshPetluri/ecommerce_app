import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Map<String, dynamic>> pickImageFromCameraOrGallery(
  BuildContext context,
  List<String> extensions,
) async {
  String base64Image = "";
  String image = "";
  String statusMessage = "Error";
  if (!kIsWeb) {
    final picker = ImagePicker();
    String source = await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context, 'Camera'),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      size: 40,
                    ),
                    Text('Camera'),
                  ],
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context, 'Gallery'),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.image,
                      size: 40,
                    ),
                    Text('Gallery'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    if (source.isNotEmpty) {
      XFile? pickedFile;
      if (source == 'Camera') {
        int imageQuality = 100;
        pickedFile = await picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 50,
            maxHeight: 500,
            maxWidth: 500,
            requestFullMetadata: false);
        if (pickedFile != null) {
          Uint8List imageBytes = await File(pickedFile.path).readAsBytes();
          base64Image = base64Encode(imageBytes);
          image = pickedFile.name;
          int imageSizeInBytes = imageBytes.length;
          if (imageSizeInBytes > 500 * 1024) {
            imageQuality -= 10;
            statusMessage =
                "Document size is >500KB. Please upload file less than 500KB";
          } else {
            statusMessage = "OK";
          }

          print("base64Image camera....$imageQuality");
        }
      } else if (source == 'Gallery') {
        pickedFile = await picker.pickImage(
          source: ImageSource.gallery,
        );
        if (pickedFile != null) {
          Uint8List imageBytes = await File(pickedFile.path).readAsBytes();
          base64Image = base64Encode(imageBytes);
          image = pickedFile.name;
          int imageSizeInBytes = imageBytes.length;
          statusMessage = imageSizeInBytes > 500 * 1024
              ? "Document size is >500KB. Please upload file less than 500KB"
              : "OK";
          print("base64Image camera....$imageSizeInBytes");
        }
      }
    }
  } else {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions, //['jpg', 'jpeg', 'png', "pdf"] ,
    );

    if (result != null && result.files.isNotEmpty) {
      Uint8List imageBytes =
          result.files.single.bytes ?? Uint8List.fromList([]);
      image = result.files.single.name;
      base64Image = base64Encode(imageBytes);
      int fileSizeInBytes = result.files.single.size;

      double fileSizeInKB = fileSizeInBytes / 1024;
      statusMessage = (fileSizeInKB > 500)
          ? "Document size is >500KB. Please upload file less than 500KB"
          : "OK";

      print("File size: $fileSizeInKB KB");
    }
  }
  return {
    "base64Image": base64Image,
    "image": image,
    "statusMessage": statusMessage
  };
}
