import 'dart:io';
import 'package:get/get.dart';

class MemoryGamePlayController extends GetxController {
  late List<File> gameImages;
  var flippedIndexes = <int>[].obs;
  var matchedIndexes = <int>[].obs;

  // Initialize the game by shuffling images and creating pairs
  void initializeGame(List<File> selectedImages) {
    gameImages = (selectedImages + selectedImages)..shuffle();
  }

  // Flip a card at a given index
  void flipCard(int index) {
    if (!flippedIndexes.contains(index) && flippedIndexes.length < 2) {
      flippedIndexes.add(index);
      if (flippedIndexes.length == 2) {
        Future.delayed(Duration(milliseconds: 600), () {
          checkForMatch();
        });
      }
    }
    update();
  }

  // Check if the two flipped cards are a match
  void checkForMatch() {
    if (flippedIndexes.length == 2) {
      final firstImage = gameImages[flippedIndexes[0]];
      final secondImage = gameImages[flippedIndexes[1]];
      if (firstImage.path == secondImage.path) {
        matchedIndexes.addAll(flippedIndexes);
      } else {
        Future.delayed(Duration(milliseconds: 600), () {
          flippedIndexes.clear();
        });
      }
    }
  }
}
