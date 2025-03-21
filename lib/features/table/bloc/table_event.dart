part of 'table_bloc.dart';

@immutable
sealed class TableEvent {}

// Table Fetch
class TableFetchStarted extends TableEvent {}
