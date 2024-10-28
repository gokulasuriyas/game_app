import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'memory_game_play_controller.dart';

class MemoryGamePlayView extends GetView<MemoryGamePlayController> {
  final List<File> selectedImages;
  final MemoryGamePlayController gameController =
      Get.put(MemoryGamePlayController());

  MemoryGamePlayView({Key? key, required this.selectedImages})
      : super(key: key);

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
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => gameController.flipCard(index),
                  child: Obx(() {
                    bool isFlipped =
                        gameController.flippedIndexes.contains(index) ||
                            gameController.matchedIndexes.contains(index);

                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        final flipAnim =
                            Tween(begin: 1.0, end: 0.0).animate(animation);
                        return AnimatedBuilder(
                          animation: flipAnim,
                          builder: (context, child) {
                            final angle = flipAnim.value * 3.1416;
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(angle),
                              child: flipAnim.value <= 0.5
                                  ? gameCard(index, isFlipped)
                                  : const Icon(Icons.help_outline, size: 48),
                            );
                          },
                        );
                      },
                      child: gameCard(index, isFlipped),
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget gameCard(int index, bool isFlipped) {
    return Card(
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
    );
  }
}
