abstract class RegisterEvent {}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({required this.email});
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({required this.password});
}

class RegisterPasswordConfirmChanged extends RegisterEvent {
  final String confirmPassword;

  RegisterPasswordConfirmChanged({required this.confirmPassword});
}

class RegisterNameChanged extends RegisterEvent {
  final String name;

  RegisterNameChanged({required this.name});
}

class RegisterIdChanged extends RegisterEvent {
  final String id;

  RegisterIdChanged({required this.id});
}

class RegisterPhoneChanged extends RegisterEvent {
  final String phone;

  RegisterPhoneChanged({required this.phone});
}

class RegisterSubmitted extends RegisterEvent {}
