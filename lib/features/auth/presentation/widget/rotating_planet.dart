import 'package:flutter/material.dart';

class RotatingPlanet extends StatefulWidget {
  const RotatingPlanet({super.key});

  @override
  State<RotatingPlanet> createState() => _RotatingPlanetState();
}

class _RotatingPlanetState extends State<RotatingPlanet>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 80),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Color(0xFF192233),
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xFF324467)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF135bec).withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: -5,
            )
          ],
        ),
        child: Image.asset(
          'assets/image/saturn_planet.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
