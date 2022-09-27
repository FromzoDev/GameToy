import 'dart:async';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: Colors.grey[900],
        child: RotationTransition(
          turns: _animation,
          child: Icon(
            Icons.sports_esports,
            size: 200.0,
            color: Color.fromARGB(255, 192, 192, 192),
          ),
        ));
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Text(
          "GameToy",
          style: TextStyle(
            color: Color.fromARGB(255, 192, 192, 192),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[900], // background
                  onPrimary: Colors.grey[850], // foreground
                ),
                onPressed: (() => Navigator.pushNamed(context, "/route3")),
                child: Text(
                  "TicTacToe",
                  style: TextStyle(
                      color: Color.fromARGB(255, 192, 192, 192),
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                )),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.grey[900], // background
              onPrimary: Colors.grey[850], // foreground
            ),
            onPressed: (() => Navigator.pushNamed(context, "/route2")),
            child: Text(
              "Tacquin",
              style: TextStyle(
                  color: Color.fromARGB(255, 192, 192, 192),
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      )),
    );
  }
}
