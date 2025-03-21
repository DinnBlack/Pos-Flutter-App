import 'package:flutter/material.dart';

class MainCustomerScreen extends StatelessWidget {
  final String tableId;
  const MainCustomerScreen({super.key, required this.tableId});

  @override
  Widget build(BuildContext context) {
    return  Placeholder(
      child: Text(tableId),
    );
  }
}
