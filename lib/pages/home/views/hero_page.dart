import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/login/views/login.dart';
import 'package:portfolio_app/pages/signup/views/signup.dart';

class HeroPage extends StatefulWidget {
  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("lib/assets/hero-background.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * .35,
                      decoration: BoxDecoration(color: Color.fromARGB(255, 232, 177, 68), borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Get Started',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Titillium Web"),
                        ),
                      )),
                ),
                SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * .35,
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                        child: Text(
                          'Sign in',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Titillium Web", color: Colors.white),
                        ),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                  child: Text(
                    'photo by eberhard grossgasteiger',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
