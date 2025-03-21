part of 'floor_bloc.dart';

@immutable
sealed class FloorState {}

final class FloorInitial extends FloorState {}

// floor fetch
class FloorFetchInProgress extends FloorState {}

class FloorFetchSuccess extends FloorState {
  final List<FloorModel> floors;

  FloorFetchSuccess({required this.floors});
}

class FloorFetchFailure extends FloorState {
  final String error;
  FloorFetchFailure({required this.error});
}
