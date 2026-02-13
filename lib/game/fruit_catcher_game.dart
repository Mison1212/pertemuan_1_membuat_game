import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame {
  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);

  @override
  Color backgroundColor() => const Color(0xFF87CEEB); 

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    AudioManager().playBackgroundMusic();
  }

  void incrementScore() {
    scoreNotifier.value++;
  }
}
