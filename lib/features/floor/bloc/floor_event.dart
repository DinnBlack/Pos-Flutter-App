part of 'floor_bloc.dart';

@immutable
sealed class FloorEvent {}

// Floor fetch
class FloorFetchStarted extends FloorEvent {}