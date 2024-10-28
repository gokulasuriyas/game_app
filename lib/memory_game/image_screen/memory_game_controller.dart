import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MemoryGameController extends GetxController {
  final ImagePicker picker = ImagePicker();
  RxList<File> selectedImages = <File>[].obs;

  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      // Create a temporary list to hold the new images
      List<File> newImages = pickedFiles.map((file) => File(file.path)).toList();
      // Add new images to the observable list
      selectedImages.addAll(newImages);
    } else {
      Get.snackbar(
        'Nothing Selected',
        'Please select images to continue',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}