import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleSwitchWidget extends StatelessWidget {
  final Function(int) onToggle;
  final int selectedIndex;
  final List<String> options;

  const ToggleSwitchWidget(
      {super.key,
      required this.onToggle,
      required this.selectedIndex,
      required this.options});


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ToggleSwitch(
      minWidth: 120.0,
      minHeight: 40,
      cornerRadius: 30.0,
      activeBgColors: [
        [colors.primary],
        [colors.primary],
        [colors.primary]
      ],
      activeFgColor: Colors.white,
      inactiveBgColor: colors.secondary,
      initialLabelIndex: selectedIndex,
      totalSwitches: options.length,
      labels: options,
      radiusStyle: true,
      onToggle: (index) {
        onToggle(index!);
      },
    );
  }
}
