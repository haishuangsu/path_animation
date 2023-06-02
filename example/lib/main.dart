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
  late Path path;

  @override
  void initState() {
    path = Path()..addOval(const Rect.fromLTWH(100, 100, 100, 100));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PathAnimation(
        path: path,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        curve: Curves.decelerate,
        drawPath: true,
        pathColor: Colors.red,
        pathWidth: 1,
        child: const Icon(
          Icons.flutter_dash,
          size: 30,
        ),
      ),
    );
  }
}
