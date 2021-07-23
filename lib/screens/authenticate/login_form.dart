import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/bloc/login/login_bloc.dart';
import 'package:workout/screens/authenticate/phone_form.dart';

import 'otp_form.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (context, loginState) {
        print(loginState);
        if (loginState is ExceptionState || loginState is OtpExceptionState) {
          String message = '';
          if (loginState is ExceptionState) {
            message = loginState.message;
          } else if (loginState is OtpExceptionState) {
            message = loginState.message;
          }
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250.0,
                      child: Text(
                        message,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {
          return Navigator(
            initialRoute: PhoneForm.routeName,
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => settings.name == PhoneForm.routeName
                    ? PhoneForm()
                    : OtpForm(),
                settings: settings,
              );
            },
          );
        },
      ),
    );
  }
}
