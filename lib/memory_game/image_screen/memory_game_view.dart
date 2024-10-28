import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../play_board_screen/memory_game_play_view.dart';
import 'memory_game_controller.dart';

class MemoryGameView extends GetView<MemoryGameController> {
  const MemoryGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images Screen'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: GetBuilder<MemoryGameController>(
          init: MemoryGameController(),
          builder: (memoryGameController) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: Obx(() {
                      return controller.selectedImages.isEmpty
                          ? const Center(child: Text('Select Image'))
                          : GridView.builder(
                              padding: const EdgeInsets.all(8.0),
                              itemCount: controller.selectedImages.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.file(
                                      controller.selectedImages[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            );
                    }),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: const Text('Select Images'),
                    onPressed: controller.getImages,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: const Text('Start'),
                    onPressed: () {
                      if (controller.selectedImages.isNotEmpty) {
                        Get.to(() => MemoryGamePlayView(
                              selectedImages: controller.selectedImages
                                  .toList(), // Pass a copy of the list
                            ));
                      } else {
                        Get.snackbar(
                          'No Images Selected',
                          'Please select images to continue',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
