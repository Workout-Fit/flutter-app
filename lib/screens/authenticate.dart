import 'package:flutter/material.dart';
import 'package:workout/containers/auth_form.dart';
import 'package:workout/theme/theme.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool _signUp = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Stack(
            children: [
              Positioned(
                child: Image.asset("assets/images/pattern.png"),
              ),
              Container(
                color: surface,
                padding: EdgeInsets.only(left: 32.0, right: 32.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo_black.png",
                        fit: BoxFit.cover,
                        height: 150.0,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      AuthForm(
                        signUp: _signUp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _signUp
                                ? "Already have an account?"
                                : "First time here?",
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _signUp = !_signUp;
                              });
                            },
                            child: Text(_signUp ? "Sign-in" : "Sign-up"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
