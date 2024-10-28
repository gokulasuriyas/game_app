import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'word_search_controller.dart';

class WordSearchView extends GetView<WordSearchController> {
  WordSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Enter '),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
    child: GetBuilder<WordSearchController>(
    init: WordSearchController(),
    builder: (wordSearchController) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.textController,
              decoration: const InputDecoration(
                labelText: 'Enter a word',
                border: OutlineInputBorder(),
              ),
              onChanged: controller.updateWord,
            ),
            const SizedBox(height: 20),
            Obx(() =>
                Text(
                  'Entered word: ${controller.enteredWord}',
                  style: const TextStyle(fontSize: 16),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // This will trigger an action in the controller if needed
                controller.startGame();
              },
              child: const Text('Start'),
            ),
          ],
        ),

      );
    }
      ),
      ),
    );
  }
}
