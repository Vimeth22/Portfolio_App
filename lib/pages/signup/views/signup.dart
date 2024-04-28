import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio_app/authentication/auth_service.dart';
import 'package:portfolio_app/components/Auth_TextField.dart';
import 'package:portfolio_app/components/Confirm_Button.dart';
import 'package:portfolio_app/pages/home/views/menu_layer.dart';
import 'package:portfolio_app/pages/signup/views/signup.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool loading = false;

  void _signup() async {
    // You can implement your login logic here
    String email = _emailController.text.trim();
    String username = _usernamecontroller.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter username')));
      return;
    }

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter email and password')));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match.')));
      return;
    }

    try {
      setState(() {
        loading = true;
      });

      UserCredential? userCredential = await AuthService.signup(email, password);

      String? userId = userCredential?.user?.uid;

      if (userId != null) {
        await _firestore.collection('users').doc(userId).set({
          'username': username,
          'email': email
        });
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuLayer()));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );

      setState(() {
        loading = false;
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("lib/assets/auth-background.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    Text('Portfolio.',
                        style: TextStyle(
                          fontFamily: 'DM Serif Display',
                          fontSize: 80,
                          height: 1,
                        )),
                    Text('where greatness resides.',
                        style: TextStyle(
                          fontFamily: 'Titillium Web',
                          fontSize: 22,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 340.0, left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthTextField(controller: _usernamecontroller, hintText: 'username'),
                      SizedBox(height: 15),
                      AuthTextField(controller: _emailController, hintText: 'email'),
                      SizedBox(height: 15),
                      AuthTextField(
                        controller: _passwordController,
                        hintText: 'password',
                        obscure: true,
                      ),
                      SizedBox(height: 15),
                      AuthTextField(
                        controller: _confirmPasswordController,
                        hintText: 'confirm password',
                        obscure: true,
                      ),
                      SizedBox(height: 15),
                      ConfirmButton(
                        text: 'Sign up',
                        callback: _signup,
                        loading: loading,
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
