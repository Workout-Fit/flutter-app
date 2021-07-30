import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/app/bloc/authentication_bloc.dart';
import 'package:workout/screens/login/login.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "home/profile";

  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) => Container(
        child: Center(
          child: IconButton(
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationLogoutRequested(),
              );
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ),
      );
}
