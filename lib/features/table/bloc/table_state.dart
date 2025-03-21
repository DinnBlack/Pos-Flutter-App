part of 'table_bloc.dart';

@immutable
sealed class TableState {}

final class TableInitial extends TableState {}

// Table Fetch
class TableFetchInProgress extends TableState {}

class TableFetchSuccess extends TableState {
  final List<TableModel> tables;

  TableFetchSuccess({required this.tables});
}

class TableFetchFailure extends TableState {
  final String error;

  TableFetchFailure({required this.error});
}
