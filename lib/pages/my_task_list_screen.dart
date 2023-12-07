import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../model/TaskPriorityListResponse.dart';
import '../model/TaskStatusListResponse.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../widget/app_bar.dart';
import '../widget/loading.dart';

class MyTaskListScreen extends StatefulWidget {
  const MyTaskListScreen({Key? key}) : super(key: key);

  @override
  _MyTaskListScreenState createState() => _MyTaskListScreenState();
}

class _MyTaskListScreenState extends BaseState<MyTaskListScreen> {
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  String searchText = "";
  List<TaskStatusData> listStatus = List<TaskStatusData>.empty(growable: true);
  List<TaskPriorityData> listPriority = List<TaskPriorityData>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _getStatusDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: blueNormal,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
        backgroundColor: blueNormal,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            toolbarHeight: 110,
            automaticallyImplyLeading: false,
            backgroundColor: blueNormal,
            elevation: 0,
            titleSpacing: 12,
            centerTitle: false,
            title: Column(
              children: [const AppBarWidget(pageName: "My Tasks"), const Gap(12), searchViewWidget()],
            )),
        body: Padding(
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
                      children: [
                        taskStatusListWidget()
                      ],
                    )),
        ));
  }

  Row searchViewWidget() {
    return Row(
      children: [
        Expanded(
            child: TextField(
          cursorColor: white,
          controller: _searchController,
          keyboardType: TextInputType.text,
          style: editTextStyleWhite(),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          decoration: InputDecoration(
            fillColor: blueDark,
            contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: blueDark)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: blueDark)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kButtonCornerRadius12), borderSide: const BorderSide(width: 0.5, color: blueDark)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kButtonCornerRadius12), borderSide: const BorderSide(width: 0.5, color: blueDark)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: blueDark)),
            hintText: 'Search the task...',
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
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      'assets/images/ic_close.png',
                      height: 12,
                      width: 12,
                      color: white,
                    ),
                  )
                : null,
            hintStyle: const TextStyle(color: white, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
          ),
        )),
        const Gap(12),
        GestureDetector(
          onTap: () {
            // Navigator.pop(context);
          },
          child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: blueDark),
              height: 48,
              width: 48,
              padding: const EdgeInsets.all(13),
              child: Image.asset('assets/images/ic_filter.png', height: 24, width: 24)),
        ),
      ],
    );
  }

  Container taskStatusListWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 15),
      height: 40,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          itemCount: listStatus.length,
          itemBuilder: (ctx, index) => Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            height: 40,
            child: TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius8),
                        side: const BorderSide(color: blueNormal, width: 0.7)),
                  ),
                  backgroundColor: listStatus[index].selected!
                      ? MaterialStateProperty.all<Color>(blueNormal)
                      : MaterialStateProperty.all<Color>(white)),
              onPressed: () {
                if (listStatus[index].selected! == false) {
                  setState(() {
                    for (var n = 0; n < listStatus.length; n++) {
                      if (n == index) {
                        listStatus[n].selected = true;
                      } else {
                        listStatus[n].selected = false;
                      }
                    }
                  });
                }
              },
              child: Text(checkValidString(toDisplayCase(listStatus[index].name.toString().trim())),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: listStatus[index].selected! ? white : blueNormal)),
            ),
          )),
    );
  }

  _getStatusDataFromAPI() async {
    setState(() {
      _isLoading = true;
    });
    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + taskStatusList);
      Map<String, String> jsonBody = {'call_app': CALL_APP, 'from_app': IS_FROM_APP};

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = TaskStatusListResponse.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              var allObj = TaskStatusData(id: "", name: "All", color: "", sort: "", createdAt: "", selected: true);
              listStatus.add(allObj);
              for (var n = 0; n < dataResponse.data!.length; n++) {
                dataResponse.data![n].selected = false;
                listStatus.add(dataResponse.data![n]);
              }
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

    _getPriorityDataFromAPI();
  }

  _getPriorityDataFromAPI() async {
    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + taskPriorityList);
      Map<String, String> jsonBody = {'call_app': CALL_APP, 'from_app': IS_FROM_APP};

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = TaskPriorityListResponse.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
             // var allObj = TaskPriorityData(id: "", name: "All", color: "", sort: "", createdAt: "", selected: true);
              //listPriority.add(allObj);
              for (var n = 0; n < dataResponse.data!.length; n++) {
                dataResponse.data![n].selected = false;
                listPriority.add(dataResponse.data![n]);
              }
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

  @override
  void castStatefulWidget() {
    widget is MyTaskListScreen;
  }

}
