import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/repos/authentication_repository.dart';
import 'package:workout/screens/login/bloc/login_bloc.dart';
import 'package:workout/widgets/error_snackbar.dart';

import 'otp_form.dart';
import 'phone_form.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'login';
  final String subRouteName;

  const LoginPage({Key? key, required this.subRouteName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, loginState) {
            if (loginState is ExceptionState ||
                loginState is OtpExceptionState) {
              String message = '';
              if (loginState is ExceptionState) {
                message = loginState.message;
              } else if (loginState is OtpExceptionState) {
                message = loginState.message;
              }
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(errorSnackBar(message));
            }
          },
          child: Navigator(
            onGenerateRoute: (settings) {
              Widget page = Container();
              if (settings.name == OtpForm.routeName) {
                final args = settings.arguments as OtpArguments;
                page = OtpForm(phoneNumber: args.phoneNumber);
              } else
                page = PhoneForm();

              return MaterialPageRoute(
                builder: (context) => page,
                settings: settings,
              );
            },
          ),
        ),
      ),
    );
  }
}
