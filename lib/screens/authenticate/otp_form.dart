import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:workout/bloc/login/login_bloc.dart';

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
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10.0),
              selectedFillColor:
                  Theme.of(context).inputDecorationTheme.fillColor,
              inactiveFillColor: Theme.of(context).inputDecorationTheme.fillColor,
              inactiveColor: Colors.transparent,
              activeColor: Colors.transparent,
              activeFillColor: Theme.of(context).inputDecorationTheme.fillColor,
              selectedColor: Theme.of(context).inputDecorationTheme.fillColor,
              fieldHeight: 50,
              fieldWidth: 45,
            ),
            onCompleted: (pinCode) {
              BlocProvider.of<LoginBloc>(context).add(
                VerifyOtpEvent(otp: pinCode),
              );
            },
            backgroundColor: Colors.transparent,
            enableActiveFill: true,
            animationType: AnimationType.none,
            keyboardType: TextInputType.number,
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
