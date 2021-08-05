import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future imageCropper(XFile file) async {
  return await ImageCropper.cropImage(
    sourcePath: file.path,
    aspectRatioPresets: [CropAspectRatioPreset.square],
    androidUiSettings: AndroidUiSettings(
      toolbarTitle: 'Crop profile picture',
      toolbarColor: Colors.black,
      toolbarWidgetColor: Colors.white,
      backgroundColor: Colors.black,
      initAspectRatio: CropAspectRatioPreset.square,
      hideBottomControls: true,
    ),
  );
}

Future<File?> pickAndCompressImage(ImagePicker imagePicker) async {
  final XFile? profilePictureFile = await imagePicker.pickImage(
    source: ImageSource.gallery,
  );
  if (profilePictureFile != null) {
    final croppedProfilePicture = await imageCropper(profilePictureFile);
    final directory = await getApplicationDocumentsDirectory();
    return FlutterImageCompress.compressAndGetFile(
      croppedProfilePicture.path,
      '${directory.path}/profile_picture_${DateTime.now().millisecondsSinceEpoch}.jpg',
      format: CompressFormat.jpeg,
      minHeight: 160,
      minWidth: 160,
    );
  }
}
