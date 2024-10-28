import 'package:get/get.dart';
import 'word_search_controller.dart';

class WordSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WordSearchController>(() => WordSearchController());
  }
}
