import 'package:flutter/material.dart';
import 'package:path_animation/widget/path_animation.dart';
import 'dart:math' as math;

class VortexAnimation extends StatefulWidget {
  const VortexAnimation({super.key});

  @override
  State<VortexAnimation> createState() => _VortexAnimationState();
}

class _VortexAnimationState extends State<VortexAnimation>
    with TickerProviderStateMixin {
  late List<Path> particlePaths;
  final random = math.Random();
  final String _modeName = 'Quantum Vortex';

  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  double _vortexIntensity = 0.8;
  double _vortexSpeed = 0.8;
  final int _particleCount = 200;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: math.pi * 2,
    ).animate(_rotationController);

    particlePaths = _createParticlePaths();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  List<Path> _createParticlePaths() {
    final List<Path> paths = [];

    for (int i = 0; i < _particleCount; i++) {
      final Path vortexPath = Path();

      final double startAngle =
          (i / _particleCount) * math.pi * 2 + random.nextDouble() * 0.2;

      final double startRadius = 30 + random.nextDouble() * 120;
      final double startX = math.cos(startAngle) * startRadius;
      final double startY = math.sin(startAngle) * startRadius;

      vortexPath.moveTo(startX, startY);

      double currentRadius = startRadius;
      double currentAngle = startAngle;

      for (int j = 0; j < 30; j++) {
        currentRadius =
            math.max(3, currentRadius - (startRadius / 25) * _vortexIntensity);

        currentAngle += 0.3 * _vortexSpeed * (1 + (j / 30)); // 随着向内，旋转速度增加

        final double x = math.cos(currentAngle) * currentRadius;
        final double y = math.sin(currentAngle) * currentRadius;

        vortexPath.lineTo(x, y);
      }

      paths.add(vortexPath);
    }

    return paths;
  }

  Color _getParticleColor(int index) {
    final double hue = (index / _particleCount * 120 + 80) % 360; // 从绿色到青色的渐变

    return HSLColor.fromAHSL(
      0.8,
      hue,
      0.8,
      0.5 + random.nextDouble() * 0.5,
    ).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_modeName Animation'),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.green.withOpacity(0.1),
                  Colors.black,
                ],
                radius: 0.7,
                center: Alignment.center,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 15,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value * 0.1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        for (int i = 0; i < particlePaths.length; i++)
                          PathAnimation(
                            path: particlePaths[i],
                            duration: Duration(
                              milliseconds: 3000 + (i % 5) * 1000,
                            ),
                            repeat: true,
                            curve: Curves.easeInOut,
                            drawPath: false,
                            child: Container(
                              width: 2.0 + random.nextInt(3).toDouble(),
                              height: 2.0 + random.nextInt(3).toDouble(),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _getParticleColor(i),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        _getParticleColor(i).withOpacity(0.7),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Vortex Intensity',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                Slider(
                  value: _vortexIntensity,
                  min: 0.5,
                  max: 2.0,
                  divisions: 5,
                  activeColor: Colors.greenAccent,
                  inactiveColor: Colors.green.withOpacity(0.3),
                  onChanged: (value) {
                    setState(() {
                      _vortexIntensity = value;
                      particlePaths = _createParticlePaths();
                    });
                  },
                ),
                Text(
                  'Vortex Speed',
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
                Slider(
                  value: _vortexSpeed,
                  min: 0.5,
                  max: 2.0,
                  divisions: 5,
                  activeColor: Colors.greenAccent,
                  inactiveColor: Colors.green.withOpacity(0.3),
                  onChanged: (value) {
                    setState(() {
                      _vortexSpeed = value;
                      particlePaths = _createParticlePaths();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
