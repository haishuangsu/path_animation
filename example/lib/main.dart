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
      title: 'Solar System Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Solar System Animation'),
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
  late final Path mercuryPath;
  late final Path venusPath;
  late final Path earthPath;
  late final Path marsPath;

  @override
  void initState() {
    super.initState();
    _initPlanetPaths();
  }

  void _initPlanetPaths() {
    mercuryPath = Path()..addOval(const Rect.fromLTWH(0, 0, 100, 100));

    venusPath = Path()..addOval(const Rect.fromLTWH(0, 0, 160, 160));

    earthPath = Path()..addOval(const Rect.fromLTWH(0, 0, 220, 220));

    marsPath = Path()..addOval(const Rect.fromLTWH(0, 0, 280, 280));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.yellow, Colors.orange, Colors.red],
                ),
              ),
            ),
            PathAnimation(
              path: mercuryPath,
              duration: const Duration(seconds: 2),
              repeat: true,
              curve: Curves.linear,
              drawPath: true,
              pathColor: Colors.grey.withOpacity(0.3),
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
            ),
            PathAnimation(
              path: venusPath,
              duration: const Duration(seconds: 4),
              repeat: true,
              curve: Curves.linear,
              drawPath: true,
              pathColor: Colors.orange.withOpacity(0.3),
              child: Container(
                width: 15,
                height: 15,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
              ),
            ),
            PathAnimation(
              path: earthPath,
              duration: const Duration(seconds: 6),
              repeat: true,
              curve: Curves.linear,
              drawPath: true,
              pathColor: Colors.blue.withOpacity(0.3),
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
            PathAnimation(
              path: marsPath,
              duration: const Duration(seconds: 8),
              repeat: true,
              curve: Curves.linear,
              drawPath: true,
              pathColor: Colors.red.withOpacity(0.3),
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
