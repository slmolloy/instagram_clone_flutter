import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:instagram_flutter/models/user.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  Color getIconColor(int tabPosition) {
    return tabPosition == _page ? primaryColor : secondaryColor;
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        children: [
          Center(
            child: Column(
              children: [
                Flexible(child: Container(), flex: 2),
                Text('Username: ${user.username}'),
                Text('Email: ${user.email}'),
                Flexible(child: Container(), flex: 2),
              ],
            ),
          ),
          Center(
            child: Text('Search'),
          ),
          Center(
            child: Text('Add Post'),
          ),
          Center(
            child: Text('Notifications'),
          ),
          Center(
            child: Text('Profile'),
          ),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: getIconColor(0)),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: getIconColor(1)),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, color: getIconColor(2)),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: getIconColor(3)),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: getIconColor(4)),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
