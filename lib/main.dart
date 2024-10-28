import 'package:flutter/material.dart';
import 'package:game_app/word_search_game/word_enter_screen/word_search_controller.dart';
import 'package:game_app/word_search_game/word_enter_screen/word_search_view.dart';
import 'package:get/get.dart';
import 'memory_game/image_screen/memory_game_view.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flip Card with GetX',
     // home: FlashCardView(),
     // home: MemoryGameView(),
      home: WordSearchView(),

    );
  }
}







