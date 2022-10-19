part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class DashboardRefresh extends DashboardEvent {}

class DashboardUserChanged extends DashboardEvent {
  final User user;

  DashboardUserChanged(this.user);
}

class DashboardRoomsChanged extends DashboardEvent {}

class DashboardAddGroup extends DashboardEvent {}

class DashboardAddRoom extends DashboardEvent {}
