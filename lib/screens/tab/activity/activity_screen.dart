import 'package:flutter/material.dart';
import 'package:order_management_flutter_app/screens/tab/activity/page/billing_queue_screen.dart';
import 'package:order_management_flutter_app/screens/tab/activity/page/order_screen.dart';
import 'package:order_management_flutter_app/screens/tab/activity/page/table_screen.dart';
import 'package:order_management_flutter_app/screens/tab/widgets/activity_header.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedIndex = 0;

  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return const BillingQueueScreen();
      case 1:
        return const TableScreen();
      case 2:
        return const OrderScreen();
      default:
        return const BillingQueueScreen();
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
                ActivityHeader(
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
