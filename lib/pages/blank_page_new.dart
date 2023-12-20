import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../constant/colors.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../widget/no_data.dart';
import 'account_informantion.dart';

class BlankPageNew extends StatefulWidget {
  String pageName;
  BlankPageNew(this.pageName,{Key? key}) : super(key: key);

  @override
  _BlankPageNewState createState() => _BlankPageNewState();
}

class _BlankPageNewState extends BaseState<BlankPageNew> {

  String pageName = "";
  @override
  void initState() {
    pageName = (widget as BlankPageNew).pageName;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: black,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              appBar(context),
              Gap(100),
              const Expanded(child: MyNoDataWidget(msg: "Coming soon!"))
            ],
          ),
        ),
      ),
    );
  }


  Widget appBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: black),
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
            style: titleFontNormal(black, 20),
          ),
        ),
      ],
    );
  }

  @override
  void castStatefulWidget() {
    // TODO: implement castStatefulWidget
  }
}
