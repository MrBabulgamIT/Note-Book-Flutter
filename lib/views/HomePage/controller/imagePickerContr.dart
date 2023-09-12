import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ImagePickerController extends GetxController {
  var imagePath = "".obs;

  Future<void> imagePicker(var imageSource) async {
    final pickerFile = await ImagePicker().pickImage(source: imageSource);
    if (pickerFile != null) {
      imagePath.value = pickerFile.path;
    }
  }

  Future<String?> uploadFirstoreData() async {
    if (imagePath.value.isEmpty) {
      return null;
    }

    final storage = firebase_storage.FirebaseStorage.instance;
    final storageRef = storage.ref().child('images/${DateTime.now()}.jpg');

    try {
      final file = File(imagePath.value);

      final image = img.decodeImage(file.readAsBytesSync());

      final compressedImage =
          img.copyResize(image!, height: image.height, width: image.width);

      final compressedFile =
          File('${file.parent.path}/compressed_${DateTime.now()}.jpg')
            ..writeAsBytesSync(img.encodeJpg(compressedImage, quality: 50));
      await storageRef.putFile(compressedFile);

      final downloadURL = await storageRef.getDownloadURL();
      imagePath.value = downloadURL;

      Get.snackbar(
        'Upload Complete',
        'Image has been successfully uploaded!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error uploading image: $e');
      Get.snackbar(
        'Upload Error',
        'Error uploading image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return null;
  }
}
