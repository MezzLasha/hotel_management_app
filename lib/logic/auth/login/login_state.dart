import 'package:hotel_management_app/logic/auth/form_submission_status.dart';

class LoginState {
  final String email;
  bool get isValidEmail {
    if (!email.contains('@')) {
      return false;
    }
    if (email.length < 3) {
      return false;
    }
    if (!email.split('@')[1].contains('.') ||
        email.split('@')[1].split('.')[0].length < 2 ||
        email.split('@')[1].split('.')[1].isEmpty) {
      return false;
    }
    return true;
  }

  final String password;
  bool get isValidPassword {
    return password.length >= 3;
  }

  final FormSubmissionStatus formStatus;

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
