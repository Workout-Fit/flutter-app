import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:workout/screens/login/bloc/login_bloc.dart';

import 'otp_form.dart';

class PhoneForm extends StatefulWidget {
  static String routeName = "login/phone-form";

  @override
  PhoneFormState createState() => PhoneFormState();
}

class PhoneFormState extends State<PhoneForm> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: BlocProvider.of<LoginBloc>(context),
      listener: (_, LoginState state) {
        if (state is OtpSentState) {
          Navigator.of(context).pushNamed(
            OtpForm.routeName,
            arguments: OtpArguments(phoneNumber: _phoneNumber),
          );
        }
      },
      builder: (BuildContext context, LoginState state) => LoadingOverlay(
        isLoading: BlocProvider.of<LoginBloc>(context).state is LoadingState,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 88.0,
              bottom: 40.0,
            ),
            child: Column(
              children: <Widget>[
                Image.asset(
                  "assets/images/cellphone.webp",
                  fit: BoxFit.cover,
                  width: 150.0,
                  height: 150.0,
                ),
                const SizedBox(height: 32.0),
                Text(
                  "Phone Number",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Please, insert your phone number",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 24.0),
                Form(
                  key: _formKey,
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      _phoneNumber = number.phoneNumber ?? '';
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      trailingSpace: false,
                      leadingPadding: 0.0,
                    ),
                    initialValue: PhoneNumber(isoCode: 'BR'),
                    inputBorder: Theme.of(context).inputDecorationTheme.border,
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  "We will send you a One time SMS message.\n"
                  "Carrier rates may apply",
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<LoginBloc>(context).add(
                            SendOtpEvent(phoneNumber: _phoneNumber),
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
      ),
    );
  }
}
