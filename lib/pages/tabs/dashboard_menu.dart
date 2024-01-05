import 'dart:convert';
import 'dart:io';
import 'package:believe_app/pages/storage/storage_screen.dart';
import 'package:believe_app/pages/task/my_task_list_screen.dart';
import 'package:believe_app/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../constant/staticdata.dart';
import '../../model/other/BasicResponseModel.dart';
import '../../model/other/MenuItemsReposnse.dart';
import '../../utils/base_class.dart';
import '../login/account_informantion.dart';
import '../birthdays/birthdays_screen.dart';
import '../other/blank_page_new.dart';
import '../event_news/event_and_news_screen.dart';

class DashboardWithMenuScreen extends StatefulWidget {

  const DashboardWithMenuScreen({Key? key}) : super(key: key);

  @override
  _DashboardWithMenuScreenState createState() => _DashboardWithMenuScreenState();

}

class _DashboardWithMenuScreenState extends BaseState<DashboardWithMenuScreen> {
  int currentIndex = 0;
  String selectedLabelforBottomNavigationBar = 'Home';
  List<MenuItems> listMenu = List<MenuItems>.empty(growable: true);

  @override
  void initState() 
  {
    if(checkValidString(sessionManager.getDeviceToken()).toString().trim().isEmpty)
    {
      getDeviceToken();
    }
    else
    {
        print("<><> My Token :: " + sessionManager.getDeviceToken().toString().trim() + " <><>");
    }
    _getMenuItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: grayLight,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: grayLight,
      appBar: AppBar(
          toolbarHeight: 65,
          automaticallyImplyLeading: false,
          backgroundColor: grayLight,
          elevation: 0,
          titleSpacing: 0,
          centerTitle: false,
          title: appBar(context)),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BannerSlider(currentIndex: currentIndex),
                const Gap(20),
                (listMenu.isNotEmpty) ? menuListWidget() : Container(),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: bottomNavigationBox()
    );
  }

  _getMenuItems() async {
    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + menuItems);
      Map<String, String> jsonBody = {
        'logged_in_user_id': sessionManager.getId().toString(),
        'call_app' : CALL_APP,
        'from_app': IS_FROM_APP
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      listMenu = [];
      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = MenuItemsReposnse.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              listMenu = dataResponse.data!;
            }
          }
        } catch (e) {
          print(e);
        }
      } else {
        showSnackBar(dataResponse.message, context);
      }
    } else {
      noInterNet(context);
    }

    setState(() {

    });
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              startActivity(context, AccountInfo());
            },
            child: SizedBox(
              height: 42,
              width: 42,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(48),
                //Profile Image
                child: Image.network(
                    fit: BoxFit.cover, checkValidString(sessionManager.getProfilePic()).toString().isNotEmpty ? checkValidString(sessionManager.getProfilePic()).toString() : 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
              ),
            ),
          ),
          const Gap(12),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountInfo()));
            },
            child: SizedBox(height: 36, child: Image.asset('assets/images/logo.png')),
          ),
          const Spacer(),
          SvgPicture.asset('assets/svgs/notifications.svg', width: 22, height: 22),
        ],
      ),
    );
  }


  GridView menuListWidget() {
    return GridView.builder(
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
          mainAxisExtent: 120, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemCount: listMenu.length,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            if(listMenu[index].type.toString() == "my_tasks")
            {
              if(checkValidString(checkRights("my_tasks").viewRights) == "1")
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyTaskListScreen()));
              }
              else
              {
                showToast("You are not allowed to use this features", context);
              }
            }
            else if(listMenu[index].type.toString() == "events")
            {
              if(checkValidString(checkRights("events").viewRights) == "1")
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EventScreen()));
              }
              else
              {
                showToast("You are not allowed to use this features", context);
              }
            }
            else if(listMenu[index].type.toString() == "birthday_reminders")
            {
              if(checkValidString(checkRights("birthday_reminders").viewRights) == "1")
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BirthDayScreen()));
              }
              else
              {
                showToast("You are not allowed to use this features", context);
              }
            }
            else if(listMenu[index].type.toString() == "locker_my_Documents")
            {
              if(checkValidString(checkRights("locker_my_Documents").viewRights) == "1")
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StorageScreen()));
              }
              else
              {
                showToast("You are not allowed to use this features", context);
              }
            }
            else
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BlankPageNew(listMenu[index].name.toString())));
            }
          },
          child: Card(
            color: white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kButtonCornerRadius),
              //side: BorderSide(color: blue,width: 0.5)// if you need this
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: listMenu[index].icon.toString().trim(),
                    fit: BoxFit.contain,
                    width: 32,
                    height: 32,
                    color: Color(int.parse(listMenu[index].color.toString().replaceAll('#', '0xff'))),
                    errorWidget: (context, url, error) => Image.asset('assets/images/ic_only_icon.png', width: 25, height: 25),
                  ),
                  const Gap(12),
                  Text(
                    toDisplayCase(checkValidString(listMenu[index].name.toString())),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: font16(black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

Widget bannerIndicator(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 150),
    margin: const EdgeInsets.symmetric(horizontal: 6),
    height: isActive ? 12 : 8,
    width: isActive ? 12 : 8,
    decoration: BoxDecoration(
      color: isActive ? const Color(0xffF78D28) : const Color(0xffF78D28).withOpacity(0.4),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
  );
}

class BannerSlider extends StatefulWidget {
  var currentIndex;

  BannerSlider({this.currentIndex});

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 220,
            child: LoopPageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    widget.currentIndex = value;
                    // print(currentIndex);
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(kButtonCornerRadius),
                    child: Image.asset(StaticData.img[index],fit: BoxFit.cover,),

                  );
                },
                itemCount: StaticData.img.length)
            // PageView.builder(
            //   onPageChanged: (value) {
            //     setState(() {
            //       currentIndex = value;
            //       // print(currentIndex);
            //     });
            //   },
            //   itemCount: Data.img.length,
            //   scrollDirection: Axis.horizontal,
            //   itemBuilder: (context, index) {
            //     // return Image.asset(Data.img[index % Data.img.length]);
            //     return Image.asset(Data.img[index]);
            //   },
            // ),
            ),
        const SizedBox(height: 20),
        SizedBox(
          height: 20,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (int i = 0; i < StaticData.img.length; i++)
              if (widget.currentIndex == i) bannerIndicator(true) else bannerIndicator(false)
          ]),
        ),
      ],
    );
  }
}


