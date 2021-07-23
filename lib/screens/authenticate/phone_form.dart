import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:workout/bloc/login/login_bloc.dart';
import 'package:workout/screens/authenticate/otp_form.dart';

class PhoneForm extends StatefulWidget {
  static String routeName = "/phone-form";

  @override
  PhoneFormState createState() => PhoneFormState();
}

class PhoneFormState extends State<PhoneForm> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<LoginBloc>(context),
      listener: (context, state) {
        if (state is OtpSentState) {
          Navigator.of(context).pushNamed(OtpForm.routeName);
        }
      },
      child: LoadingOverlay(
        isLoading: BlocProvider.of<LoginBloc>(context).state is LoadingState,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
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
              SizedBox(
                width: double.infinity,
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
            ],
          ),
        ),
      ),
    );
  }
}
