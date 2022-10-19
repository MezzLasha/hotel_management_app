import 'package:bloc/bloc.dart';
import 'package:hotel_management_app/logic/auth/Models/user.dart';
import 'package:hotel_management_app/logic/home/dashboard/repo/dashboard_repository.dart';
import 'package:hotel_management_app/logic/home/models/room.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardRepository dashboardRepository;
  User user;
  DashboardBloc(this.dashboardRepository, this.user)
      : super(DashboardState(user, [])) {
    on<DashboardEvent>((event, emit) async {
      if (event is DashboardRefresh) {
        try {
          await dashboardRepository
              .fetchUserObjects(state.user.mail, state.user.password)
              .then((value) => emit(state.copyWith(rooms: value)));
        } catch (e) {
          throw (Exception(e));
        }
      } else if (event is DashboardUserChanged) {
        emit(state.copyWith(user: event.user));
      }
    });

    if (state.rooms.isEmpty) {
      try {
        dashboardRepository
            .fetchUserObjects(state.user.mail, state.user.password)
            .then((value) => emit(state.copyWith(rooms: value)));
      } catch (e) {
        throw (Exception(e));
      }
    }
  }
}
