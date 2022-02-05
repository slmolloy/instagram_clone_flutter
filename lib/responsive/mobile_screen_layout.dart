import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:instagram_flutter/models/user.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(child: Container(), flex: 2),
            Text('Username: ${user.username}'),
            Text('Email: ${user.email}'),
            Flexible(child: Container(), flex: 2),
          ],
        ),
      ),
    );
  }
}
