import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/controllers/menu_app_controller.dart';
import '../../../core/utils/responsive.dart';
import 'toggle_switch.dart';

class ActivityHeader extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onToggle;

  const ActivityHeader({
    super.key,
    required this.selectedIndex,
    required this.onToggle,
  });

  final List<String> options = const [
    "Billing Queue",
    "Table",
    "Order History"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context)) ...[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: context.read<MenuAppController>().controlMenu,
            ),
            SizedBox(
              width: 10,
            )
          ],
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Hoạt động",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " / ${options[selectedIndex]}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          ToggleSwitchWidget(
            options: options,
            onToggle: onToggle,
            selectedIndex: selectedIndex,
          ),
        ],
      ),
    );
  }
}
