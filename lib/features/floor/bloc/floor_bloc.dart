import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:order_management_flutter_app/features/floor/model/floor_model.dart';
import 'package:order_management_flutter_app/features/floor/repository/floor_data.dart';

part 'floor_event.dart';
part 'floor_state.dart';

class FloorBloc extends Bloc<FloorEvent, FloorState> {
  FloorBloc() : super(FloorInitial()) {
    on<FloorFetchStarted>(_onFloorFetchStarted);
  }

  Future<void> _onFloorFetchStarted(
      FloorFetchStarted event, Emitter<FloorState> emit) async {
    try {
      emit(FloorFetchInProgress());
      await Future.delayed(Duration(seconds: 2));
      final floors = demoFloors;
      emit(FloorFetchSuccess(floors: floors));
    } catch (e) {
      emit(FloorFetchFailure(error: e.toString()));
    }
  }
}
