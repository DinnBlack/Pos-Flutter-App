import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class OrderFilter extends StatefulWidget {
  final Function(DateTime startDate, TimeOfDay startTime, DateTime endDate,
      TimeOfDay endTime, String?) onFilterChanged;
  final List<Map<String, dynamic>> filterOptions;

  const OrderFilter({super.key, required this.onFilterChanged, required this.filterOptions});

  @override
  State<OrderFilter> createState() => _OrderFilterState();
}

class _OrderFilterState extends State<OrderFilter> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 23, minute: 59);

  final List<Map<String, dynamic>> filterOptions = [
    {'icon': Icons.list, 'title': 'Tất cả đơn hàng'},
    {
      'icon': Icons.check_circle,
      'title': 'Đơn hoàn thành',
      'status': 'completed'
    },
    {'icon': Icons.pending, 'title': 'Đơn đang chuẩn bị', 'status': 'pending'},
    {'icon': Icons.cancel, 'title': 'Đơn bị hủy', 'status': 'canceled'},
    {
      'icon': Icons.attach_money,
      'title': 'Đã thanh toán',
      'paymentStatus': 'paid'
    },
    {
      'icon': Icons.money_off,
      'title': 'Chưa thanh toán',
      'paymentStatus': 'unpaid'
    },
  ];

  String? selectedFilter;

  Future<void> _pickDate({required bool isStart}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_startDate.isAfter(_endDate)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _startDate = _endDate;
          }
        }
      });
    }
  }

  Future<void> _pickTime({required bool isStart}) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Text('Ngày:', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 5),
          _filterButton(
            context,
            dateFormat.format(_startDate),
            'assets/icons/calendar.svg',
            onTap: () => _pickDate(isStart: true),
          ),
          const SizedBox(width: 5),
          const Text('-', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 5),
          _filterButton(
            context,
            dateFormat.format(_endDate),
            'assets/icons/calendar.svg',
            onTap: () => _pickDate(isStart: false),
          ),
          const SizedBox(width: 20),
          const Text('Giờ:', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 5),
          _filterButton(
            context,
            _startTime.format(context),
            'assets/icons/clock.svg',
            onTap: () => _pickTime(isStart: true),
          ),
          const SizedBox(width: 5),
          const Text('-', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 5),
          _filterButton(
            context,
            _endTime.format(context),
            'assets/icons/clock.svg',
            onTap: () => _pickTime(isStart: false),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              widget.onFilterChanged(_startDate, _startTime, _endDate, _endTime, selectedFilter);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: SvgPicture.asset('assets/icons/search.svg',
                  width: 20,
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          _buildFilterDropdown(colors),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(ColorScheme colors) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isDense: true,
        customButton: Container(
          padding: const EdgeInsets.all(10),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: SvgPicture.asset('assets/icons/filter.svg',
              width: 20,
              height: 20,
              colorFilter:
                  const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
        ),
        items: filterOptions.map((option) {
          return DropdownMenuItem<String>(
            value: option['title'],
            child: Row(
              children: [
                Icon(option['icon'], size: 20, color: Colors.blue),
                const SizedBox(width: 10),
                Text(option['title']),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedFilter = value;
          });

          widget.onFilterChanged(_startDate, _startTime, _endDate, _endTime, selectedFilter);
        },
        buttonStyleData: ButtonStyleData(
          height: 40,
          width: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          width: 200,
          elevation: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: colors.background,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
        ),
      ),
    );
  }

  Widget _filterButton(BuildContext context, String text, String svgPath,
      {VoidCallback? onTap}) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: colors.secondary,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: SvgPicture.asset(svgPath,
                  width: 20,
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(Colors.blue, BlendMode.srcIn)),
            ),
            const SizedBox(width: 5),
            Text(text, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
