import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpForm extends StatefulWidget {
  static String routeName = "/otp-form";

  @override
  OtpFormState createState() => OtpFormState();
}

class OtpFormState extends State<OtpForm> {
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          PinCodeTextField(
            appContext: context,
            length: 6,
            pinTheme: PinTheme(
              selectedFillColor:
                  Theme.of(context).inputDecorationTheme.fillColor,
              errorBorderColor:
                  Theme.of(context).inputDecorationTheme.fillColor,
              activeColor: Theme.of(context).inputDecorationTheme.fillColor,
              activeFillColor: Theme.of(context).inputDecorationTheme.fillColor,
              selectedColor: Theme.of(context).inputDecorationTheme.fillColor,
              fieldHeight: 50,
              fieldWidth: 45,
            ),
            animationType: AnimationType.none,
            keyboardType: TextInputType.number,
            backgroundColor: Colors.transparent,
            controller: _pinController,
            onChanged: (String value) {},
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
      ),
    );
  }
}
