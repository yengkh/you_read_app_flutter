import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/screens/download_page/download_page.dart';
import 'package:you_read_app_flutter/screens/favorite_page/favorite_page.dart';
import 'package:you_read_app_flutter/screens/home_page_body/home_page_body.dart';
import 'package:you_read_app_flutter/screens/profile_page/profile_page.dart';
import 'package:you_read_app_flutter/screens/setting_page/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> bodyList = [
    const HomePageBody(),
    const FavoritePageTwo(),
    const DownloadPage(),
    const SettingPage(),
    const ProfilePage(),
  ];

  final List<IconData> _iconList = [
    Icons.home,
    Icons.favorite,
    Icons.download,
    Icons.settings,
    Icons.person
  ];

  @override
  Widget build(BuildContext context) {
    // Get current theme mode
    final themeMode = AdaptiveTheme.of(context).mode;
    // Determine active color based on theme mode
    final activeColor =
        themeMode == AdaptiveThemeMode.dark ? Colors.black : Colors.white;

    return Scaffold(
      body: bodyList[_currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: activeColor,
        //backgroundColor: ThemDataClass.appBarBackgrowndColor,
        backgroundColor: Colors.blue[400],
        blurEffect: true,
        gapWidth: 1.0,
        icons: _iconList,
        activeIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
