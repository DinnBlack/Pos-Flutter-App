import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/dash_divider.dart';
import '../../../../features/floor/bloc/floor_bloc.dart';
import '../../../../features/floor/model/floor_model.dart';
import '../../../../features/floor/views/floor_edit_button.dart';
import '../../../../features/floor/views/floor_list.dart';
import '../../../../features/table/bloc/table_bloc.dart';
import '../../../../features/table/model/table_model.dart';
import '../../../../features/table/views/table_list.dart';
import '../../../../features/table/views/widgets/table_create_button.dart';
import '../../../../features/table/views/widgets/table_list_item_skeleton.dart';
import '../../../../features/table/views/widgets/table_status.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<TableModel> _allTables = [];
  List<FloorModel> _allFloors = [];
  List<TableModel> _filteredTables = [];
  String? selectedFloorId;

  void _filterTablesByFloor(String? floorId) {
    setState(() {
      if (floorId == null) {
        _filteredTables = _allTables;
      } else {
        _filteredTables = _allTables.where((table) {
          return table.floorId == floorId;
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<TableBloc>().add(TableFetchStarted());
    context.read<FloorBloc>().add(FloorFetchStarted());
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<TableBloc, TableState>(
          listener: (context, state) {
            if (state is TableFetchSuccess) {
              setState(() {
                _allTables = state.tables;
                _filteredTables = List.from(_allTables);
              });
            }
          },
        ),
        BlocListener<FloorBloc, FloorState>(
          listener: (context, state) {
            if (state is FloorFetchSuccess) {
              setState(() {
                _allFloors = state.floors;
              });
            }
          },
        ),
      ],
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    child: _buildContent(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(child: TableCreateButton()),
              SizedBox(
                width: 10,
              ),
              Expanded(child: FloorEditButton()),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: !Responsive.isMobile(context) ? 10 : 0),
          child: MyFloors(
            onFloorSelected: (floorId) {
              setState(() {
                selectedFloorId = floorId;
              });
              _filterTablesByFloor(selectedFloorId);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: BlocBuilder<TableBloc, TableState>(
            builder: (context, state) {
              if (state is TableFetchInProgress) {
                return LayoutBuilder(builder: (context, constraints) {
                  int crossAxisCount;

                  if (Responsive.isMobile(context)) {
                    crossAxisCount = 3;
                  } else if (Responsive.isTablet(context)) {
                    crossAxisCount = 5;
                  } else {
                    crossAxisCount = 6;
                  }

                  // Sử dụng ListView.builder để tạo ra 3 tầng
                  return ListView.builder(
                    itemCount: 3, // Có 3 tầng
                    itemBuilder: (context, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 60,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          // GridView.builder cho các item skeleton
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            // Mỗi tầng có 6 item
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: defaultPadding,
                              mainAxisSpacing: defaultPadding,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              return const TableListItemSkeleton();
                            },
                          ),
                          if (i != 2) ...[
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
                });
              } else if (state is TableFetchSuccess) {
                return TableList(tables: _filteredTables, floors: _allFloors);
              }
              return Container();
            },
          ),
        ),
        const TableStatus(),
      ],
    );
  }
}
