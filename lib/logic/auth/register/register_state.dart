import 'package:hotel_management_app/logic/auth/form_submission_status.dart';

class RegisterState {
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
    return password.length >= 6;
  }

  final String confirmPassword;
  bool get isValidConfirmPassword {
    return confirmPassword == password;
  }

  final String name;

  final String id;
  bool get isValidId {
    return id.length == 11;
  }

  final String phone;
  bool get isValidPhone {
    return phone.length == 9;
  }

  final FormSubmissionStatus formStatus;

  RegisterState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.name = '',
    this.id = '',
    this.phone = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? name,
    String? id,
    String? phone,
    FormSubmissionStatus? formStatus,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      name: name ?? this.name,
      id: id ?? this.id,
      phone: phone ?? this.phone,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
