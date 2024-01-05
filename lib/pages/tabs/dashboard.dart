import 'dart:convert';

import 'package:believe_app/pages/task/my_task_list_screen.dart';
import 'package:believe_app/pages/task/task_detail_page.dart';
import 'package:believe_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../constant/staticdata.dart';
import '../../model/task/TaskListResponseModel.dart';
import '../../model/task/TaskPriorityListResponse.dart';
import '../../utils/base_class.dart';
import '../event_news/event_and_news_screen.dart';
import '../leave/my_leave_screen.dart';
import '../login/account_informantion.dart';

class DashboardScreen extends StatefulWidget {

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();

}

class _DashboardScreenState extends BaseState<DashboardScreen> {
  int currentIndex = 0;
  String selectedLabelforBottomNavigationBar = 'Home';
  List<TaskListData> listTask = List<TaskListData>.empty(growable: true);

  @override
  void initState() {
    _getTaskListDataFromAPI();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Appbar contains logo and action icons
                appBar(context),
                const SizedBox(height: 20),
                // Slider for Banner
                BannerSlider(currentIndex: currentIndex),
                const SizedBox(height: 20),
                // Box Container for Quotes
                quouteBox(context),
                const SizedBox(height: 20),
                // Profile Glimpes box
                profileBox(context),
                const SizedBox(height: 30),
                // Section for Quick Links
                quickLinksSection(),
                const SizedBox(height: 30),
                // Section for Announcement
                announcementSection(context),
                // Some other Options
                otherOptions(),
                // Task List
                (listTask.isNotEmpty && checkValidString(checkRights("my_tasks").viewRights) == "1") ? myTasksSection() : Container(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: bottomNavigationBox()
    );
  }


  @override
  void castStatefulWidget() {
    // TODO: implement castStatefulWidget
  }

  _getTaskListDataFromAPI() async {
    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + taskList);
      Map<String, String> jsonBody = {
        'logged_in_user_id': sessionManager.getId().toString(),
        'from_app': IS_FROM_APP,
        'search' : "",
        'status_ids' : "",
        'page' : "1",
        'limit' :"2"
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      listTask = [];
      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = TaskListResponseModel.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              listTask = dataResponse.data!;
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

  Widget headings(String heading, String icon, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Image.asset(icon, width: 25, height: 25),
            const SizedBox(width: 5),
            Text(heading, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Recoleta'))
          ],
        ),
        if (isActive)
          const Row(
            children: [Text('View all', style: TextStyle(color: Colors.orange)), Icon(Icons.arrow_forward_ios_rounded, size: 10, color: Colors.orange)],
          )
      ],
    );
  }

  Widget appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountInfo()));
          },
          child: SizedBox(height: 45, child: Image.asset('assets/images/logo.png')),
        ),
        Row(
          children: [
            SvgPicture.asset('assets/svgs/search.svg', width: 24, height: 24),
            const SizedBox(width: 15),
            SvgPicture.asset('assets/svgs/notifications.svg', width: 24, height: 24),
          ],
        )
      ],
    );
  }

  Widget quouteBox(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.orange.withOpacity(0.2), border: Border.all(color: themeOrange, width: 2)),
          width: MediaQuery.of(context).size.width,
          height: 160,
        ),
        Positioned(
            top: 10,
            left: 10,
            child: SizedBox(
              height: 80,
              width: 95,
              child: Opacity(opacity: 0.8, child: SvgPicture.asset('assets/svgs/quoteSVG2.svg')),
            )),
        Positioned(
            top: 30,
            left: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Good Morning Jinkal,',
                    style: TextStyle(color: Color(0xffF56A01), fontFamily: 'Recoleta', fontSize: 18, fontWeight: FontWeight.w500)),
                SizedBox(
                  // color: Colors.blue,
                  width: MediaQuery.of(context).size.width / 1.65,
                  child: const Text('All our Dreams can come true, if we have courage to puruse them.',
                      maxLines: 3, style: TextStyle(color: themeBlack, fontFamily: 'Recoleta', fontSize: 18, fontWeight: FontWeight.w500)),
                )
              ],
            )),
        Positioned(
          bottom: 15,
          right: 15,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.orange[700], borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset('assets/svgs/like.svg', width: 25, height: 25),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(color: Colors.orange[700], borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset('assets/svgs/share.svg', width: 25, height: 25),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget profileBox(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 160,
      decoration: BoxDecoration(border: Border.all(color: themeBlue), borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 12),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(borderRadius: BorderRadius.circular(50), child: checkValidString(sessionManager.getProfilePic()).toString().isNotEmpty ?
                  Image.network(
                      fit: BoxFit.cover, checkValidString(sessionManager.getProfilePic()).toString()) : Image.asset('assets/images/placeholder.jpg')),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(toDisplayCase(checkValidString(sessionManager.getName())), style: TextStyle(color: themeBlue, fontWeight: FontWeight.bold, fontSize: 18)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: 60,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: themeBlue)),
                  child: const Center(child: Text('Edit', style: TextStyle(fontSize: 16, color: themeBlue))),
                )
              ],
            ),
            const SizedBox(height: 18),
            LinearProgressIndicator(
              minHeight: 6,
              color: themeBlue,
              backgroundColor: Colors.grey.withOpacity(0.5),
              value: 0.6,
            ),
            const SizedBox(height: 10),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Average', style: TextStyle(color: themeBlue, fontSize: 15, fontFamily: 'Recoleta', fontWeight: FontWeight.bold)),
                  Text('Performace', style: TextStyle(color: themeGrey, fontSize: 12))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('60%', style: TextStyle(color: themeBlue, fontSize: 15, fontFamily: 'Recoleta', fontWeight: FontWeight.bold)),
                  Text('Efficiency', style: TextStyle(color: themeGrey, fontSize: 12))
                ],
              )
            ])
          ],
        ),
      ),
    );
  }

  Widget quickLinksSection() {
    return Column(
      children: [
        headings('Quick Links', 'assets/images/QuickLinkIcon.png', false),
        const SizedBox(height: 15),
        SizedBox(
          height: 150,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2.6,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: QuickLinks.linkdata.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (QuickLinks.linkdata[index].name.toString() == "Events")
                  {
                    if(checkValidString(checkRights("events").viewRights) == "1")
                    {
                      startActivity(context, EventScreen());
                    }
                    else
                    {
                      showToast("You are not allowed to use this features", context);
                    }

                  }
                  else if(QuickLinks.linkdata[index].name.toString() == "Apply Leave")
                    {
                      startActivity(context, LeavesScreen());
                    }
                },
                child: Container(
                  decoration: BoxDecoration(color: QuickLinks.linkdata[index].backgroundColor, borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(QuickLinks.linkdata[index].svgPath.toString(), height: 20, width: 20),
                        const SizedBox(width: 5),
                        Text(QuickLinks.linkdata[index].name.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget announcementSection(BuildContext context) {
    DateTime announcementDate = DateTime(2023, 9, 24, 4, 00);
    String formattedDate = DateFormat('d MMM, y | H:mm a').format(announcementDate);
    return Column(
      children: [
        headings('Announcement', 'assets/images/AnnouncementIcon.png', true),
        const SizedBox(height: 20),
        SizedBox(
          // width: MediaQuery.of(context).size.width,
          height: 250,
          child: Stack(
            children: [
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(color: const Color(0xffE6E5EB), borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              Positioned(
                top: 95,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(color: const Color(0xffF7F8FA), borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: themeOrange), borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Dear Believers,', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Expanded(
                            child: Text(
                                'Exciting news! We have a valuable training opportunity just around the corner to enhance your skills and boost your professional development. Mark your calendars for 24th November, 2023!',
                                style: TextStyle(fontSize: 12)),
                          ),
                          const SizedBox(height: 5),
                          Text(formattedDate, style: const TextStyle(color: themeOrange))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget otherOptions() {
    return SizedBox(
      // width: MediaQuery.of(context).size.width,
      height: 150,
      child: Center(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: OtherSections.sectionData.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (OtherSections.sectionData[index].name.toString() == "Task List") {

                  if(checkValidString(checkRights("my_tasks").viewRights) == "1")
                    {
                      startActivity(context, MyTaskListScreen());
                    }
                  else
                    {
                      showToast("You are not allowed to use this features", context);
                    }
                }
              },
              child: Column(
                children: [
                  Container(
                      height: 74,
                      decoration: BoxDecoration(color: OtherSections.sectionData[index].backgroundColor, borderRadius: BorderRadius.circular(12)),
                      // width: MediaQuery.of(context).size.width * 0.20,
                      width: 74,
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: SvgPicture.asset(OtherSections.sectionData[index].svgPath.toString()),
                      )),
                  const SizedBox(height: 15),
                  SizedBox(
                      width: 72,
                      child: Text(OtherSections.sectionData[index].name.toString(), style: const TextStyle(fontSize: 12), textAlign: TextAlign.center))
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 15),
        ),
      ),
    );
  }

  Widget myTasksSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset('assets/images/myTaskIcon.png', width: 25, height: 25),
                const SizedBox(width: 5),
                Text("My Tasks", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Recoleta'))
              ],
            ),
            GestureDetector(
              onTap: (){
                if(checkValidString(checkRights("my_tasks").viewRights) == "1")
                {
                  startActivity(context, MyTaskListScreen());
                }
                else
                {
                  showToast("You are not allowed to use this features", context);
                }
              },
              child: Row(
                children: [Text('View all', style: TextStyle(color: Colors.orange)), Icon(Icons.arrow_forward_ios_rounded, size: 10, color: Colors.orange)],
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        taskListWidget(),
      ],
    );
  }

  ListView taskListWidget() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemCount: listTask.length,
      itemBuilder: (ctx, index) => taskListItem(index),
    );
  }

  taskListItem(int index) {
    return GestureDetector(
      onTap: () async {
        if(checkValidString(checkRights("my_tasks").viewRights) == "1")
        {
          hideKeyboard(context);
          List<TaskPriorityData> listPriority = List<TaskPriorityData>.empty(growable: true);
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskDetailPage(listTask[index],listPriority)),
          );
          print("result ===== $result");
          if (result == "success") {
            setState(() {});
            _getTaskListDataFromAPI();
          }
        }
        else
        {
          showToast("You are not allowed to use this features", context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(12), border: Border.all(color: editTextBorder,width: 0.5)),
        padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
        margin: const EdgeInsets.only(top: 12,bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                        checkValidString(listTask[index].title).toString().isNotEmpty ? toDisplayCase(checkValidString(listTask[index].title)) : "",
                        style: font16SemiBold(black))),
                Image.asset('assets/images/ic_date.png', height: 20, width: 20),
                const Gap(4),
                Text(checkValidString(listTask[index].createdAtDateTime!.time).toString(), style: font15(graySemiDark)),
              ],
            ),
            const Gap(10),
            Visibility(visible: checkValidString(listTask[index].description).toString().isNotEmpty,
                child: Text(toDisplayCase(checkValidString(listTask[index].description)),
                    style: font15(graySemiDark))),
            const Gap(15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Status", style: font15(black)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(int.parse(listTask[index].status!.color.toString().replaceAll('#', '0xff'))),
                                          borderRadius: BorderRadius.circular(12)),
                                      width: 12,
                                      height: 12,
                                    ),
                                    const Gap(4),
                                    Text(checkValidString(listTask[index].status!.name).toString().toUpperCase(),
                                        style: font16SemiBold(Color(int.parse(listTask[index].status!.color.toString().replaceAll('#', '0xff')))))
                                  ],
                                ),
                              ],
                            )),
                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Priority", style: font15(black)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FadeInImage.assetNetwork(
                                        image: listTask[index].priority!.flag.toString().trim(),
                                        fit: BoxFit.cover,
                                        width: 12,
                                        height: 12,
                                        placeholder: 'assets/images/ic_flag.png'),
                                    const Gap(4),
                                    Text(checkValidString(listTask[index].priority!.name).toString().toUpperCase(),
                                        style: font16SemiBold(Color(int.parse(listTask[index].priority!.color.toString().replaceAll('#', '0xff')))))
                                  ],
                                ),
                              ],
                            )),
                      ],
                    )),
                Expanded(flex: 1, child: Container())
              ],
            ),
            const Gap(15),
            Text("Assign to:", style: font15(black)),
            const Gap(10),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(color: assignBg, borderRadius: BorderRadius.circular(22)),
                  padding: EdgeInsets.only(left: 8,right: 8,top: 5,bottom: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 28,
                        width: 28,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          //Profile Image
                          child: Image.network(
                              fit: BoxFit.cover, checkValidString(listTask[index].userAssignTo!.profilePicFull).toString().isNotEmpty ? checkValidString(listTask[index].userAssignTo!.profilePicFull).toString() : 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                        ),
                      ),
                      Gap(5),
                      Text(toDisplayCase(checkValidString(listTask[index].userAssignTo!.name)), style: font16(assignText)),
                      Gap(5)
                    ],
                  ),
                ),
                Spacer()
              ],
            )
          ],
        ),
      ),
    );
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
            height: 200,
            child: LoopPageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    widget.currentIndex = value;
                    // print(currentIndex);
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(StaticData.img[index]);
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


