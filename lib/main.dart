import 'package:flutter/material.dart';
import 'tacquin.dart';
import 'tictactoe.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameToy',
      home: MyHomePage(
        title: "GameToy",
      ),
      routes: <String, WidgetBuilder>{
        '/route1': (BuildContext context) => MyHomePage(
              title: 'GameToy',
            ),
        '/route2': (BuildContext context) => Tacquin(),
        '/route3': (BuildContext context) => TicTacToe(),
      },
    );
  }
}
