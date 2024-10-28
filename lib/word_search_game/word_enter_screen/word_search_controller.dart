import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WordSearchController extends GetxController {
  final textController = TextEditingController();
  var enteredWord = ''.obs;

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  // Update observable when text changes
  void updateWord(String value) {
    enteredWord.value = value;
  }

  // Method to start the game or perform an action on button press
  void startGame() {
    print('Entered word: ${enteredWord.value}');
    // Additional logic to transition to game or handle input
  }
}
