import 'dart:convert';
import 'dart:io';
import 'package:believe_app/utils/base_class.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../constant/api_end_point.dart';
import '../../model/other/BasicResponseModel.dart';
import '../login/account_informantion.dart';
import '../other/blank_page.dart';
import 'dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  String selectedLabelforBottomNavigationBar = 'Home';

  Widget selectedScreen()
  {
    switch(selectedLabelforBottomNavigationBar){
      case 'Kudos' :
        {
          return const BlankPage();
        }
      case 'Motivate' :
        {
          return const BlankPage();
        }
      default:
        {
          return const DashboardScreen();
        }
    }
  }

  @override
  void initState()
  {
    super.initState();
    getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedScreen(),
      bottomNavigationBar: bottomNavigationBox(),
    );
  }

  Widget bottomNavigationBox(){
    return Material (
      elevation: 20,
      color: Colors.white,
      shadowColor: Colors.grey,
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  setState((){
                    selectedLabelforBottomNavigationBar = 'Home';
                  });
                },
                child: bottomNavigationItem('assets/svgs/logo.svg', 'Home', selectedLabelforBottomNavigationBar, 'assets/svgs/logo.svg')),
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  setState((){
                    selectedLabelforBottomNavigationBar = 'Kudos';
                  });
                },
                child: bottomNavigationItem('assets/svgs/kudosBlack.svg', 'Kudos', selectedLabelforBottomNavigationBar, 'assets/svgs/kudosOnClick.svg')),
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  setState((){
                    selectedLabelforBottomNavigationBar = 'Motivate';
                  });
                },
                child: bottomNavigationItem('assets/svgs/motivateBlack.svg', 'Motivate', selectedLabelforBottomNavigationBar, 'assets/svgs/motivationOnClick.svg')),
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountInfo()));
                  setState((){
                    selectedLabelforBottomNavigationBar = 'Menu';
                  });
                },
                child: bottomNavigationItem('assets/svgs/menu.svg', 'Menu', selectedLabelforBottomNavigationBar, 'assets/svgs/menu.svg'))
          ],
        ),
      ),
    );
  }

  Widget bottomNavigationItem(String svgPath, String label, String selectedLabel, String altSvgPath){
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(label == selectedLabel ? altSvgPath : svgPath, height: label == 'Menu' ? 22 : 25,width:label == 'Menu' ? 22 : 25),
          const SizedBox(height: 10),
          Text(label,style: TextStyle(fontFamily: 'Recoleta',fontWeight: FontWeight.bold, color: label == selectedLabel ? const Color(0xffF78D28): Colors.black,))
        ],
      ),
    );
  }

  Future<void> getDeviceToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    sessionManager.setDeviceToken(fcmToken.toString());
    print("*************** $fcmToken");

    if(sessionManager.getDeviceToken().toString().trim().isNotEmpty)
    {
      _updateDeviceTokenData();
    }
  }

  _updateDeviceTokenData() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL + updateDeviceToken);
    var deviceType = "";
    if (Platform.isIOS)
    {
      deviceType = "IOS";
    }
    else if (Platform.isWindows)
    {
      deviceType = "Web";
    }
    else
    {
      deviceType = "Android";
    }

    Map<String, String> jsonBody = {
      'call_app' : CALL_APP,
      'from_app' : IS_FROM_APP,
      'logged_in_user_id' : sessionManager.getId().toString(),
      'device_type': deviceType,
      'token_id': sessionManager.getDeviceToken().toString().trim()};

    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": API_Token,
    });

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = BasicResponseModel.fromJson(apiResponse);

  }

  @override
  void castStatefulWidget() {
  }
}
