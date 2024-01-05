import 'dart:convert';
import 'package:believe_app/pages/task/task_detail_page.dart';
import 'package:believe_app/pages/task/update_task_page.dart';
import 'package:believe_app/widget/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../constant/global_context.dart';
import '../../constant/static_item.dart';
import '../../model/login/VerifyOtpResponseModel.dart';
import '../../model/task/DepartmentWiseUserResponse.dart';
import '../../model/task/FilterValueModel.dart';
import '../../model/task/TaskListResponseModel.dart';
import '../../model/task/TaskPriorityListResponse.dart';
import '../../model/task/TaskStatusListResponse.dart';
import '../../model/task/UserWiseTagListResponse.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../tabs/dashboard_menu.dart';
import 'add_task_page.dart';

class MyTaskListScreen extends StatefulWidget {

  bool isFromNotification = false;
  MyTaskListScreen({this.isFromNotification = false,Key? key}) : super(key: key);

  @override
  _MyTaskListScreenState createState() => _MyTaskListScreenState();
}

class _MyTaskListScreenState extends BaseState<MyTaskListScreen>
{
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  String searchText = "";
  List<FilterMenuGetSet> listStatus = List<FilterMenuGetSet>.empty(growable: true);
  List<TaskPriorityData> listPriority = List<TaskPriorityData>.empty(growable: true);
  List<FilterMenuGetSet> listPriorityFilter = List<FilterMenuGetSet>.empty(growable: true);
  List<TaskListData> listTask = List<TaskListData>.empty(growable: true);
  List<FilterMenuGetSet> listDepartmentWiseUserList = List<FilterMenuGetSet>.empty(growable: true);
  List<FilterMenuGetSet> listUserWiseTagList = List<FilterMenuGetSet>.empty(growable: true);

  final ScrollController _scrollViewController = ScrollController();

  //filter option value
  var statusID = "";
  var whereOption = "Status";
  var isOrNotOption = 'Is';
  var selectedPriorityId = "";
  var selectedAssigneesId = "";
  var selectedTagsId = "";
  var selectedDueDateFinal = "";

  var selectedFilterData = FilterMenuGetSet(idStatic: "",nameStatic: "All");
  bool isFromNotification = false;

  @override
  void initState() {
    isFromNotification = (widget as MyTaskListScreen).isFromNotification;
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

    return WillPopScope(
      onWillPop: () {
        if(isFromNotification)
        {
          NavigationService.notif_type = "";
          NavigationService.notif_content_id = "";
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>  DashboardWithMenuScreen()), (Route<dynamic> route) => false);
        }
        else {
          Navigator.pop(context);
        }
        return Future.value(true);
      },
      child: Scaffold(
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
                children: [appBar(), const Gap(12), searchViewWidget()],
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          taskStatusListWidget(),
                          Expanded(child: listTask.isNotEmpty ? taskListWidget() : const MyNoDataWidget(msg: "No task found!"))
                        ],
                      )),
          )),
    );
  }

  Row appBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if(isFromNotification)
            {
              NavigationService.notif_type = "";
              NavigationService.notif_content_id = "";
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>  DashboardWithMenuScreen()), (Route<dynamic> route) => false);
            }
            else {
              Navigator.pop(context);
            }
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
            "My Tasks",
            textAlign: TextAlign.start,
            style: titleFontNormal(white, 20),
          ),
        ),
        GestureDetector(
          onTap: () {
            if(checkValidString(checkRights("my_tasks").addRights) == "1")
            {

              _redirectToAdd(false,TaskListData());
            }
            else
            {
              showToast("You are not allowed to use this features", context);
            }
          },
          child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: blueDark),
              height: 42,
              width: 42,
              padding: const EdgeInsets.all(13),
              child: Image.asset('assets/images/ic_add.png', height: 28, width: 28)),
        ),
      ],
    );
  }

  Row searchViewWidget() {
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
            autofocus: false,
            onSubmitted: (value) {
              setState(() {
                searchText = value;
              });
              if(isOnline)
              {
                _getTaskListDataFromAPI();
              }
              else
              {
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
              fillColor: blueDark,
              contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 0),
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
                  ? GestureDetector(
                    onTap: (){
                      if(searchText.isNotEmpty)
                        {
                          setState(() {
                            searchText = "";
                            _searchController.text = "";
                          });

                          if(isOnline)
                          {
                            _getTaskListDataFromAPI();
                          }
                          else
                          {
                            noInterNet(context);
                          }
                        }
                      else
                        {
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
            hideKeyboard(context);
            filterTaskPopup();
          },
          child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: blueDark),
              height: 44,
              width: 44,
              padding: const EdgeInsets.all(12),
              child: Image.asset('assets/images/ic_filter.png', height: 28, width: 28)),
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
                            borderRadius: BorderRadius.circular(kButtonCornerRadius8), side: const BorderSide(color: blueNormal, width: 0.7)),
                      ),
                      backgroundColor:
                          listStatus[index].id.toString() == statusID ? MaterialStateProperty.all<Color>(blueNormal) : MaterialStateProperty.all<Color>(white)),
                  onPressed: () {
                    if (listStatus[index].id.toString() != statusID)
                    {
                      setState(() {
                        statusID = listStatus[index].id.toString();
                        whereOption = "Status";
                        selectedFilterData.id = statusID;
                        selectedFilterData.name = listStatus[index].name.toString();
                        isOrNotOption = 'Is';
                      });

                      if(isOnline)
                      {
                        _getTaskListDataFromAPI();
                      }
                      else
                        {
                          noInterNet(context);
                        }
                    }
                  },
                  child: Text(checkValidString(toDisplayCase(listStatus[index].name.toString().trim())),
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: listStatus[index].id.toString() == statusID ? white : blueNormal)),
                ),
              )),
    );
  }

  ListView taskListWidget() {
    return ListView.builder(
      controller: _scrollViewController,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemCount: listTask.length,
      itemBuilder: (ctx, index) => taskListItem(index),
    );
  }

  taskListItem(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if(checkValidString(checkRights("my_tasks").viewRights) == "1")
        {
          _redirectToAdd(true,listTask[index]);
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
        margin: const EdgeInsets.all(12),
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
                Image.asset('assets/images/ic_date.png', height: 16, width: 16),
                const Gap(4),
                Text(checkValidString(listTask[index].dueDateTime!.date).toString() + " " + checkValidString(listTask[index].dueDateTime!.time).toString(), style: font13(graySemiDark)),
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

  _getStatusDataFromAPI() async {
    setState(() {
      _isLoading = true;
    });
    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + taskStatusList);
      Map<String, String> jsonBody = {'call_app': CALL_APP, 'from_app': IS_FROM_APP,'logged_in_user_id' : sessionManager.getId().toString().trim()};

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
              var allObj = FilterMenuGetSet(idStatic: "",nameStatic: "All");
              listStatus.add(allObj);
              for (var n = 0; n < dataResponse.data!.length; n++) {
                dataResponse.data![n].selected = false;
                listStatus.add(FilterMenuGetSet(idStatic: checkValidString(dataResponse.data![n].id), nameStatic: checkValidString(dataResponse.data![n].name)));
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
      Map<String, String> jsonBody = {'call_app': CALL_APP, 'from_app': IS_FROM_APP,'logged_in_user_id' : sessionManager.getId().toString().trim()};

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
                listPriorityFilter.add(FilterMenuGetSet(idStatic: checkValidString(dataResponse.data![n].id), nameStatic: checkValidString(dataResponse.data![n].name)));
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
    _getDepartmentWiseUserListDataFromAPI();
  }

  _getDepartmentWiseUserListDataFromAPI() async {
    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + departmentWiseUserList);
      Map<String, String> jsonBody = {'call_app': CALL_APP, 'from_app': IS_FROM_APP, 'logged_in_user_id': sessionManager.getId().toString()};

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = DepartmentWiseUserResponse.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              for (var n = 0; n < dataResponse.data!.length; n++) {
                dataResponse.data![n].selected = false;
                listDepartmentWiseUserList.add(FilterMenuGetSet(idStatic: checkValidString(dataResponse.data![n].id), nameStatic: checkValidString(dataResponse.data![n].name)));
              }
              setState(() {});
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

    _getUserWiseTagListDataFromAPI();
  }

  _getUserWiseTagListDataFromAPI() async {
    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + userWiseTagList);
      Map<String, String> jsonBody = {'call_app': CALL_APP, 'from_app': IS_FROM_APP, 'logged_in_user_id': sessionManager.getId().toString()};

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = UserWiseTagListResponse.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              for (var n = 0; n < dataResponse.data!.length; n++) {
                dataResponse.data![n].selected = false;
                listUserWiseTagList.add(FilterMenuGetSet(idStatic: checkValidString(dataResponse.data![n].id), nameStatic: checkValidString(dataResponse.data![n].name)));
              }
              setState(() {});
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

    if(isOnline)
      {
        _getTaskListDataFromAPI();
      }

  }

  _getTaskListDataFromAPI() async {
    if (isOnline) {
      setState(() {
        _isLoading = true;
      });
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + taskList);
      Map<String, String> jsonBody = {
        'logged_in_user_id': sessionManager.getId().toString(),
        'from_app': IS_FROM_APP,
        'search' : searchText,
        'status_ids' : statusID,
        'status_is_or_not' : (whereOption == "Status" && isOrNotOption == "Is") ? "1" : "0",
        'priority_ids' : (whereOption == "Priority" && checkValidString(selectedFilterData.id).toString().isNotEmpty) ? checkValidString(selectedFilterData.id).toString().trim() : "",
        'priority_is_or_not' : (whereOption == "Priority" && isOrNotOption == "Is") ? "1" : "0",
        'assignee_ids' : (whereOption == "Assignee" && checkValidString(selectedFilterData.id).toString().isNotEmpty) ? checkValidString(selectedFilterData.id).toString().trim() : "",
        'assignee_is_or_not' : (whereOption == "Assignee" && isOrNotOption == "Is") ? "1" : "0",
        'tag_ids' : (whereOption == "Tags" && checkValidString(selectedFilterData.id).toString().isNotEmpty) ? checkValidString(selectedFilterData.id).toString().trim() : "",
        'tag_is_or_not' :(whereOption == "Tags" && isOrNotOption == "Is") ? "1" : "0",
        'due_date' : (whereOption == "Due Date" && selectedDueDateFinal.toString().isNotEmpty) ? getTimeStampDate(selectedDueDateFinal.trim(), "dd MMM, yyyy").toString() : "",
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
      _isLoading = false;
    });
  }

  Future<void> _redirectToAdd(bool isFrom, TaskListData taskListData) async {
    hideKeyboard(context);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => isFrom ? TaskDetailPage(taskListData,listPriority) : AddTaskScreen(listPriority)),
    );
    print("result ===== $result");
    if (result == "success") {
      setState(() {});
      _getTaskListDataFromAPI();
    }
  }

  final TextEditingController _whereController = TextEditingController();
  final TextEditingController _isController = TextEditingController();
  final TextEditingController _selectOptionController = TextEditingController();

  Future<dynamic> filterTaskPopup() {
    _whereController.text = whereOption;
    _isController.text = isOrNotOption;
    _selectOptionController.text = checkValidString(selectedFilterData.name);
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Wrap(
                  children: [
                    Center(
                      child: Container(
                        height: 6,
                        width: 60,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 12,bottom: 12),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: grayLight, width: 1.0))),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        hideKeyboard(context);
                                        Navigator.pop(context);
                                      },
                                      child: Padding(padding: const EdgeInsets.all(8), child: Image.asset('assets/images/ic_close.png', height: 16, width: 16, color: black)),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Filter",
                                        textAlign: TextAlign.center,
                                        style: font20(blueNormal),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        Navigator.pop(context);
                                        setState(() {
                                          statusID = "";
                                          whereOption = "Status";
                                          selectedFilterData.id = "";
                                          selectedFilterData.name = "All";
                                          isOrNotOption = 'Is';
                                        });
                                        if(isOnline)
                                        {
                                          _getTaskListDataFromAPI();
                                        }
                                        else
                                        {
                                          showToast("Please check your internet connection!", context);
                                        }
                                      },
                                      child: const Text(
                                        "Clear",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20, fontFamily: otherFont, color: black, fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(left: 20,right: 20,top: 12,bottom: 12),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               const Gap(10),
                               Text(
                                 "Where",
                                 textAlign: TextAlign.start,
                                 style: font18SemiBold(black),
                               ),
                               const Gap(16),
                               TextField(
                                 cursorColor: editTextColor,
                                 controller: _whereController,
                                 keyboardType: TextInputType.text,
                                 style: editTextStyleAll(),
                                 readOnly: true,
                                 onTap: () {
                                   filterWhereOption(StaticItemList.whereOptionTask, 'Where',whereOption,_whereController);
                                 },
                                 decoration: InputDecoration(
                                   suffixIcon: Padding(
                                     padding: const EdgeInsets.all(16),
                                     child: Image.asset(
                                       'assets/images/ic_down_arrow.png',
                                       height: 12,
                                       width: 12,
                                       color: editTextColor,
                                     ),
                                   ),
                                   fillColor: white,
                                   contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
                                   border: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: editTextBorder)),
                                   focusedBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: editTextBorder)),
                                   errorBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                                   focusedErrorBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                                   enabledBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: editTextBorder)),
                                   labelStyle: const TextStyle(
                                     color: editTextColor,
                                     fontSize: 16,
                                     fontFamily: otherFont,
                                     fontWeight: FontWeight.w500,
                                   ),
                                   hintStyle: const TextStyle(color: editTextColor, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
                                 ),
                               ),
                               const Gap(16),
                               Text(
                                 "Is",
                                 textAlign: TextAlign.start,
                                 style: font18SemiBold(black),
                               ),
                               const Gap(16),
                               TextField(
                                 cursorColor: editTextColor,
                                 controller: _isController,
                                 keyboardType: TextInputType.text,
                                 style: editTextStyleAll(),
                                 readOnly: true,
                                 onTap: () {
                                   filterWhereOption(StaticItemList.isOrNot, 'Is',isOrNotOption,_isController);
                                 },
                                 decoration: InputDecoration(
                                   suffixIcon: Padding(
                                     padding: const EdgeInsets.all(16),
                                     child: Image.asset(
                                       'assets/images/ic_down_arrow.png',
                                       height: 12,
                                       width: 12,
                                       color: editTextColor,
                                     ),
                                   ),
                                   fillColor: white,
                                   contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
                                   border: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: editTextBorder)),
                                   focusedBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: editTextBorder)),
                                   errorBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                                   focusedErrorBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                                   enabledBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: editTextBorder)),
                                   labelStyle: const TextStyle(
                                     color: editTextColor,
                                     fontSize: 16,
                                     fontFamily: otherFont,
                                     fontWeight: FontWeight.w500,
                                   ),
                                   hintStyle: const TextStyle(color: editTextColor, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
                                 ),
                               ),
                               const Gap(16),
                               Text(
                                 "Select Option",
                                 textAlign: TextAlign.start,
                                 style: font18SemiBold(black),
                               ),
                               const Gap(16),
                               TextField(
                                 cursorColor: editTextColor,
                                 controller: _selectOptionController,
                                 keyboardType: TextInputType.text,
                                 style: editTextStyleAll(),
                                 readOnly: true,
                                 onTap: () {
                                   if(whereOption.isNotEmpty)
                                   {
                                       if(whereOption == "Status")
                                       {
                                         filterSelectOption(listStatus, 'Select Status',_selectOptionController);
                                       }
                                      else if(whereOption == "Priority")
                                       {
                                         filterSelectOption(listPriorityFilter, 'Select Priority',_selectOptionController);
                                       }
                                       else if(whereOption == "Assignee")
                                       {
                                         filterSelectOption(listDepartmentWiseUserList, 'Select Assignee',_selectOptionController);
                                       }
                                       else if(whereOption == "Tags")
                                       {
                                         filterSelectOption(listUserWiseTagList, 'Select Tags',_selectOptionController);
                                       }
                                       else
                                       {
                                         _showDatePicker(_selectOptionController);
                                       }
                                   }
                                   else
                                   {
                                       showToast("Please select where first.", context);
                                   }
                                 },
                                 decoration: InputDecoration(
                                   suffixIcon: Padding(
                                     padding: const EdgeInsets.all(16),
                                     child: Image.asset(
                                       'assets/images/ic_down_arrow.png',
                                       height: 12,
                                       width: 12,
                                       color: editTextColor,
                                     ),
                                   ),
                                   fillColor: white,
                                   contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
                                   border: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: editTextBorder)),
                                   focusedBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: editTextBorder)),
                                   errorBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                                   focusedErrorBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                                   enabledBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                       borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: editTextBorder)),
                                   labelStyle: const TextStyle(
                                     color: editTextColor,
                                     fontSize: 16,
                                     fontFamily: otherFont,
                                     fontWeight: FontWeight.w500,
                                   ),
                                   hintStyle: const TextStyle(color: editTextColor, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
                                 ),
                               ),
                               Container(
                                 margin: const EdgeInsets.only(left: 10, right: 10,top: 22,bottom: 22),
                                 width: MediaQuery.of(context).size.width,
                                 child: TextButton(
                                     style: ButtonStyle(
                                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                           RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                           ),
                                         ),
                                         backgroundColor: MaterialStateProperty.all<Color>(blueNormal)),
                                     onPressed: () async {
                                       FocusScope.of(context).requestFocus(FocusNode());
                                       if(whereOption.isEmpty)
                                       {
                                         showToast("Please select where", context);
                                       }
                                       else if(isOrNotOption.isEmpty)
                                       {
                                         showToast("Please select IS", context);
                                       }
                                       else
                                       {
                                         hideKeyboard(context);
                                         Navigator.pop(context);
                                         if(isOnline)
                                         {
                                           _getTaskListDataFromAPI();
                                         }
                                         else
                                         {
                                           showToast("Please check your internet connection!", context);
                                         }
                                       }
                                     },
                                     child: const Padding(
                                       padding: EdgeInsets.only(top: 8, bottom: 8),
                                       child: Text(
                                         "Apply",
                                         textAlign: TextAlign.center,
                                         style: TextStyle(fontSize: 16, fontFamily: otherFont, color: white, fontWeight: FontWeight.w600),
                                       ),
                                     )),
                               ),
                             ],
                           ),)
                        ],
                      ),
                    )
                  ],
                );
              });
        });
      },
    );
  }

  Future<dynamic> filterWhereOption(List options, String type,String selectedValue,TextEditingController textController) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          return StatefulBuilder (
              builder: (BuildContext context, StateSetter setState) {
                return Wrap(
                  children: [
                    Center(
                      child: Container(
                        height: 6,
                        width: 60,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 12,bottom: 12),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: grayLight, width: 1.0))),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(padding: const EdgeInsets.all(8), child: Image.asset('assets/images/ic_close.png', height: 16, width: 16, color: black)),
                                    ),
                                    Expanded(
                                      child: Text(
                                        type,
                                        textAlign: TextAlign.center,
                                        style: font20(blueNormal),
                                      ),
                                    ),
                                    /*GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          textController.text = selectedValue;
                                          if(type == "Where")
                                          {
                                            if(whereOption.isEmpty)
                                            {
                                                whereOption = selectedValue;
                                                selectedFilterData.id = "";
                                                selectedFilterData.name = "";
                                            }
                                            else
                                            {
                                              if(whereOption == selectedValue)
                                                {
                                                  whereOption = selectedValue;
                                                }
                                              else
                                                {
                                                  whereOption = selectedValue;
                                                  selectedFilterData.id = "";
                                                  selectedFilterData.name = "";
                                                }
                                            }
                                            _selectOptionController.text = "";
                                          }
                                          else
                                          {
                                              isOrNotOption = selectedValue;
                                          }
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Apply",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20, fontFamily: otherFont, color: blueNormal, fontWeight: FontWeight.w400),
                                      ),
                                    ),*/
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 28, bottom: 28),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                String data = options[index];
                                return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      selectedValue = data;
                                      textController.text = selectedValue;
                                      if(type == "Where")
                                      {
                                        if(whereOption.isEmpty)
                                        {
                                          whereOption = selectedValue;
                                          selectedFilterData.id = "";
                                          selectedFilterData.name = "";
                                          _selectOptionController.text = "";
                                          isOrNotOption = 'Is';
                                          _isController.text = isOrNotOption;
                                        }
                                        else
                                        {
                                          if(whereOption == selectedValue)
                                          {
                                            whereOption = selectedValue;
                                          }
                                          else
                                          {
                                            whereOption = selectedValue;
                                            selectedFilterData.id = "";
                                            selectedFilterData.name = "";
                                            _selectOptionController.text = "";
                                            isOrNotOption = 'Is';
                                            _isController.text = isOrNotOption;
                                          }
                                        }
                                      }
                                      else
                                      {
                                        isOrNotOption = selectedValue;
                                      }
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    color: white,
                                    padding: const EdgeInsets.only(top: 12,bottom: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data,
                                          style: TextStyle(
                                              color: selectedValue == data
                                                  ? blueNormal
                                                  : editTextColor,
                                              fontSize: 18),
                                        ),
                                        selectedValue == data
                                            ? Icon(Icons.circle,
                                            size: 10,
                                            color: blueNormal)
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                              const SizedBox(height: 1),
                              itemCount: options.length)
                        ],
                      ),
                    )
                  ],
                );
              });
        });
      },
    );
  }

  Future<dynamic> filterSelectOption(List<FilterMenuGetSet> options, String type,TextEditingController textController) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Wrap(
                  children: [
                    Center(
                      child: Container(
                        height: 6,
                        width: 60,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 12,bottom: 12),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: grayLight, width: 1.0))),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Padding(padding: const EdgeInsets.all(8), child: Image.asset('assets/images/ic_close.png', height: 16, width: 16, color: black)),
                                    ),
                                    Expanded(
                                      child: Text(
                                        type,
                                        textAlign: TextAlign.center,
                                        style: font20(blueNormal),
                                      ),
                                    ),
                                    /*GestureDetector(
                                      onTap: () {
                                        setState(() {

                                        });

                                      },
                                      child: const Text(
                                        "Apply",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20, fontFamily: otherFont, color: blueNormal, fontWeight: FontWeight.w400),
                                      ),
                                    ),*/
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 28, bottom: 28),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {

                                      if(whereOption == "Status")
                                      {
                                        statusID = checkValidString(options[index].id.toString());
                                      }
                                      else
                                      {
                                        statusID = "";
                                      }

                                      selectedFilterData.id = checkValidString(options[index].id.toString());
                                      selectedFilterData.name = checkValidString(options[index].name.toString());
                                      textController.text = toDisplayCase(selectedFilterData.name);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    color: white,
                                    padding: const EdgeInsets.only(top: 12,bottom: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          toDisplayCase(checkValidString(options[index].name.toString())),
                                          style: TextStyle(
                                              color: selectedFilterData.id == options[index].id.toString()
                                                  ? blueNormal
                                                  : editTextColor,
                                              fontSize: 18),
                                        ),
                                        selectedFilterData.id == options[index].id.toString()
                                            ? const Icon(Icons.circle,
                                            size: 10,
                                            color: blueNormal)
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                              const SizedBox(height: 1),
                              itemCount: options.length)
                        ],
                      ),
                    )
                  ],
                );
              });
        });
      },
    );
  }

  Future<void> _showDatePicker(TextEditingController textController) async {

    DateTime? result = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5, DateTime.now().month, DateTime.now().day),
        // the earliest allowable
        lastDate: DateTime(DateTime.now().year + 5, DateTime.now().month, DateTime.now().day),
        // the latest allowable
        currentDate: DateTime.now(),
        builder: (context, Widget? child) => Theme(
          data: Theme.of(context).copyWith(
              appBarTheme: Theme.of(context)
                  .appBarTheme
                  .copyWith(backgroundColor: button_bg, iconTheme: Theme.of(context).appBarTheme.iconTheme?.copyWith(color: white)),
              scaffoldBackgroundColor: white,
              colorScheme: const ColorScheme.light(onPrimary: white, primary: button_bg)),
          child: child!,
        ),
        initialDate: textController.text.toString().trim().isNotEmpty
            ? DateFormat('dd MMM, yyyy').parse(textController.text.toString().trim())
            : DateTime.now());

    if (result != null) {
      String startDateFormat = DateFormat('dd MMM, yyyy').format(result);
      print("<><> SHOW DATE ::: $startDateFormat <><>");
      if (startDateFormat.isNotEmpty) {
        setState(() {
          textController.text = startDateFormat;
          selectedDueDateFinal = startDateFormat;
        });
        print("<><> SHOW DATETIME ::: $startDateFormat<><>");
      }
    }
  }

  @override
  void castStatefulWidget() {
    widget is MyTaskListScreen;
  }


}
