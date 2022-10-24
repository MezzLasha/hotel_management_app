import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_app/logic/auth/auth_repository.dart';
import 'package:hotel_management_app/logic/auth/form_submission_status.dart';
import 'package:hotel_management_app/logic/auth/login/login_event.dart';
import 'package:hotel_management_app/logic/auth/register/register_view.dart';
import 'package:hotel_management_app/logic/home/dashboard/bloc/dashboard_view.dart';
import 'package:hotel_management_app/presentation/myWidgets/customWidgets.dart';

import '../Models/user.dart';
import 'login_bloc.dart';
import 'login_state.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              _loginHeader(),
              BlocProvider(
                create: (context) => LoginBloc(
                  context.read<AuthRepository>(),
                ),
                child: _loginForm(),
              ),
            ],
          ),
          _registerButton()
        ],
      ),
    );
  }

  Widget register = RegisterView();

  Container _registerButton() {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(14),
      child: OpenContainer(
        closedBuilder: ((context, action) {
          return FloatingActionButton.extended(
              onPressed: () {
                action();
              },
              label: Text(
                'რეგისტრაცია',
                style: GoogleFonts.robotoFlex(
                    fontWeight: FontWeight.w600, letterSpacing: 0.5),
              ),
              icon: const Icon(Icons.add_circle_outline));
        }),
        openBuilder: ((context, action) {
          return register;
        }),
        closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        closedElevation: 5,
      ),
    );
  }

  Container _loginHeader() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/hotel_pattern.png'),
              fit: BoxFit.cover)),
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Center(
          child: Text('Welcome To Mega',
              style: GoogleFonts.manrope(
                  fontSize: 54,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            _emailField(),
            _passwordField(),
            _loginButton(),
          ],
        ));
  }

  Widget _emailField() {
    return Container(
      padding: const EdgeInsets.all(14),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return TextFormField(
            validator: (value) =>
                state.isValidEmail ? null : 'ელ. ფოსტა არასწორია',
            onChanged: (value) =>
                context.read<LoginBloc>().add(LoginEmailChanged(email: value)),
            decoration: const InputDecoration(
                icon: Icon(Icons.alternate_email),
                labelText: 'ელ. ფოსტა',
                border: OutlineInputBorder()),
          );
        },
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: const EdgeInsets.all(14),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return TextFormField(
            obscureText: true,
            validator: (value) =>
                state.isValidPassword ? null : 'პაროლი არასწორია',
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: value)),
            decoration: const InputDecoration(
                icon: Icon(Icons.password),
                labelText: 'პაროლი',
                border: OutlineInputBorder()),
          );
        },
      ),
    );
  }

  Widget _loginButton() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => DashboardView(
                        user: formStatus.user,
                      ))));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state.formStatus is FormSubmitting) {
            return const Padding(
              padding: EdgeInsets.only(top: 36),
              child: LinearProgressIndicator(),
            );
          } else {
            return Container(
                padding: const EdgeInsets.all(14),
                child: FloatingActionButton.extended(
                    heroTag: 'login',
                    onPressed: () {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(LoginSubmitted());
                      }
                    },
                    label: Text('შესვლა',
                        style: GoogleFonts.robotoFlex(
                            fontWeight: FontWeight.w600, letterSpacing: 0.5))));
          }
        },
      ),
    );
  }
}
