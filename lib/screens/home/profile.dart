import 'package:flutter/material.dart';

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
          child: const Text("ProfilePage"),
        ),
      );
}
