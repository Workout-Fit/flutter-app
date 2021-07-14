import 'package:flutter/material.dart';
import 'package:workout/screens/home/workouts.dart';

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
                decoration: const InputDecoration(
                  hintText: "Username",
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
          visible: widget.signUp,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Password",
            suffixIcon: IconButton(
              icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility),
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
          child: const Text("Forgot your password?"),
        ),
        const SizedBox(height: 24.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Processing Data'),
                ));
                Navigator.pushNamed(context, WorkoutsPage.routeName);
              }
            },
            child: Text(widget.signUp ? "SIGN-UP" : "SIGN-IN"),
          ),
        ),
      ]));
}
