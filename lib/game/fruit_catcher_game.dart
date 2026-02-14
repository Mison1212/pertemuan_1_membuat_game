import 'dart:math';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/basket.dart';
import 'components/fruit.dart';
import 'managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Basket basket;
  final Random random = Random();

  double fruitSpawnTimer = 0;
  final double fruitSpawnInterval = 1.5;

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  int _score = 0;
  bool _isGameOver = false;

  int get score => _score;
  set score(int value) {
    _score = value;
    scoreNotifier.value = value;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(resolution: Vector2(400, 800));

    basket = Basket();
    await add(basket);

    await AudioManager().playBackgroundMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_isGameOver) return;

    fruitSpawnTimer += dt;
    if (fruitSpawnTimer >= fruitSpawnInterval) {
      spawnFruit();
      fruitSpawnTimer = 0;
    }
  }

  void spawnFruit() {
    final double x = random.nextDouble() * size.x;
    final fruit = Fruit(position: Vector2(x, -50));
    add(fruit);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    if (_isGameOver) return;

    basket.position.x += info.delta.global.x;

    basket.position.x = basket.position.x.clamp(
      basket.size.x / 2,
      size.x - basket.size.x / 2,
    );
  }

  void onTapDown(TapDownInfo info) {
    if (_isGameOver) {
      restart();
    }
  }

  void incrementScore() {
    score++;
    AudioManager().playSfx('collect.mp3');
  }

  void checkGameOver(Fruit fruit) {
    if (fruit.position.y > size.y && !_isGameOver) {
      _isGameOver = true;
      gameOver();
    }
  }

  void gameOver() {
    AudioManager().playSfx('explosion.mp3');
  }

  void restart() {
    _isGameOver = false;
    _score = 0;
    scoreNotifier.value = 0;
    fruitSpawnTimer = 0;

    // Hapus semua fruit
    children.whereType<Fruit>().forEach((fruit) => fruit.removeFromParent());

    AudioManager().playBackgroundMusic();
  }

  @override
  void onRemove() {
    AudioManager().stopBackgroundMusic();
    super.onRemove();
  }

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_isGameOver) {
      // Semi-transparent overlay
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x, size.y),
        Paint()..color = Colors.black.withOpacity(0.5),
      );

      // Game Over text
      final textPainter = TextPainter(
        text: const TextSpan(
          text: 'GAME OVER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(size.x / 2 - textPainter.width / 2, size.y / 2 - 80),
      );

      // Score text
      final scorePainter = TextPainter(
        text: TextSpan(
          text: 'Score: $_score',
          style: const TextStyle(color: Colors.white, fontSize: 32),
        ),
        textDirection: TextDirection.ltr,
      );
      scorePainter.layout();
      scorePainter.paint(
        canvas,
        Offset(size.x / 2 - scorePainter.width / 2, size.y / 2 - 10),
      );

      // Tap to restart text
      final restartPainter = TextPainter(
        text: const TextSpan(
          text: 'Tap Screen to Restart',
          style: TextStyle(color: Colors.yellow, fontSize: 24),
        ),
        textDirection: TextDirection.ltr,
      );
      restartPainter.layout();
      restartPainter.paint(
        canvas,
        Offset(size.x / 2 - restartPainter.width / 2, size.y / 2 + 60),
      );
    }
  }
}
