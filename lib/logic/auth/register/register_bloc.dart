import 'package:bloc/bloc.dart';
import 'package:hotel_management_app/logic/auth/auth_repository.dart';
import 'package:hotel_management_app/logic/auth/form_submission_status.dart';
import 'package:hotel_management_app/logic/auth/register/register_event.dart';
import 'package:hotel_management_app/logic/auth/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepo;

  RegisterBloc(this.authRepo) : super(RegisterState()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterEmailChanged) {
        //username changed
        emit(state.copyWith(email: event.email));
      } else if (event is RegisterPasswordChanged) {
        //password changed
        emit(state.copyWith(password: event.password));
      } else if (event is RegisterIdChanged) {
        //id changed
        emit(state.copyWith(id: event.id));
      } else if (event is RegisterPhoneChanged) {
        //phone changed
        emit(state.copyWith(phone: event.phone));
      } else if (event is RegisterPasswordConfirmChanged) {
        //confirmpassword changed
        emit(state.copyWith(confirmPassword: event.confirmPassword));
      } else if (event is RegisterSubmitted) {
        //form submitted
        emit(state.copyWith(formStatus: FormSubmitting()));

        try {
          await authRepo.register();
          emit(state.copyWith(formStatus: SubmissionSuccess()));
        } catch (e) {
          emit(state.copyWith(
              formStatus: SubmissionFailed(exception: e as Exception)));
        }
      }
    });
  }
}
