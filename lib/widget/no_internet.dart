import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../constant/colors.dart';

class NoInternetWidget extends StatelessWidget {

  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(kNoDataViewCornerRadius))),
                      elevation: 0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 22.0, bottom: 22, left: 40, right: 40),
                        child: Image.asset("assets/images/ic_login_logo.png", width: 120,height: 120),
                      )
                  ),
                  const Gap(6),
                  const Text("Oops!", style: TextStyle(color: black, fontSize: 20, fontWeight: FontWeight.bold,),),
                  const Gap(6),
                  const Text("No internet connection found,\nCheck your connection.",
                    style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w500,),
                    textAlign: TextAlign.center,),
                ],
              ),
            ),
          ],
        ));
  }
}
