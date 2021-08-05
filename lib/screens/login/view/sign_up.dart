import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:workout/repos/authentication_repository.dart';
import 'package:workout/screens/home/home.dart';
import 'package:workout/screens/login/bloc/login_bloc.dart';
import 'package:workout/utils/regex.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "sign-up";

  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        ),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginCompleteState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                HomePage.routeName,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: BlocProvider.of<LoginBloc>(context).state
                  is SignUpLoadingState,
              child: Container(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 64.0,
                  bottom: 40.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 8.0),
                      Text("Please, tell us a little about yourself."),
                      const SizedBox(height: 40.0),
                      TextFormField(
                        controller: _usernameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Sets required";
                          else if (value.length > 16)
                            return "Username must be 16 characters or shorter";
                          else if (!usernameRegEx.hasMatch(value))
                            return "Only numbers, characters and underscores allowed";
                        },
                        decoration: const InputDecoration(
                          hintText: "Username (required)",
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      TextFormField(
                        controller: _nameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value == null || value.isEmpty
                            ? "Name required"
                            : null,
                        decoration: const InputDecoration(
                          hintText: "Name (required)",
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<LoginBloc>(context).add(
                                  SignUpEvent(
                                    _usernameController.text,
                                    _nameController.text,
                                  ),
                                );
                              }
                            },
                            child: Text("SIGN-IN"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
