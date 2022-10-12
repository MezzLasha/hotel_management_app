import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_management_app/logic/auth/auth_repository.dart';
import 'package:hotel_management_app/logic/auth/form_submission_status.dart';
import 'package:hotel_management_app/logic/auth/register/register_bloc.dart';
import 'package:hotel_management_app/logic/auth/register/register_event.dart';
import 'package:hotel_management_app/logic/auth/register/register_state.dart';

import '../../../presentation/myWidgets/customWidgets.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('რეგისტრაცია'),
      ),
      body: BlocProvider(
        create: (context) => RegisterBloc(
          context.read<AuthRepository>(),
        ),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.formStatus is SubmissionFailed) {
              showSnackBar(context, 'რეგისტრაცია ვერ მოხერხდა, სცადეთ ახლიდან');
            }
          },
          child: Stack(
            children: [
              Form(
                key: _registerFormKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 8),
                    _emailField(),
                    _passwordField(),
                    _confirmPasswordField(),
                    _nameField(),
                    _idField(),
                    _phoneField(),
                  ],
                ),
              ),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  if (state.formStatus is FormSubmitting) {
                    return Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(bottom: 80),
                        child: const CircularProgressIndicator());
                  } else {
                    return Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 80),
                      child: FloatingActionButton.extended(
                        onPressed: (() {
                          if (_registerFormKey.currentState != null &&
                              _registerFormKey.currentState!.validate()) {
                            context
                                .read<RegisterBloc>()
                                .add(RegisterSubmitted());
                          }
                        }),
                        label: const Text('რეგისტრაცია'),
                        icon: const Icon(Icons.navigate_next),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return TextFormField(
            validator: (value) =>
                state.isValidEmail ? null : 'ელ. ფოსტა არასწორია',
            onChanged: (value) => context
                .read<RegisterBloc>()
                .add(RegisterEmailChanged(email: value)),
            decoration: const InputDecoration(
                icon: Icon(Icons.alternate_email),
                hintText: 'ელ. ფოსტა',
                border: OutlineInputBorder()),
          );
        },
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return TextFormField(
            validator: (value) => state.isValidPassword
                ? null
                : 'პაროლი მეტი უნდა იყოს 6 სიმბოლოზე',
            obscureText: true,
            onChanged: (value) => context
                .read<RegisterBloc>()
                .add(RegisterPasswordChanged(password: value)),
            decoration: const InputDecoration(
                icon: Icon(Icons.password),
                hintText: 'პაროლი',
                border: OutlineInputBorder()),
          );
        },
      ),
    );
  }

  Widget _confirmPasswordField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return TextFormField(
            validator: (value) =>
                state.isValidConfirmPassword ? null : 'პაროლები არ ემთხვევა',
            obscureText: true,
            onChanged: (value) => context
                .read<RegisterBloc>()
                .add(RegisterPasswordConfirmChanged(confirmPassword: value)),
            decoration: const InputDecoration(
                icon: Icon(Icons.password),
                hintText: 'პაროლის დამოწმება',
                border: OutlineInputBorder()),
          );
        },
      ),
    );
  }

  Widget _nameField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return TextFormField(
            validator: (value) => null,
            onChanged: (value) => context
                .read<RegisterBloc>()
                .add(RegisterNameChanged(name: value)),
            decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'სახელი',
                border: OutlineInputBorder()),
          );
        },
      ),
    );
  }

  Widget _idField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return TextFormField(
            validator: (value) =>
                state.isValidId ? null : 'პირადი ნომერი არასწორია',
            keyboardType: TextInputType.number,
            onChanged: (value) =>
                context.read<RegisterBloc>().add(RegisterIdChanged(id: value)),
            decoration: const InputDecoration(
                icon: Icon(Icons.perm_identity),
                hintText: 'პირადი ნომერი',
                border: OutlineInputBorder()),
          );
        },
      ),
    );
  }

  Widget _phoneField() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return TextFormField(
            validator: (value) =>
                state.isValidPhone ? null : 'ტელეფონის ნომერი არასწორია',
            onChanged: (value) => context
                .read<RegisterBloc>()
                .add(RegisterPhoneChanged(phone: value)),
            decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: 'ტელეფონის ნომერი',
                border: OutlineInputBorder()),
          );
        },
      ),
    );
  }
}
