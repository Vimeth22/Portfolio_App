import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthTextField extends StatelessWidget {
  TextEditingController controller;
  String? hintText;
  bool? obscure;

  AuthTextField({super.key, required this.controller, this.obscure, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: TextField(
          controller: controller,
          obscureText: obscure ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontFamily: "Titillium Web", fontWeight: FontWeight.w500, color: Colors.black),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
