import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../order/repository/order_data.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.blue,
    Colors.lightBlueAccent,
  ];

  String selectedOption = "Ngày";

  List<FlSpot> getRevenueDataByHour(DateTime selectedDate) {
    Map<int, double> hourlyRevenue = {};

    for (var order in demoOrders) {
      if (order.createdAt.year == selectedDate.year &&
          order.createdAt.month == selectedDate.month &&
          order.createdAt.day == selectedDate.day) {
        int hour = order.createdAt.hour;
        hourlyRevenue[hour] = (hourlyRevenue[hour] ?? 0) + order.totalPayment;
      }
    }

    return List.generate(24,
        (hour) => FlSpot(hour.toDouble(), (hourlyRevenue[hour] ?? 0) / 1000));
  }

  List<FlSpot> getRevenueDataByWeek() {
    DateTime now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    Map<int, double> weeklyRevenue = {for (int i = 0; i < 7; i++) i: 0.0};

    for (var order in demoOrders) {
      int dayDiff = order.createdAt.difference(monday).inDays;
      if (dayDiff >= 0 && dayDiff < 7) {
        weeklyRevenue[dayDiff] =
            (weeklyRevenue[dayDiff] ?? 0) + order.totalPayment;
      }
    }

    return List.generate(
      7,
      (i) => FlSpot(i.toDouble(), (weeklyRevenue[i] ?? 0) / 1000),
    );
  }

  List<FlSpot> getRevenueDataByMonth() {
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    Map<int, double> monthlyRevenue = {
      for (int i = 1; i <= daysInMonth; i++) i: 0.0
    };

    for (var order in demoOrders) {
      if (order.createdAt.year == now.year &&
          order.createdAt.month == now.month) {
        monthlyRevenue[order.createdAt.day] =
            (monthlyRevenue[order.createdAt.day] ?? 0) + order.totalPayment;
      }
    }

    return List.generate(
      daysInMonth,
      (i) => FlSpot((i + 1).toDouble(), (monthlyRevenue[i + 1] ?? 0) / 1000),
    );
  }

  List<FlSpot> getChartData() {
    if (selectedOption == "Ngày") {
      return getRevenueDataByHour(DateTime.now());
    } else if (selectedOption == "Tuần") {
      return getRevenueDataByWeek();
    } else {
      return getRevenueDataByMonth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: selectedOption,
          items: ["Ngày", "Tuần", "Tháng"]
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedOption = value;
              });
            }
          },
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.70,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

    if (selectedOption == "Ngày") {
      if (value.toInt() % 6 == 0 || value.toInt() == 23) {
        return Text("${value.toInt()}h", style: style);
      }
    } else if (selectedOption == "Tuần") {
      List<String> weekDays = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
      if (value.toInt() >= 0 && value.toInt() < weekDays.length) {
        return Text(weekDays[value.toInt()], style: style);
      }
    } else if (selectedOption == "Tháng") {
      if (value.toInt() % 5 == 0 || value.toInt() == 1) {
        return Text("${value.toInt()}", style: style);
      }
    }
    return const SizedBox();
  }

  LineChartData mainData() {
    List<FlSpot> spots = getChartData();

    return LineChartData(
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
                colors: gradientColors.map((c) => c.withOpacity(0.3)).toList()),
          ),
        ),
      ],
    );
  }
}
