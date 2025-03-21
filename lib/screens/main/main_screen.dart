import 'package:flutter/material.dart';
import 'package:order_management_flutter_app/screens/tab/activity/activity_screen.dart';
import 'package:order_management_flutter_app/screens/tab/inventory/inventory_screen.dart';
import 'package:provider/provider.dart';
import '../../core/controllers/menu_app_controller.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/side_menu.dart';
import '../tab/dashboard/dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    const DashboardScreen(),
    const ActivityScreen(),
    const InventoryScreen(),
  ];

  void onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (!Responsive.isDesktop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(
        onTabSelected: onTabSelected,
        selectedIndex: selectedIndex,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(
                  onTabSelected: onTabSelected,
                  selectedIndex: selectedIndex,
                ),
              ),
            Expanded(
              flex: 5,
              child: pages[selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
