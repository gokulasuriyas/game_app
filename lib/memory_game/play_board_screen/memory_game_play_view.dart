import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'memory_game_play_controller.dart';

class MemoryGamePlayView extends GetView<MemoryGamePlayController>  {
  final List<File> selectedImages;
  final MemoryGamePlayController gameController = Get.put(MemoryGamePlayController());

  MemoryGamePlayView({Key? key, required this.selectedImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    gameController.initializeGame(selectedImages);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: 600,
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: gameController.gameImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  bool isFlipped = gameController.flippedIndexes.contains(index) ||
                      gameController.matchedIndexes.contains(index);

                  return GestureDetector(
                    onTap: () => gameController.flipCard(index),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isFlipped
                            ? Image.file(
                          gameController.gameImages[index],
                          fit: BoxFit.cover,
                        )
                            : Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.help_outline, size: 48),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
      ),
    );
  }
}