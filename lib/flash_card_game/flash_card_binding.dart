import 'package:get/get.dart';

import 'flash_card_controller.dart';

class FlashCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FlashCardController>(() => FlashCardController());
  }
}
