// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

class ProfileState {
  final User user;
  final FormSubmissionStatus formState;

  ProfileState(this.user, this.formState);

  ProfileState copyWith({
    User? user,
    FormSubmissionStatus? formStatus,
  }) {
    return ProfileState(
      user ?? this.user,
      formStatus ?? this.formState,
    );
  }
}

class ProfileInitial extends ProfileState {
  ProfileInitial(super.user, super.formState);
}
