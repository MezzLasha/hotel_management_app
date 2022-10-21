// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class DashboardAddRoom extends DashboardEvent {
  final String objectName;
  final String objectInfo;
  final String groupName;
  DashboardAddRoom({
    required this.objectName,
    required this.objectInfo,
    required this.groupName,
  });
}
