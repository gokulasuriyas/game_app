import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'flash_card_game/flash_card_view.dart';
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
      home: MemoryGameView(),
    );
  }
}







