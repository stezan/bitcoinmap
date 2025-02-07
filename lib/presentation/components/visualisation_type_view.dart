import 'package:flutter/material.dart';

class VisualisationType extends StatefulWidget {
  final ValueChanged<int> onChanged;
  final int initialIndex;

  const VisualisationType({
    super.key,
    required this.onChanged,
    required this.initialIndex,
  });

  @override
  VisualisationTypeState createState() => VisualisationTypeState();
}

class VisualisationTypeState extends State<VisualisationType> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(value: 0, icon: Icon(Icons.map)),
        ButtonSegment(value: 1, icon: Icon(Icons.list)),
      ],
      selected: {selectedIndex},
      onSelectionChanged: (newSelection) {
        setState(() {
          selectedIndex = newSelection.first;
        });
        widget.onChanged(selectedIndex);
      },
    );
  }
}
