import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/bloc/login/login_bloc.dart';
import 'package:workout/repos/authentication_repository.dart';

import 'login_form.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  final AuthenticationRepository authenticationRepository;

  const LoginPage({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(
      authenticationRepository: widget.authenticationRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => _loginBloc,
        child: LoginForm(),
      ),
    );
  }
}
