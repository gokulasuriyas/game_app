
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlashCardController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  final TextEditingController frontTextController = TextEditingController();
  final TextEditingController backTextController = TextEditingController();
  var isFrontSide = true.obs;
  var frontText = ''.obs;
  var backText = ''.obs;
  var isCardVisible = false.obs;


  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
  }

  void flipCard() {
    if (isFrontSide.value) {
      controller.forward();
    } else {
      controller.reverse();
    }
    isFrontSide.value = !isFrontSide.value;

  }


  void updateCardText(String front, String back) {
    frontText.value = front.isNotEmpty ? front : 'No front text provided';
    backText.value = back.isNotEmpty ? back : 'No back text provided';

    isCardVisible.value = true;
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
