import 'package:flutter/material.dart';
import 'package:order_management_flutter_app/features/floor/model/floor_model.dart';
import 'package:order_management_flutter_app/features/table/views/widgets/table_list_item.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/dash_divider.dart';
import '../model/table_model.dart';

class TableList extends StatelessWidget {
  final List<TableModel> tables;
  final List<FloorModel> floors;

  const TableList({
    super.key,
    required this.tables,
    required this.floors,
  });

  @override
  Widget build(BuildContext context) {
    final Set<String> uniqueFloorIds =
        tables.map((table) => table.floorId).toSet();
    final bool isSingleFloor = uniqueFloorIds.length == 1;

    return ListView.builder(
      itemCount: isSingleFloor ? 1 : floors.length,
      itemBuilder: (context, floorIndex) {
        final floor = isSingleFloor
            ? floors.firstWhere((floor) => floor.id == uniqueFloorIds.first)
            : floors[floorIndex];
        final floorTables =
            tables.where((table) => table.floorId == floor.id).toList();
        if (floorTables.isEmpty) {
          return const SizedBox.shrink();
        }

        bool isLastFloor = (isSingleFloor || floorIndex == floors.length - 1);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isSingleFloor)
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  floor.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            LayoutBuilder(builder: (context, constraints) {
              int crossAxisCount;

              if (Responsive.isMobile(context)) {
                crossAxisCount = 3;
              } else if (Responsive.isTablet(context)) {
                crossAxisCount = 5;
              } else {
                crossAxisCount = 6;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: floorTables.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, tableIndex) {
                  return TableListItem(table: floorTables[tableIndex]);
                },
              );
            }),
            if (!isLastFloor) ...[
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DashDivider(),
              ),
            ],
          ],
        );
      },
    );
  }
}
