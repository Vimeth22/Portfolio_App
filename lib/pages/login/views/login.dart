import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio_app/authentication/auth_service.dart';
import 'package:portfolio_app/components/Auth_TextField.dart';
import 'package:portfolio_app/components/Confirm_Button.dart';
import 'package:portfolio_app/pages/home/views/menu_layer.dart';
import 'package:portfolio_app/pages/signup/views/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    // You can implement your login logic here
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter email and password')));
      return;
    }

    try {
      await AuthService.login(email, password);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuLayer()));
    } on FirebaseAuthException catch (e) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  padding: const EdgeInsets.only(bottom: 200.0, left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthTextField(controller: _emailController, hintText: 'email'),
                      SizedBox(height: 20),
                      AuthTextField(
                        controller: _passwordController,
                        hintText: 'password',
                        obscure: true,
                      ),
                      SizedBox(height: 20),
                      ConfirmButton(text: 'Sign in', callback: _login),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(fontFamily: 'Titillium Web', fontSize: 15),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Sign up',
                              style: TextStyle(
                                fontFamily: 'Titillium Web',
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
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
