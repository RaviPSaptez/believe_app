import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constant/colors.dart';

class MyNoDataWidget extends StatelessWidget {
  final String msg;

  const MyNoDataWidget({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 100),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(22)),
        width: 330,
        height: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_login_logo.png', height: 120, width: 180),
            Visibility(
              visible: msg.isNotEmpty,
              child: Text(
                msg,
                style: const TextStyle(color: black, fontSize: 20, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
