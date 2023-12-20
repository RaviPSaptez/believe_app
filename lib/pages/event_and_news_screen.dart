import 'dart:convert';
import 'package:believe_app/widget/loading.dart';
import 'package:believe_app/widget/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../data/model/event_news_model.dart';
import '../data/model/event_type_model.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import 'add_event.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends BaseState<EventScreen> {
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  String searchText = "";
  List<EventType> types = [];
  String selectedLabel = '0';
  String isRSVP = 'Yes';
  List<EventNewsListItem> listEventOrNews = List<EventNewsListItem>.empty(growable: true);
  Map<String, String> isRSVPClick = {};

  void onRSVPClick(String id, String interest) {
    setState(() {
      isRSVPClick[id] = interest;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: themePink,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: themePink,
      appBar: AppBar(
          toolbarHeight: 110,
          automaticallyImplyLeading: false,
          backgroundColor: themePink,
          elevation: 0,
          titleSpacing: 12,
          centerTitle: false,
          title: Column(
            children: [appBar(context), const Gap(12), searchBar()],
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Container(
              decoration:
                  const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 20),
              child: _isLoading
                  ? const LoadingWidget()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        typeList(),
                        Expanded(child: listEventOrNews.isNotEmpty ? listOfEvents() : const MyNoDataWidget(msg: "No task found!"))
                      ],
                    )),
        ),
      ),
    );
  }

  @override
  void initState() {
    types = [EventType(name: 'All', id: 0), EventType(name: 'Event', id: 1), EventType(name: 'News', id: 2)];
    _getListDataFromAPI();
    super.initState();
  }



  Widget appBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: Color(0xffB50055)),
              height: 42,
              width: 42,
              padding: const EdgeInsets.all(13),
              child: Image.asset('assets/images/ic_back_arrow.png', height: 28, width: 28)),
        ),
        const Gap(12),
        Expanded(
          child: Text(
            "News & Events",
            textAlign: TextAlign.start,
            style: titleFontNormal(white, 20),
          ),
        ),
      ],
    );
  }

  Widget searchBar() {
    return Row(
      children: [
        Expanded(
            child: SizedBox(
          height: 44,
          child: TextField(
            cursorColor: white,
            controller: _searchController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              setState(() {
                searchText = value;
              });
              if (isOnline) {
                _getListDataFromAPI();
              } else {
                noInterNet(context);
              }
            },
            style: editTextStyleWhite(),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              fillColor: const Color(0xffB50055),
              contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                  borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: Color(0xffB50055))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                  borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: Color(0xffB50055))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kButtonCornerRadius12), borderSide: const BorderSide(width: 0.5, color: Color(0xffB50055))),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kButtonCornerRadius12), borderSide: const BorderSide(width: 0.5, color: Color(0xffB50055))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                  borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: Color(0xffB50055))),
              hintText: 'Search Event,News...',
              labelStyle: const TextStyle(
                color: white,
                fontSize: 16,
                fontFamily: otherFont,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(13),
                child: Image.asset(
                  'assets/images/ic_search.png',
                  height: 12,
                  width: 12,
                  color: white,
                ),
              ),
              suffixIcon: searchText.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        if (searchText.isNotEmpty) {
                          setState(() {
                            searchText = "";
                            _searchController.text = "";
                          });

                          if (isOnline) {
                            _getListDataFromAPI();
                          } else {
                            noInterNet(context);
                          }
                        } else {
                          setState(() {
                            searchText = "";
                            _searchController.text = "";
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          'assets/images/ic_close.png',
                          height: 12,
                          width: 12,
                          color: white,
                        ),
                      ),
                    )
                  : null,
              hintStyle: const TextStyle(color: white, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
            ),
          ),
        )),
        const Gap(12),
        GestureDetector(
          onTap: () {
            _redirectToAdd(false,EventNewsListItem());
          },
          child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: Color(0xffB50055)),
              height: 42,
              width: 42,
              padding: const EdgeInsets.all(13),
              child: Image.asset('assets/images/ic_add.png', height: 28, width: 28)),
        ),
      ],
    );
  }

  Widget listOfEvents() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          String id = listEventOrNews[index].id!;
          String rsvp = isRSVPClick[id] ?? 'No';
          return GestureDetector(
            onTap: (){
              _redirectToAdd(true,listEventOrNews[index]);
            },
            child: Container(
              decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(12), border: Border.all(color: editTextBorder, width: 0.5)),
              margin: const EdgeInsets.all(12),
              child: Wrap(
                children: [
                  Visibility(
                    visible: checkValidString(listEventOrNews[index].attachmentFull).toString().isNotEmpty,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                        child: Image.network("${listEventOrNews[index].attachmentFull!}&w=600",
                            height: 200, width: MediaQuery.of(context).size.width, fit: BoxFit.cover)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(toDisplayCase(checkValidString(listEventOrNews[index].title)),
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                                  Container(
                                    padding: const EdgeInsets.only(right: 6.5, left: 6.5, top: 1.5, bottom: 2),
                                    decoration: const BoxDecoration(color: Color(0xffFFD9EB), borderRadius: BorderRadius.all(Radius.circular(6))),
                                    child: Center(
                                        child: Text(listEventOrNews[index].campaignType == '1' ? 'Event' : 'News',
                                            style: const TextStyle(color: themePink, fontSize: 12, fontWeight: FontWeight.w600))),
                                  )
                                ],
                              ),
                              Gap(6),
                              Text(toDisplayCase(checkValidString(listEventOrNews[index].description!)),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(fontSize: 12, color: Color(0xff666666))),
                              Gap(6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Row for Date and Time and campaign_type
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/svgs/date.svg', height: 15, width: 15),
                                      const SizedBox(width: 6),
                                      Text(listEventOrNews[index].createdAtDateTime!.date.toString(),
                                          style: const TextStyle(color: Color(0xff666666), fontSize: 12)),
                                      // const SizedBox(width: 5),
                                      const SizedBox(height: 10, child: VerticalDivider(thickness: 1, color: Color(0xff666666))),
                                      Text(listEventOrNews[index].createdAtDateTime!.time.toString(),
                                          style: const TextStyle(color: Color(0xff666666), fontSize: 12)),
                                    ],
                                  ),
                                  // campaign_type label
                                ],
                              ),
                            ],
                          )),
                      Visibility(
                          visible: listEventOrNews[index].campaignType == '1',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Divider(color: grayLight, height: 0.5),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Are you joining? Please RSVP', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 81,
                                      height: 26,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                onRSVPClick(id, 'Yes');
                                              });
                                            },
                                            child: Container(
                                              width: 38,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                  color: rsvp == 'Yes' ? themePink : const Color(0xffFFD9EB)),
                                              child: Center(
                                                  child: Text('Yes', style: TextStyle(fontSize: 12, color: rsvp == "Yes" ? Colors.white : themePink))),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                onRSVPClick(id, 'No');
                                              });
                                            },
                                            child: Container(
                                              width: 38,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                  color: rsvp == 'No' ? themePink : const Color(0xffFFD9EB)),
                                              child: Center(
                                                  child: Text('No', style: TextStyle(fontSize: 12, color: rsvp == "No" ? Colors.white : themePink))),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: listEventOrNews.length);
  }

  Widget typeList() {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 15),
      height: 40,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String label = types[index].id!.toString();
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedLabel = label;
                });
                _getListDataFromAPI();
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: themePink),
                    borderRadius: BorderRadius.circular(12),
                    color: label == selectedLabel ? themePink : Colors.white),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        // top: 12,
                        // bottom: 12,
                        left: 22,
                        right: 22),
                    child: Text(types[index].name.toString(), style: TextStyle(color: label == selectedLabel ? Colors.white : themePink)),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 5),
          itemCount: types.length),
    );
  }

  _getListDataFromAPI() async {
    if (isOnline) {
      setState(() {
        _isLoading = true;
      });
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + eventNewsList);
      Map<String, String> jsonBody = {
        'logged_in_user_id': sessionManager.getId().toString(),
        'call_app': CALL_APP,
        'from_app': IS_FROM_APP,
        'search': searchText,
        'campaign_type': selectedLabel == "0" ? "" : selectedLabel
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      listEventOrNews = [];
      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = EventNewsModel.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              listEventOrNews = dataResponse.data!;
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
      _isLoading = false;
    });
  }

  Future<void> _redirectToAdd(bool isFrom, EventNewsListItem listItem) async {
    if(checkValidString(checkRights("events").addRights) == "1")
    {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddEventScreen(isFrom,listItem)),
      );
      print("result ===== $result");
      if (result == "success") {
        setState(() {});
        _getListDataFromAPI();
      }
    }
    else
    {
      showToast("You are not allowed to use this features", context);
    }
  }

  @override
  void castStatefulWidget() {
    // TODO: implement castStatefulWidget
  }
}
