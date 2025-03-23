import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/controllers/menu_app_controller.dart';
import '../../../../core/utils/responsive.dart';
import '../../widgets/toggle_switch.dart';

class InventoryHeader extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onToggle;

  const InventoryHeader({
    super.key,
    required this.selectedIndex,
    required this.onToggle,
  });

  final List<Map<String, String>> options = const [
    {"title": "Product", "icon": "assets/icons/product.svg"},
    {"title": "Table", "icon": "assets/icons/table-2.svg"},
    {"title": "Report", "icon": "assets/icons/staff.svg"}
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context)) ...[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: context.read<MenuAppController>().controlMenu,
            ),
            const SizedBox(
              width: 10,
            )
          ],
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Kho hàng",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " / ${options[selectedIndex]["title"]}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
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
