import 'package:flutter/material.dart';
import 'package:path_animation/widget/path_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'path_animation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'path_animation Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Path ovalPath = Path()..addOval(const Rect.fromLTWH(100, 80, 100, 100));
  Path rectPath = Path()..addRect(const Rect.fromLTWH(100, 80, 100, 100));
  Path bezierPath = Path()
    ..cubicTo(50.0, 0.0, 100.0, 120.0, 200.0, 0.0)
    ..cubicTo(200.0, 0.0, 250.0, 200.0, 400.0, 0.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          PathAnimation(
            path: ovalPath,
            duration: const Duration(milliseconds: 2000),
            repeat: true,
            reverse: false,
            curve: Curves.decelerate,
            drawPath: true,
            pathColor: Colors.red,
            pathWidth: 1,
            child: const Icon(
              Icons.flutter_dash,
              size: 30,
            ),
          ),
          const SizedBox(height: 100),
          PathAnimation(
            path: rectPath,
            duration: const Duration(milliseconds: 3000),
            repeat: true,
            reverse: true,
            curve: Curves.bounceInOut,
            drawPath: true,
            pathColor: Colors.blue,
            pathWidth: 1,
            child: const Icon(
              Icons.flutter_dash,
              size: 30,
            ),
          ),
          const SizedBox(height: 200),
          PathAnimation(
            path: bezierPath,
            duration: const Duration(milliseconds: 3000),
            curve: Curves.fastOutSlowIn,
            repeat: true,
            reverse: false,
            drawPath: true,
            pathColor: Colors.purpleAccent,
            pathWidth: 1,
            child: const Icon(
              Icons.flutter_dash,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
