import 'package:flutter/material.dart';

class FilterToggle extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onFilterChanged;
  const FilterToggle({super.key, required this.selected, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: SegmentedButton(
        segments: [
          ButtonSegment(label: Text('Все'), value: 'all'),
          ButtonSegment(label: Text('Завершённые'), value: 'done')
        ],
        selected: {selected},
        onSelectionChanged: (values) {
          onFilterChanged(values.first);
        },
      ),
    );
  }
}

