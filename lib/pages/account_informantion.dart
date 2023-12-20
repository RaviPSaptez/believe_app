import 'package:believe_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../constant/colors.dart';
import '../data/staticdata.dart';
import '../utils/base_class.dart';
import '../utils/session_manager_new.dart';
import 'login/login_with_mobile_screen.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends BaseState<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f2fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                appBar(context),
                const SizedBox(height: 60),
                profileHeader(),
                const SizedBox(height: 50),
                // Heading for Quick Info
                heading('Quick Info'),
                const SizedBox(height: 10),
                listSection(QuickInfo.quickInfo, 'Find your Profile, lockers, tasks, leaves here.'),
                const SizedBox(height: 30),
                heading('Activity'),
                listSection(ActivityData.activityInfo, 'Find announcement, events, birthday reminders, motivational quotes & kudoshere.'),
                const SizedBox(height: 30),
                heading('App Settings'),
                listSection(AppSettings.settings, 'Get the best out of your believe profile.'),
                const SizedBox(height: 30),
              ],
            ),
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
          onTap: () => Navigator.pop(context),
          child: Container(
            // height: 50,
            width: 50,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset('assets/svgs/navigationBack.svg', width: 22, height: 22),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            logoutFromApp();
          },
          child: Container(
            // height: 50,
            width: 50,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset('assets/svgs/exit.svg', width: 22, height: 22),
            ),
          ),
        ),
      ],
    );
  }

  Widget heading(String heading) {
    return Text(heading, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget listSection(List list, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(description, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 18),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {

                  if(list[index].title.toString() == "My Tasks")
                    {
                      if(checkValidString(checkRights("my_tasks").viewRights) == "1")
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => list[index].screen));
                      }
                      else
                      {
                        showToast("You are not allowed to use this features", context);
                      }
                    }
                  else if(list[index].title.toString() == "Events")
                  {
                    if(checkValidString(checkRights("events").viewRights) == "1")
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => list[index].screen));
                    }
                    else
                    {
                      showToast("You are not allowed to use this features", context);
                    }
                  }
                  else
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => list[index].screen));
                    }
                },
                child: Container(
                  height: 85,
                  padding: const EdgeInsets.all(18),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Row(children: [
                    Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(color: list[index].iconBackgroundColor, borderRadius: const BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(list[index].svgPath.toString(), width: 20, height: 20),
                        )),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(list[index].title.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(list[index].description.toString(), style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,color: grayDark,size: 18,)
                  ]),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: list.length)
      ],
    );
  }

  Widget profileHeader() {
    return Column(
      children: [
        SizedBox(
          height: 130,
          width: 130,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(42),
            //Profile Image
            child: Image.network(
                fit: BoxFit.cover, checkValidString(sessionManager.getProfilePic()).toString().isNotEmpty ? checkValidString(sessionManager.getProfilePic()).toString() : 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
          ),
        ),
        const SizedBox(height: 30),
        // User's name
        Text(toDisplayCase(checkValidString(sessionManager.getName())), style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: checkValidString(sessionManager.getEmail()).toString().isNotEmpty,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(checkValidString(sessionManager.getEmail()), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    const VerticalDivider(thickness: 1, color: Colors.black),
                  ],
                ),
              ),
              Text(checkValidString(sessionManager.getContactNo()), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
                visible: checkValidString(sessionManager.getDesignation()).toString().isNotEmpty,
                child: Text(toDisplayCase(checkValidString(sessionManager.getDesignation())), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            Visibility(
                visible: checkValidString(sessionManager.getDesignation()).toString().isNotEmpty && checkValidString(sessionManager.getDepartment()).toString().isNotEmpty,
                child: const Text(" - ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            Visibility(
                visible: checkValidString(sessionManager.getDepartment()).toString().isNotEmpty,
                child: Text(toDisplayCase(checkValidString(sessionManager.getDepartment())), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
          ],
        )

      ],
    );
  }

  void logoutFromApp() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              decoration:
                  const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)), color: white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text('Logout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: orange))),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10, bottom: 15, left: 12),
                    child: const Text('Are you sure want to Logout?', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: black)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 12, top: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: 42,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(width: 1, color: button_bg),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(white)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: button_bg)),
                                ))),
                        const Gap(15),
                        Expanded(
                          child: SizedBox(
                            height: 42,
                            child: TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side: const BorderSide(width: 1, color: button_bg),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(button_bg)),
                              onPressed: () {
                                Navigator.pop(context);
                                SessionManagerNew.clear();
                                Navigator.pushAndRemoveUntil(
                                    context, MaterialPageRoute(builder: (context) => const LoginWithMobileScreen()), (Route<dynamic> route) => false);
                              },
                              child: const Text("Logout", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(30)
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void castStatefulWidget() {
    // TODO: implement castStatefulWidget
  }
}
