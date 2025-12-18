import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedTagsViewer extends StatefulWidget {
  final List<String> tags;

  const AnimatedTagsViewer({super.key, required this.tags});

  @override
  State<AnimatedTagsViewer> createState() => _AnimatedTagsViewerState();
}

class _AnimatedTagsViewerState extends State<AnimatedTagsViewer> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.tags.length > 1) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.tags.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tags.isEmpty) {
      return _buildText("SIN ETIQUETAS");
    }

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final offsetAnimation = Tween<Offset>(
          begin: Offset(0.0, 0.5),
          end: Offset.zero,
        ).animate(animation);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey<String>(widget.tags[_currentIndex]),
        child: _buildText(widget.tags[_currentIndex].toUpperCase()),
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}