import 'package:flutter/material.dart';
import 'package:pertemuan_1_membuat_game/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Fruit Catcher Game', home: GameScreen());
  }
}
