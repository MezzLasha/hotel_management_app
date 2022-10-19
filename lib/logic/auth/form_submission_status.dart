// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hotel_management_app/logic/auth/Models/user.dart';

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {
  final User user;
  SubmissionSuccess({required this.user});
}

class SubmissionFailed extends FormSubmissionStatus {
  final Exception exception;
  SubmissionFailed({
    required this.exception,
  });
}
