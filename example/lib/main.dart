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
  Path ovalPath = Path()..addOval(const Rect.fromLTWH(0, 0, 100, 100));
  Path rectPath = Path()..addRect(const Rect.fromLTWH(0, 0, 100, 100));
  Path bezierPath = Path()
    ..moveTo(0.0, 0.0)
    ..quadraticBezierTo(20.0, 70.0, 200, 60);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Stack(
              children: [
                PathAnimation(
                  path: ovalPath,
                  duration: const Duration(milliseconds: 8000),
                  repeat: true,
                  reverse: false,
                  curve: Curves.linear,
                  drawPath: true,
                  pathColor: Colors.red,
                  pathWidth: 1,
                  child: const Icon(
                    Icons.flutter_dash,
                    size: 30,
                  ),
                ),
                PathAnimation(
                  path: ovalPath,
                  duration: const Duration(milliseconds: 3000),
                  repeat: true,
                  reverse: false,
                  curve: Curves.linear,
                  drawPath: true,
                  pathColor: Colors.red,
                  pathWidth: 1,
                  startAnimatedPercent: 0.25,
                  child: const Icon(
                    Icons.flutter_dash,
                    size: 30,
                  ),
                ),
                PathAnimation(
                  path: ovalPath,
                  duration: const Duration(milliseconds: 3000),
                  repeat: true,
                  reverse: false,
                  curve: Curves.linear,
                  drawPath: true,
                  pathColor: Colors.red,
                  pathWidth: 1,
                  startAnimatedPercent: 0.5,
                  child: const Icon(
                    Icons.flutter_dash,
                    size: 30,
                  ),
                ),
                PathAnimation(
                  path: ovalPath,
                  duration: const Duration(milliseconds: 6000),
                  repeat: true,
                  reverse: false,
                  curve: Curves.linear,
                  drawPath: true,
                  pathColor: Colors.red,
                  pathWidth: 1,
                  startAnimatedPercent: 0.75,
                  child: GestureDetector(
                    onTap: () {
                      debugPrint('Tap from oval path');
                    },
                    child: const Icon(
                      Icons.flutter_dash,
                      color: Colors.redAccent,
                      size: 30,
                    ),
                  ),
                ),
              ],
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
          const SizedBox(height: 100),
          PathAnimation(
            path: bezierPath,
            duration: const Duration(milliseconds: 8000),
            curve: Curves.linear,
            repeat: true,
            reverse: false,
            drawPath: true,
            pathColor: Colors.purpleAccent,
            pathWidth: 1,
            startAnimatedPercent: 0.25,
            child: GestureDetector(
              onTap: () {
                debugPrint('Tap from bezier path');
              },
              child: const Icon(
                Icons.flutter_dash,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
