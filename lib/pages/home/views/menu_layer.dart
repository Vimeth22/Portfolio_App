import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/navigation/navigation_provider.dart';
import 'package:portfolio_app/pages/login/views/login.dart';
import 'package:provider/provider.dart';

class MenuLayer extends StatefulWidget {
  @override
  State<MenuLayer> createState() => _MenuLayerState();
}

class _MenuLayerState extends State<MenuLayer> {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return LoginPage();
    }

    void onItemTapped(int index) {
      setState(() {
        navigationProvider.setIndex(index);
      });
    }

    return Scaffold(
      body: navigationProvider.screens[navigationProvider.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.selectedIndex,
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 232, 177, 68),
        unselectedItemColor: Colors.black,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "")
        ],
      ),
    );
  }
}
