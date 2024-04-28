import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/feed/views/feed_page.dart';
import 'package:portfolio_app/pages/profile/views/profile_page.dart';
import 'package:portfolio_app/pages/settings/views/settings_page.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 1;

  int get selectedIndex => _selectedIndex;

  void setIndex(index) {
    _selectedIndex = index;
    notifyListeners();
  }

  final List<Widget> _screens = [
    SettingsPage(),
    FeedPage(),
    ProfilePage(),
  ];

  List<Widget> get screens => _screens;
}
