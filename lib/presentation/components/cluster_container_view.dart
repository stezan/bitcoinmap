import 'package:flutter/material.dart';

class ClusterContainer extends StatelessWidget {
  final int markerCount;

  const ClusterContainer({super.key, required this.markerCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Text(
          markerCount.toString(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
