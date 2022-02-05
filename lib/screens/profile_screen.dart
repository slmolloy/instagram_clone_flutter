import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _PorfileScreenState createState() => _PorfileScreenState();
}

class _PorfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;

  void logOutUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().logOutUser();

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      showSnackBar("Logged out", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;

    return Center(
      child: Column(
        children: [
          Flexible(child: Container(), flex: 2),
          Text('Username: ${user.username}'),
          Text('Email: ${user.email}'),
          Text('Bio: ${user.bio}'),
          Text('Followers: ${user.followers.length}'),
          Text('Following: ${user.following.length}'),
          Flexible(child: Container(), flex: 2),
          InkWell(
            onTap: logOutUser,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Log out'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  color: blueColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
