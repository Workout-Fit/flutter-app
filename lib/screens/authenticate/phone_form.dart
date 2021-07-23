import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/bloc/login/login_bloc.dart';

class PhoneForm extends StatefulWidget {
  static String routeName = "/phone-form";

  @override
  PhoneFormState createState() => PhoneFormState();
}

class PhoneFormState extends State<PhoneForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          "assets/images/logo_black.png",
          fit: BoxFit.cover,
          height: 150.0,
        ),
        const SizedBox(height: 24.0),
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _phoneTextController,
            decoration: InputDecoration(hintText: "E-mail"),
          ),
        ),
        const SizedBox(height: 24.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<LoginBloc>(context).add(
                  SendOtpEvent(phoneNumber: _phoneTextController.text),
                );
              }
            },
            child: Text("SIGN-IN"),
          ),
        ),
      ],
    );
  }
}
