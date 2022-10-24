// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileRefresh extends ProfileEvent {}

class ProfileUserDataChanged extends ProfileEvent {
  final User user;
  final String? oldPassword;
  ProfileUserDataChanged({
    required this.user,
    this.oldPassword,
  });
}
