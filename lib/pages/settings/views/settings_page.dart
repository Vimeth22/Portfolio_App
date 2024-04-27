import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/login/views/login.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    _logout() async {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontFamily: "Titillium Web"),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ListTile(
            onTap: _logout,
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
