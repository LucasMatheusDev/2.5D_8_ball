import 'package:flutter/material.dart';
import 'package:magic_8_ball/magic_8_ball.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Magic 8 ball',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Magic8BallApp());
  }
}

/// The main container for the whole shebang
class Magic8BallApp extends StatelessWidget {
  /// Default constructor
  const Magic8BallApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The MAGIC 8-Ball',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('The 2.5D 8-Ball'),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: const [
              Magic8Ball(),
            ],
          ),
        ),
      ),
    );
  }
}
