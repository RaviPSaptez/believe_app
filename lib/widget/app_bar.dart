import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../constant/colors.dart';
import '../utils/app_utils.dart';

class AppBarWidget extends StatelessWidget {
  final String pageName;
  const AppBarWidget({Key? key, required this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              // Navigator.pop(context);
            },
            child: Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: blueDark),
                height: 42,
                width: 42,
                padding: const EdgeInsets.all(13),
                child: Image.asset('assets/images/ic_back_arrow.png', height: 28, width: 28)),
          ),
          const Gap(12),
          Expanded(
            child: Text(
              pageName,
              textAlign: TextAlign.start,
              style: titleFontNormal(white,20),
            ),
          ),
          GestureDetector(
            onTap: (){
              // Navigator.pop(context);
            },
            child: Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: blueDark),
                height: 42,
                width: 42,
                padding: const EdgeInsets.all(13),
                child: Image.asset('assets/images/ic_add.png', height: 28, width: 28)),
          ),
        ],
      ),
    );
  }
}
