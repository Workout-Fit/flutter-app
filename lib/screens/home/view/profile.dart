import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/app/bloc/authentication_bloc.dart';
import 'package:workout/app/view/app.dart';
import 'package:workout/models/User.dart';
import 'package:workout/screens/home/bloc/get_profile_info_bloc.dart';
import 'package:workout/screens/home/bloc/update_profile_info_bloc.dart';
import 'package:workout/screens/login/view/login.dart';
import 'package:workout/utils/graphql_client.dart';
import 'package:workout/utils/image.dart';
import 'package:workout/widgets/error_snackbar.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "home/profile";

  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  GlobalKey<FormState> _profileFormKey = GlobalKey<FormState>();
  final ImagePicker _picturePicker = ImagePicker();
  final UpdateProfileInfoBloc _updateProfileInfoBloc =
      UpdateProfileInfoBloc(client: client);

  final GetProfileInfoBloc _getProfileInfoBloc =
      GetProfileInfoBloc(client: client);

  File? _profilePicture;
  bool _loading = false;
  double _heightController = 1.5;
  double _weightController = 50.0;
  bool _editMode = false;

  @override
  void initState() {
    super.initState();
    _getProfileInfoBloc.run(
      variables: GetUserByIdArguments(
        id: BlocProvider.of<AuthenticationBloc>(context).state.user.id,
      ).toJson(),
    );
  }

  Widget _profileInfo(ProfileInfoMixin$ProfileInfo? profileInfo) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: profileInfo?.profilePicture != null
              ? Image.network(
                  profileInfo!.profilePicture!,
                  height: 80.0,
                  width: 80.0,
                )
              : Image.asset(
                  'assets/images/profile_picture.webp',
                  height: 80.0,
                  width: 80.0,
                ),
        ),
        const SizedBox(height: 16.0),
        Text(
          profileInfo?.name ?? '',
          style: ThemeProvider.of(context)!.textTheme.headline4,
        ),
        Text(
          profileInfo?.username ?? '',
          style: ThemeProvider.of(context)!.textTheme.caption,
        ),
        const SizedBox(height: 16.0),
        Text(
          profileInfo?.bio ?? 'No bio provided',
          style: ThemeProvider.of(context)!.textTheme.bodyText1,
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              profileInfo?.weight != null
                  ? profileInfo!.weight.toString()
                  : '--',
              style: ThemeProvider.of(context)!.textTheme.headline4,
            ),
            const SizedBox(width: 8.0),
            Text(
              'kg',
              style: ThemeProvider.of(context)!.textTheme.caption,
            ),
            const SizedBox(width: 64.0),
            Text(
              profileInfo?.height != null
                  ? profileInfo!.height.toString()
                  : '--',
              style: ThemeProvider.of(context)!.textTheme.headline4,
            ),
            const SizedBox(width: 8.0),
            Text(
              'm',
              style: ThemeProvider.of(context)!.textTheme.caption,
            )
          ],
        ),
      ],
    );
  }

  Future<Null> _pickImage(BuildContext context) async {
    File? profilePicture = await pickAndCompressImage(_picturePicker);
    if (profilePicture != null) {
      setState(() {
        _profilePicture = profilePicture;
      });
    }
  }

  Widget _profileForm(ProfileInfoMixin$ProfileInfo? profileInfo) {
    return Form(
      key: _profileFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Ink(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    image: DecorationImage(
                      image: _profilePicture != null
                          ? FileImage(_profilePicture!)
                          : profileInfo?.profilePicture != null
                              ? NetworkImage(profileInfo!.profilePicture!)
                              : AssetImage(
                                  'assets/images/profile_picture.webp',
                                ) as ImageProvider,
                    )),
                width: 80.0,
                height: 80.0,
                child: InkWell(
                    borderRadius: BorderRadius.circular(100.0),
                    onTap: () {
                      _pickImage(context);
                    },
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                      child: Icon(Icons.photo_camera_outlined),
                    )),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _nameController,
              validator: (value) =>
                  value == null || value.isEmpty ? "Name required" : null,
              decoration: InputDecoration(hintText: "Name (required)"),
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              controller: _bioController,
              decoration: const InputDecoration(
                hintText: "Bio (Optional), max. 140 characters.",
                hintMaxLines: 2,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              DecimalNumberPicker(
                minValue: 40,
                maxValue: 180,
                itemHeight: 30,
                itemWidth: 35,
                decimalPlaces: 1,
                value: _weightController,
                onChanged: (double value) =>
                    setState(() => _weightController = value),
              ),
              const SizedBox(width: 8.0),
              Text(
                'kg',
                style: ThemeProvider.of(context)!.textTheme.caption,
              ),
              const SizedBox(width: 64.0),
              DecimalNumberPicker(
                minValue: 1,
                maxValue: 3,
                decimalPlaces: 2,
                itemHeight: 30,
                itemWidth: 35,
                value: _heightController,
                onChanged: (double value) =>
                    setState(() => _heightController = value),
              ),
              const SizedBox(width: 8.0),
              Text(
                'm',
                style: ThemeProvider.of(context)!.textTheme.caption,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _popupMenu(ProfileInfoMixin$ProfileInfo? profileInfo) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext popupContext) => [
        PopupMenuItem(
          value: "edit",
          child: Row(
            children: <Widget>[
              const Icon(Icons.edit_outlined),
              SizedBox(width: 16.0),
              const Text('Edit Profile'),
            ],
          ),
        ),
        PopupMenuItem(
          value: "logout",
          child: Row(
            children: <Widget>[
              const Icon(Icons.logout),
              SizedBox(width: 16.0),
              const Text('Log-out'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == "edit")
          setState(() {
            _heightController = profileInfo?.height ?? 1.5;
            _weightController = profileInfo?.weight ?? 50.0;
            _nameController.text = profileInfo?.name ?? '';
            _bioController.text = profileInfo?.bio ?? '';
            _editMode = true;
          });
        else if (value == "logout") {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text("Delete Workout"),
                content: Text("Are you sure you want to log-out?"),
                actions: [
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationLogoutRequested(),
                      );
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamedAndRemoveUntil(
                        LoginPage.routeName,
                        (route) => false,
                      );
                      Hive.box(appBox).delete(User.boxKeyName);
                    },
                    child: Text("Log-out"),
                  ),
                ],
              );
            },
          );
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }

  Widget _profileInfoPage(GetUserById$Query$GetUserById user) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
      child: Column(
        children: [
          if (!_editMode)
            Align(
              alignment: Alignment.topRight,
              child: _popupMenu(user.profileInfo),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    setState(() {
                      _editMode = false;
                    });
                  },
                  icon: Icon(Icons.close),
                ),
                BlocListener<UpdateProfileInfoBloc,
                    MutationState<UpdateProfileInfo$Mutation>>(
                  bloc: _updateProfileInfoBloc,
                  listener: (context, listenerState) {
                    listenerState.maybeWhen(
                      loading: () {
                        setState(() {
                          _loading = true;
                        });
                      },
                      error: (exception, result) {
                        setState(() {
                          _loading = false;
                        });

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            errorSnackBar("Error when updating profile"),
                          );
                      },
                      completed: (_, result) {
                        setState(() {
                          _loading = false;
                          _editMode = false;
                        });
                      },
                      orElse: () {},
                    );
                  },
                  child: IconButton(
                    onPressed: () {
                      if (_profileFormKey.currentState!.validate()) {
                        _updateProfileInfoBloc.run(
                          UpdateProfileInfoArguments(
                            id: user.id,
                            profileInfo: ProfileInfoInput(
                              username: user.profileInfo!.username,
                              name: _nameController.text,
                              height: _heightController,
                              weight: _weightController,
                              bio: _bioController.text,
                              profilePicture: _profilePicture != null
                                  ? MultipartFile.fromBytes(
                                      'photo',
                                      _profilePicture!.readAsBytesSync(),
                                      filename: 'profile_picture.jpg',
                                      contentType: MediaType("image", "jpg"),
                                    )
                                  : null,
                            ),
                          ).toJson(),
                        );
                      }
                    },
                    icon: Icon(Icons.save),
                  ),
                ),
              ],
            ),
          _editMode
              ? _profileForm(user.profileInfo)
              : _profileInfo(user.profileInfo),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      child: BlocBuilder<GetProfileInfoBloc, QueryState<GetUserById$Query>>(
        bloc: _getProfileInfoBloc,
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (data, _) => _profileInfoPage(data.getUserById),
            loading: (_) => Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: "Loading workout",
                    ),
                  ),
                ),
              ],
            ),
            orElse: () => Container(),
          );
        },
      ),
    );
  }
}
