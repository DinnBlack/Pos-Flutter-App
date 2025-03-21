import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/utils/constants.dart';
import '../../../product/views/widgets/qr_code_generator.dart';
import '../../model/table_model.dart';

class TableListItem extends StatelessWidget {
  final TableModel table;

  const TableListItem({
    super.key,
    required this.table,
  });

  void _showQRCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Mã QR Bàn"),
          content: QRCodeGenerator(
            tableId: table.id,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Đóng"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor;
    Color iconColor;
    if (table.status == 'Đóng') {
      backgroundColor = Colors.red.withOpacity(0.1);
      iconColor = Colors.red;
    } else if (table.status == 'Đang hoạt động') {
      backgroundColor = colors.primary.withOpacity(0.1);
      iconColor = colors.primary;
    } else {
      backgroundColor = Colors.grey.withOpacity(0.1);
      iconColor = isDarkMode ? Colors.white : Colors.grey;
    }

    String operationTime = table.operationTime != null
        ? DateFormat('hh:mm a').format(table.operationTime!)
        : '--:--';

    return GestureDetector(
      onTap: () => _showQRCode(context),
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              table.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    color: iconColor,
                  ),
            ),
            SvgPicture.asset(
              'assets/icons/table.svg',
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              width: 50,
              height: 50,
            ),
            Text(
              operationTime,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
