import 'package:flutter/material.dart';
import 'package:order_management_flutter_app/features/product/views/product_list_inventory.dart';
import 'package:order_management_flutter_app/screens/tab/activity/page/billing_queue_screen.dart';
import 'package:order_management_flutter_app/screens/tab/activity/page/order_screen.dart';
import 'package:order_management_flutter_app/screens/tab/activity/page/table_screen.dart';
import 'package:order_management_flutter_app/screens/tab/inventory/page/product_screen.dart';
import 'package:order_management_flutter_app/screens/tab/activity/widgets/activity_header.dart';

import '../../../features/report/views/chart.dart';
import 'widgets/inventory_header.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  int _selectedIndex = 0;

  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return const ProductScreen();
      case 1:
        return const TableScreen();
      case 2:
        return const LineChartSample2();
      default:
        return const ProductScreen();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                InventoryHeader(
                  onToggle: _updateSelectedIndex,
                  selectedIndex: _selectedIndex,
                ),
                Expanded(
                  child: _getSelectedScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
