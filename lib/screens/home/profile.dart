import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/bloc/authentication/authentication_bloc.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/profile";

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
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ),
      );
}
