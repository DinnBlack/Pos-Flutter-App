import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/table_model.dart';
import '../repository/table_data.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  TableBloc() : super(TableInitial()) {
    on<TableFetchStarted>(_onTableFetchStarted);
  }

  // Table fetch
  Future<void> _onTableFetchStarted(
      TableFetchStarted event, Emitter<TableState> emit) async {
    try {
      emit(TableFetchInProgress());
      await Future.delayed(Duration(seconds: 2));
      final tables = demoTables;
      emit(TableFetchSuccess(tables: tables));
    } on Exception catch (e) {
      emit(TableFetchFailure(error: e.toString()));
    }
  }
}
