import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen ({super.key});

  @override
  State <GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  void initState() {
    super.initState();
  }

  
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Positioned(
          top: 50,
          left: 20,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),

          ), 
        )
      ],
    ),
  );
}
  
}

