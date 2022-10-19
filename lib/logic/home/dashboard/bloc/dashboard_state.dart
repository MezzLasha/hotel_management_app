// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_bloc.dart';

class DashboardState {
  final User user;
  final List<Room> rooms;

  DashboardState(this.user, this.rooms);

  DashboardState copyWith({
    User? user,
    List<Room>? rooms,
  }) {
    return DashboardState(
      user ?? this.user,
      rooms ?? this.rooms,
    );
  }
}

class DashboardInitial extends DashboardState {
  DashboardInitial(super.user, super.rooms);
}
