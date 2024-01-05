import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../constant/colors.dart';
import '../../utils/base_class.dart';
import '../../widget/no_data.dart';
import '../login/account_informantion.dart';

class BlankPage extends StatefulWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends BaseState<BlankPage> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AccountInfo()));
          },
          child: SizedBox(
              height: 45,
              child: Image.asset('assets/images/logo.png')),),
        Row(
          children: [
            SvgPicture.asset('assets/svgs/search.svg',width: 24,height: 24),
            const SizedBox(width: 15),
            SvgPicture.asset('assets/svgs/notifications.svg',width: 24,height: 24),
          ],
        )
      ],
    );
  }

  @override
  void castStatefulWidget() {
    // TODO: implement castStatefulWidget
  }
}
