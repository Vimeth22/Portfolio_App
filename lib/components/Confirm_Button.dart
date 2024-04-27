import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConfirmButton extends StatelessWidget {
  void Function()? callback;
  String text;
  bool? loading;

  ConfirmButton({super.key, required this.text, required this.callback, this.loading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(2)),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: loading == null || loading == false
                ? Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: "Titillium Web"),
                  )
                : Container(
                    height: 35,
                    child: Center(
                      child: Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
      ),
    );
  }
}
