import 'package:bloc/bloc.dart';
import 'package:hotel_management_app/logic/auth/auth_repository.dart';
import 'package:hotel_management_app/logic/auth/form_submission_status.dart';
import 'package:hotel_management_app/logic/auth/login/login_event.dart';
import 'package:hotel_management_app/logic/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;

  LoginBloc(this.authRepo) : super(LoginState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginEmailChanged) {
        //email changed
        emit(state.copyWith(email: event.email));
      } else if (event is LoginPasswordChanged) {
        //password changed
        emit(state.copyWith(password: event.password));
      } else if (event is LoginSubmitted) {
        //form submitted
        emit(state.copyWith(formStatus: FormSubmitting()));

        try {
          await authRepo.login(state.email, state.password).then((value) =>
              emit(state.copyWith(formStatus: SubmissionSuccess(user: value))));
        } on Exception catch (e) {
          print(e);
          emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
        }
      }
    });
  }
}
