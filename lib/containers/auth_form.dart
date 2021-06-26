import 'package:flutter/material.dart';
import '../routes.dart';
import '../theme/theme.dart';

class AuthForm extends StatefulWidget {
  final bool signUp;
  AuthForm({this.signUp = false});

  @override
  AuthFormState createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) => Form(
      key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            hintText: "E-mail",
          ),
        ),
        SizedBox(height: 24.0),
        Visibility(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Username",
                ),
              ),
              SizedBox(height: 24.0),
            ],
          ),
          visible: widget.signUp,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Password",
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility_off : Icons.visibility,
                color: mediumEmphasisBlack,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          obscureText: !_passwordVisible,
        ),
        TextButton(
          onPressed: () {},
          child: Text("Forgot your password?"),
        ),
        SizedBox(height: 24.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
                Navigator.pushNamed(context, routeWorkoutList);
              }
            },
            child: Text(widget.signUp ? "SIGN-UP" : "SIGN-IN"),
          ),
        ),
      ]));
}
