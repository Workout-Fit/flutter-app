import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:workout/screens/home/view/home.dart';
import 'package:workout/screens/login/bloc/login_bloc.dart';
import 'package:workout/screens/login/view/sign_up.dart';

class OtpArguments {
  final String phoneNumber;

  OtpArguments({required this.phoneNumber});
}

class OtpForm extends StatefulWidget {
  static const String routeName = "login/otp-form";
  final String phoneNumber;

  const OtpForm({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  OtpFormState createState() => OtpFormState();
}

class OtpFormState extends State<OtpForm> {
  final errorController = StreamController<ErrorAnimationType>();
  final pinController = TextEditingController();
  bool hasError = false;

  @override
  void dispose() {
    super.dispose();
    errorController.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginCompleteState) {
          Navigator.of(context, rootNavigator: true).pushNamed(
            state.profileInfo == null
                ? SignUpPage.routeName
                : HomePage.routeName,
          );
        }
      },
      builder: (BuildContext context, LoginState state) {
        if (state is OtpExceptionState) {
          errorController.add(ErrorAnimationType.shake);
          pinController.text = '';
        }
        return LoadingOverlay(
          isLoading: BlocProvider.of<LoginBloc>(context).state is LoadingState,
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Image.asset(
                    "assets/images/paperplane.webp",
                    fit: BoxFit.cover,
                    width: 150.0,
                    height: 150.0,
                  ),
                  const SizedBox(height: 32.0),
                  Text(
                    "Verification Code",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Please type the code sent to ${widget.phoneNumber}",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 40.0),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    errorAnimationController: errorController,
                    controller: pinController,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10.0),
                      selectedFillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      inactiveFillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      inactiveColor: Colors.transparent,
                      activeColor: Colors.transparent,
                      activeFillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      selectedColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
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
                    onChanged: (String value) {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
