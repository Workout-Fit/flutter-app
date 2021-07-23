import 'package:flutter/material.dart';

class OtpForm extends StatefulWidget {
  static String routeName = "/otp-form";

  @override
  OtpFormState createState() => OtpFormState();
}

class OtpFormState extends State<OtpForm> {
  final _phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _phoneTextController,
          decoration: InputDecoration(hintText: "E-mail"),
        ),
        const SizedBox(height: 24.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Text("SIGN-IN"),
          ),
        ),
      ],
    );
  }
}
