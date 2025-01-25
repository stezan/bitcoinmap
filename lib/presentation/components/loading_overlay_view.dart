import 'package:flutter/material.dart';

class LoadingOverlayView extends StatefulWidget {
  const LoadingOverlayView({super.key});

  @override
  LoadingOverlayViewState createState() => LoadingOverlayViewState();
}

class LoadingOverlayViewState extends State<LoadingOverlayView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeTransition(
          opacity: _animationController,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.green,
          ),
        ),
        const Center(
          child: Icon(
            Icons.hourglass_empty,
            size: 50,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
