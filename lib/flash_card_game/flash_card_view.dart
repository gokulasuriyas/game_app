import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'flash_card_controller.dart';

class FlashCardView extends GetView<FlashCardController> {
  const FlashCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flash Card Game'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<FlashCardController>(
          init: FlashCardController(),
          builder: (flashCardController) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: flashCardController.frontTextController,
                      decoration: InputDecoration(
                        labelText: 'Front Card Text',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: flashCardController.backTextController,
                      decoration: InputDecoration(
                        labelText: 'Back Card Text',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (flashCardController.frontTextController.text.isEmpty ||
                          flashCardController.backTextController.text.isEmpty) {
                        // Show a snackbar if any field is empty
                        Get.snackbar('Error', 'Please fill in both fields.',
                            snackPosition: SnackPosition.BOTTOM);
                        return; // Do not proceed if fields are empty
                      }

                      flashCardController.updateCardText(
                        flashCardController.frontTextController.text,
                        flashCardController.backTextController.text,
                      );
                      flashCardController.frontTextController.clear();
                      flashCardController.backTextController.clear();
                    },
                    child: Text('Generate Card'),
                  ),
                  SizedBox(height: 20),
                  Obx(() => flashCardController.isCardVisible.value
                      ? GestureDetector(
                    onTap: flashCardController.flipCard,
                    child: AnimatedBuilder(
                      animation: flashCardController.controller,
                      builder: (context, child) {
                        final angle = flashCardController.controller.value * math.pi;
                        final isFront = flashCardController.controller.value < 0.5;
                        return Transform(
                          transform: Matrix4.rotationY(angle),
                          alignment: Alignment.center,
                          child: isFront
                              ? Transform(
                            transform: Matrix4.rotationY(0),
                            alignment: Alignment.center,
                            child: _buildFrontCard(flashCardController),
                          )
                              : _buildBackCard(flashCardController),
                        );
                      },
                    ),
                  )
                      : SizedBox()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFrontCard(FlashCardController flashCardController) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        child: Obx(() => Text(
          flashCardController.frontText.value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }

  Widget _buildBackCard(FlashCardController flashCardController) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 200,
        height: 200,
        alignment: Alignment.center,
        child: Obx(() {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi), // Rotate the text back
            child: Text(
              flashCardController.backText.value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }),
      ),
    );
  }
}
