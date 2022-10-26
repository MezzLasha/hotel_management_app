import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'room_detail_event.dart';
part 'room_detail_state.dart';

class RoomDetailBloc extends Bloc<RoomDetailEvent, RoomDetailState> {
  RoomDetailBloc() : super(RoomDetailInitial()) {
    on<RoomDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
