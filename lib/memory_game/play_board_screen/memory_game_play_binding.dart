import 'package:get/get.dart';

import 'memory_game_play_controller.dart';

class MemoryGamePlayBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MemoryGamePlayController>(()=>MemoryGamePlayController());
  }
}