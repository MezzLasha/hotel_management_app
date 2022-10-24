import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hotel_management_app/logic/auth/Models/user.dart';
import 'package:hotel_management_app/logic/auth/form_submission_status.dart';
import 'package:hotel_management_app/logic/home/profile/repo/profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  User user;
  ProfileRepo profileRepo;

  ProfileBloc(this.profileRepo, this.user)
      : super(ProfileState(user, const InitialFormStatus())) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileRefresh) {
        if (kDebugMode) {
          print('//TODO REFRESH TEST');
        }
      } else if (event is ProfileUserDataChanged) {
        try {
          if (event.oldPassword != null && event.oldPassword != '') {
            //PASS CHANGED
            if (kDebugMode) {
              print('changing password');
            }
            emit(state.copyWith(formStatus: FormSubmitting()));
            await profileRepo.changeData(event.user, event.oldPassword!);
          } else {
            if (kDebugMode) {
              print('changing data');
            }
            emit(state.copyWith(formStatus: FormSubmitting()));
            await profileRepo.changeData(event.user, user.password);
          }

          emit(state.copyWith(formStatus: SubmissionSuccess(user: event.user)));
        } catch (e) {
          emit(state.copyWith(
              formStatus: SubmissionFailed(exception: e as Exception)));
        }
      }
    });
  }
}
