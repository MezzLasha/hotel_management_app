import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'room_chat_event.dart';
part 'room_chat_state.dart';

class RoomChatBloc extends Bloc<RoomChatEvent, RoomChatState> {
  RoomChatBloc() : super(RoomChatInitial()) {
    on<RoomChatEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
