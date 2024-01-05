import 'dart:convert';
import 'package:believe_app/model/task/TaskListResponseModel.dart';
import 'package:believe_app/pages/task/update_task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../model/other/BasicResponseModel.dart';
import '../../model/task/DepartmentWiseUserResponse.dart';
import '../../model/task/SubTaskResponseModel.dart';
import '../../model/task/TaskPriorityListResponse.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../utils/session_manager.dart';

class TaskDetailPage extends StatefulWidget {
  TaskListData taskListData;
  List<TaskPriorityData> listPriority = List<TaskPriorityData>.empty(growable: true);

  TaskDetailPage(this.taskListData, this.listPriority, {Key? key}) : super(key: key);

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends BaseState<TaskDetailPage> {
  bool _isLoading = false;
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _taskDueDateController = TextEditingController();
  final TextEditingController _taskDueTimeController = TextEditingController();
  final TextEditingController _subDescriptionController = TextEditingController();

  //for update task
  var taskListData = TaskListData();

  // for priority
  List<TaskPriorityData> listPriority = List<TaskPriorityData>.empty(growable: true);
  var selectedPriorityId = "";

  //for add assignees
  List<DepartmentWiseUserList> listDepartmentWiseUserList = List<DepartmentWiseUserList>.empty(growable: true);
  List<DepartmentWiseUserList> listDepartmentWiseUserListSelected = List<DepartmentWiseUserList>.empty(growable: true);
  var selectedAssigneesId = "";

  //for subtask
  List<SubTaskData> listSubTask = List<SubTaskData>.empty(growable: true);
  var assignUserDetailsForSubTask = DepartmentWiseUserList();

  //for tags
  List<String> listTags = List<String>.empty(growable: true);
  var selectedTags = "";

  //for pass date in api
  var selectedDateFinal = "";

  var isSelectedAssignees = true;

  String isReloadList = "";

  @override
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    taskListData = (widget as TaskDetailPage).taskListData;
    listPriority = (widget as TaskDetailPage).listPriority;
    setUpdata();
    if (listPriority.isEmpty) {
      _getPriorityDataFromAPI();
    }
    _getDepartmentWiseUserListDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: blueDark,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, isReloadList);
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: blueNormal,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
              toolbarHeight: 140,
              automaticallyImplyLeading: false,
              backgroundColor: blueNormal,
              elevation: 0,
              titleSpacing: 12,
              centerTitle: false,
              title: Column(
                children: [
                  appBar(),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20, left: 6, right: 6),
                    child: Row(
                      children: [
                        Expanded(
                            child: SizedBox(
                                height: 42,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(width: 0.5, color: white),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(blueNormal)),
                                  onPressed: () {},
                                  child: const Text("Task Details", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: white)),
                                ))),
                        const Gap(15),
                        Expanded(
                            child: SizedBox(
                                height: 42,
                                child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(width: 0.5, color: blueDark),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(blueDark)),
                                  onPressed: () {},
                                  child: const Text("Comments", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: white)),
                                ))),
                      ],
                    ),
                  )
                ],
              )),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Container(
              decoration:
                  const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), color: white),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              toDisplayCase(checkValidString(taskListData.title)),
                              textAlign: TextAlign.start,
                              style: font20(black),
                            ),
                            const Gap(16),
                            Text(
                              toDisplayCase(checkValidString(taskListData.description)),
                              textAlign: TextAlign.start,
                              style: font15(black),
                            ),
                            const Gap(30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/ic_due_date.png', height: 22, width: 22),
                                const Gap(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Due Date",
                                      textAlign: TextAlign.start,
                                      style: font15(editTextBorder),
                                    ),
                                    Text(
                                      toDisplayCase(checkValidString(taskListData.dueDateTime!.date.toString())) +
                                          " " +
                                          toDisplayCase(checkValidString(taskListData.dueDateTime!.time.toString())),
                                      textAlign: TextAlign.start,
                                      style: font16SemiBold(black),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Gap(30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/ic_priority.png', height: 22, width: 22),
                                const Gap(10),
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "Priority",
                                      textAlign: TextAlign.start,
                                      style: font15(editTextBorder),
                                    )),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: white,
                                              borderRadius: BorderRadius.circular(28),
                                              border: Border.all(
                                                  color: Color(int.parse(taskListData.priority!.color.toString().replaceAll('#', '0xff'))),
                                                  width: 1)),
                                          padding: EdgeInsets.only(left: 10, right: 8, top: 6, bottom: 6),
                                          child: Row(
                                            children: [
                                              Text(checkValidString(taskListData.priority!.name).toString().toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Color(int.parse(taskListData.priority!.color.toString().replaceAll('#', '0xff'))))),
                                              Gap(6),
                                              Image.asset('assets/images/ic_down_arrow.png',
                                                  height: 12,
                                                  width: 12,
                                                  color: Color(int.parse(taskListData.priority!.color.toString().replaceAll('#', '0xff')))),
                                            ],
                                          ),
                                        ),
                                        Expanded(child: Container())
                                      ],
                                    ))
                                  ],
                                ))
                              ],
                            ),
                            const Gap(30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/ic_status_details.png', height: 22, width: 22),
                                const Gap(10),
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "Status",
                                      textAlign: TextAlign.start,
                                      style: font15(editTextBorder),
                                    )),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: white,
                                              borderRadius: BorderRadius.circular(28),
                                              border: Border.all(
                                                  color: Color(int.parse(taskListData.status!.color.toString().replaceAll('#', '0xff'))), width: 1)),
                                          padding: EdgeInsets.only(left: 10, right: 8, top: 6, bottom: 6),
                                          child: Row(
                                            children: [
                                              Text(checkValidString(taskListData.status!.name).toString().toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Color(int.parse(taskListData.status!.color.toString().replaceAll('#', '0xff'))))),
                                              Gap(6),
                                              Image.asset('assets/images/ic_down_arrow.png',
                                                  height: 12,
                                                  width: 12,
                                                  color: Color(int.parse(taskListData.status!.color.toString().replaceAll('#', '0xff')))),
                                            ],
                                          ),
                                        ),
                                        Expanded(child: Container())
                                      ],
                                    ))
                                  ],
                                ))
                              ],
                            ),
                            const Gap(30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/ic_assignees.png', height: 22, width: 22),
                                const Gap(10),
                                Expanded(
                                    child: Text(
                                  "Assignees",
                                  textAlign: TextAlign.start,
                                  style: font15(editTextBorder),
                                )),
                              ],
                            ),
                            Visibility(
                                visible: listDepartmentWiseUserListSelected.isNotEmpty,
                                child: Column(
                                  children: [const Gap(22), selectedUserList()],
                                )),
                            Visibility(
                                visible: checkValidString(taskListData.subDescription).toString().isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Gap(20),
                                    Text(
                                      "Sub Description",
                                      textAlign: TextAlign.start,
                                      style: font18SemiBold(black),
                                    ),
                                    const Gap(16),
                                    Text(
                                      toDisplayCase(checkValidString(taskListData.subDescription)),
                                      textAlign: TextAlign.start,
                                      style: font15(black),
                                    ),
                                  ],
                                )),
                            Visibility(
                              visible: listTags.isNotEmpty,
                              child: Column(
                                children: [
                                  const Gap(20),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "Tags",
                                        textAlign: TextAlign.start,
                                        style: font18SemiBold(black),
                                      )),
                                    ],
                                  ),
                                  const Gap(16),
                                  Visibility(visible: listTags.isNotEmpty, child: taskTagsListWidget()),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20, top: 12),
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                side: const BorderSide(width: 0.5, color: blueNormal),
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(blueNormal)),
                        onPressed: () {},
                        child: const Text("Mark as Completed", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: white)),
                      )),
                ],
              ),
            ),
          )),
    );
  }

  Row appBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context, isReloadList);
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
            "Task Details",
            textAlign: TextAlign.start,
            style: titleFontNormal(white, 20),
          ),
        ),
        GestureDetector(
          onTap: () async {
            if (checkValidString(checkRights("my_tasks").addRights) == "1") {
              hideKeyboard(context);
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateTaskScreen(taskListData, listPriority)),
              );
              print("result ===== $result");
              if (result == "success") {
                setState(() {
                  isReloadList = "success";
                });
                _getTaskDetailsDataFromAPI();
              }
            } else {
              showToast("You are not allowed to use this features", context);
            }
          },
          child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: blueDark),
              height: 42,
              width: 42,
              padding: const EdgeInsets.all(13),
              child: Image.asset('assets/images/ic_edit.png', height: 28, width: 28, color: white)),
        ),
      ],
    );
  }

  Container taskPriorityListWidget() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      height: 40,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          itemCount: listPriority.length,
          itemBuilder: (ctx, index) => Container(
                margin: const EdgeInsets.only(right: 10),
                height: 40,
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kButtonCornerRadius8),
                            side: BorderSide(color: Color(int.parse(listPriority[index].color.toString().replaceAll('#', '0xff'))), width: 0.7)),
                      ),
                      backgroundColor: listPriority[index].selected!
                          ? MaterialStateProperty.all<Color>(Color(int.parse(listPriority[index].color.toString().replaceAll('#', '0xff'))))
                          : MaterialStateProperty.all<Color>(white)),
                  onPressed: () {
                    if (listPriority[index].selected! == false) {
                      setState(() {
                        selectedPriorityId = checkValidString(listPriority[index].id);
                        for (var n = 0; n < listPriority.length; n++) {
                          if (n == index) {
                            listPriority[n].selected = true;
                          } else {
                            listPriority[n].selected = false;
                          }
                        }
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      children: [
                        FadeInImage.assetNetwork(
                            image: listPriority[index].selected!
                                ? listPriority[index].flagWhite.toString().trim()
                                : listPriority[index].flagColor.toString().trim(),
                            fit: BoxFit.cover,
                            width: 12,
                            height: 12,
                            placeholder: 'assets/images/ic_flag.png'),
                        const Gap(4),
                        Text(checkValidString(toDisplayCase(listPriority[index].name.toString().trim())),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: listPriority[index].selected!
                                    ? white
                                    : Color(int.parse(listPriority[index].color.toString().replaceAll('#', '0xff')))))
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  Container selectedUserList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(12), border: Border.all(color: editTextBorder, width: 0.5)),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          itemCount: listDepartmentWiseUserListSelected.length,
          padding: const EdgeInsets.all(0),
          itemBuilder: (ctx, index) => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        //Profile Image
                        child: Image.network(
                            fit: BoxFit.cover,
                            checkValidString(listDepartmentWiseUserListSelected[index].profilePicFull).toString().isNotEmpty
                                ? checkValidString(listDepartmentWiseUserListSelected[index].profilePicFull).toString()
                                : 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      ),
                    ),
                    Gap(12),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          toDisplayCase(checkValidString(listDepartmentWiseUserListSelected[index].name)),
                          textAlign: TextAlign.start,
                          style: font14(graySemiDark),
                        ),
                        Gap(6),
                        Text(
                          toDisplayCase(checkValidString(listDepartmentWiseUserListSelected[index].department) +
                              " - " +
                              toDisplayCase(checkValidString(listDepartmentWiseUserListSelected[index].designation))),
                          textAlign: TextAlign.start,
                          style: font12(graySemiDark),
                        )
                      ],
                    )),
                  ],
                ),
              ),
          separatorBuilder: (context, index) => const Divider(color: grayLight, height: 1)),
    );
  }

  Container subTaskList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(12), border: Border.all(color: editTextBorder, width: 0.5)),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          itemCount: listSubTask.length,
          padding: const EdgeInsets.all(0),
          itemBuilder: (ctx, index) => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          toDisplayCase(checkValidString(listSubTask[index].description)),
                          textAlign: TextAlign.start,
                          style: font14(graySemiDark),
                        ),
                        Gap(6),
                        Text(
                          "Assigned to, ${toDisplayCase(checkValidString(listSubTask[index].name))}",
                          textAlign: TextAlign.start,
                          style: font12(graySemiDark),
                        )
                      ],
                    )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          listSubTask.removeAt(index);
                        });
                      },
                      child: Padding(padding: const EdgeInsets.all(8), child: Image.asset('assets/images/ic_close_red.png', height: 24, width: 24)),
                    ),
                  ],
                ),
              ),
          separatorBuilder: (context, index) => const Divider(color: grayLight, height: 1)),
    );
  }

  Container taskTagsListWidget() {
    return Container(
      margin: const EdgeInsets.only(right: 12, bottom: 12),
      height: 32,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          itemCount: listTags.length,
          itemBuilder: (ctx, index) => Container(
                margin: const EdgeInsets.only(right: 10),
                height: 32,
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(kButton2CornerRadius), bottomRight: Radius.circular(kButton2CornerRadius)),
                            side: const BorderSide(color: assignBg, width: 0.7)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(assignBg)),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(checkValidString(toDisplayCase(listTags[index].toString().trim())),
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: assignText)),
                  ),
                ),
              )),
    );
  }

  void openDepartmentWiseUserSelection(bool isForMultiple) {
    showModalBottomSheet<String>(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: StatefulBuilder(
              builder: (context, setStateDialog) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.88,
                  ),
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        Container(
                          decoration:
                              const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                          padding: const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 2,
                                    width: 40,
                                    alignment: Alignment.center,
                                    color: orange,
                                    margin: const EdgeInsets.only(top: 10, bottom: 6),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10, left: 20),
                                    child: Row(
                                      children: [
                                        Expanded(child: Text("Select Assignees", style: font20(blueNormal))),
                                        Visibility(
                                          visible: isForMultiple,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                listDepartmentWiseUserListSelected = [];
                                                for (var n = 0; n < listDepartmentWiseUserList.length; n++) {
                                                  if (listDepartmentWiseUserList[n].selected == true) {
                                                    listDepartmentWiseUserListSelected.add(listDepartmentWiseUserList[n]);
                                                  }
                                                }
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(left: 8, right: 15, top: 8, bottom: 8),
                                              child: Text(
                                                "Save",
                                                style: TextStyle(fontSize: 20, fontFamily: otherFont, color: black, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                        child: Column(
                                          children: [
                                            ListView.builder(
                                              itemCount: listDepartmentWiseUserList.length,
                                              physics: const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return IntrinsicHeight(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (isForMultiple) {
                                                        setStateDialog(() {
                                                          if (listDepartmentWiseUserList[index].selected == true) {
                                                            listDepartmentWiseUserList[index].selected = false;
                                                          } else {
                                                            listDepartmentWiseUserList[index].selected = true;
                                                          }
                                                        });
                                                      } else {
                                                        setState(() {
                                                          assignUserDetailsForSubTask = listDepartmentWiseUserList[index];
                                                          selectedAssigneesId = checkValidString(assignUserDetailsForSubTask.id);
                                                        });
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Container(
                                                      color: white,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.only(left: 22, right: 22, top: 15, bottom: 15),
                                                            child: Row(
                                                              children: [
                                                                isForMultiple
                                                                    ? listDepartmentWiseUserList[index].selected == true
                                                                        ? Image.asset('assets/images/ic_selected.png', height: 32, width: 32)
                                                                        : Image.asset(
                                                                            'assets/images/ic_un_selected.png',
                                                                            height: 32,
                                                                            width: 32,
                                                                            color: grayDark,
                                                                          )
                                                                    : assignUserDetailsForSubTask.id == listDepartmentWiseUserList[index].id
                                                                        ? Image.asset('assets/images/ic_selected.png', height: 32, width: 32)
                                                                        : Image.asset(
                                                                            'assets/images/ic_un_selected.png',
                                                                            height: 32,
                                                                            width: 32,
                                                                            color: grayDark,
                                                                          ),
                                                                const Gap(10),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Text(toDisplayCase(checkValidString(listDepartmentWiseUserList[index].name)),
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: otherFont,
                                                                            color: black,
                                                                            fontWeight: FontWeight.w500)),
                                                                    const Gap(4),
                                                                    Text(
                                                                        toDisplayCase(checkValidString(listDepartmentWiseUserList[index].department) +
                                                                            " - " +
                                                                            toDisplayCase(
                                                                                checkValidString(listDepartmentWiseUserList[index].designation))),
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            fontFamily: otherFont,
                                                                            color: grayDark,
                                                                            fontWeight: FontWeight.w500))
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 0.5,
                                                            color: (index == listDepartmentWiseUserList.length - 1) ? white : graySemiDark,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }).then(
      (value) {},
    );
  }

  final TextEditingController _tagTextController = TextEditingController();

  void addTagsPopup() {
    _tagTextController.text = "";
    showModalBottomSheet<String>(
        isScrollControlled: true,
        backgroundColor: white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: StatefulBuilder(
              builder: (context, setStateDialog) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.88,
                  ),
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        Container(
                          decoration:
                              const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                          padding: const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 2,
                                    width: 40,
                                    alignment: Alignment.center,
                                    color: orange,
                                    margin: const EdgeInsets.only(top: 10, bottom: 6),
                                  ),
                                  Container(margin: const EdgeInsets.only(top: 10, left: 20), child: Text("Add Tags", style: font20(blueNormal))),
                                ],
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Tag Title",
                                              textAlign: TextAlign.start,
                                              style: font18SemiBold(black),
                                            ),
                                            const Gap(16),
                                            TextField(
                                              cursorColor: editTextColor,
                                              controller: _tagTextController,
                                              keyboardType: TextInputType.text,
                                              style: editTextStyleAll(),
                                              decoration: InputDecoration(
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
                                                hintStyle: const TextStyle(
                                                    color: editTextColor, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
                                              ),
                                            ),
                                            Gap(30),
                                            Container(
                                              margin: const EdgeInsets.only(left: 10, right: 10),
                                              width: MediaQuery.of(context).size.width,
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(kButtonCornerRadius),
                                                        ),
                                                      ),
                                                      backgroundColor: MaterialStateProperty.all<Color>(button_bg)),
                                                  onPressed: () async {
                                                    FocusScope.of(context).requestFocus(FocusNode());
                                                    String tagTitle = _tagTextController.text.toString().trim();
                                                    if (tagTitle.isEmpty) {
                                                      showToast("Please enter a tag title", context);
                                                    } else {
                                                      setState(() {
                                                        listTags.add(tagTitle.toString().trim());
                                                      });
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(top: 8, bottom: 8),
                                                    child: Text(
                                                      "Save",
                                                      textAlign: TextAlign.center,
                                                      style:
                                                          TextStyle(fontSize: 16, fontFamily: otherFont, color: white, fontWeight: FontWeight.w600),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }).then(
      (value) {},
    );
  }

  _getPriorityDataFromAPI() async {
    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + taskPriorityList);
      Map<String, String> jsonBody = {'call_app': CALL_APP, 'from_app': IS_FROM_APP, 'logged_in_user_id': sessionManager.getId().toString().trim()};

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
    _getDepartmentWiseUserListDataFromAPI();
  }

  Future<void> _showDatePicker() async {
    print("<>>>>> Selected Date :: " + _taskDueDateController.text.toString().trim() + " <<<<<<<><>");

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
        initialDate: _taskDueDateController.text.toString().trim().isNotEmpty
            ? DateFormat('dd MMM, yyyy').parse(_taskDueDateController.text.toString().trim())
            : DateTime.now());

    if (result != null) {
      String startDateFormat = DateFormat('dd MMM, yyyy').format(result);
      print("<><> SHOW DATE ::: $startDateFormat <><>");
      if (startDateFormat.isNotEmpty) {
        setState(() {
          _taskDueDateController.text = startDateFormat;
        });
        print("<><> SHOW DATETIME ::: $startDateFormat<><>");
      }
    }
  }

  Future<String> _selectTime() async {
    var time = "";
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              // change the border color
              primary: Colors.black,
              // change the text color
              onSurface: Colors.black,
            ),
            // button colors
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      DateTime tempDate = DateFormat("hh:mm").parse("${picked.hour}:${picked.minute}");
      var dateFormat = DateFormat("hh:mm a"); // you can change the format here
      time = dateFormat.format(tempDate);

      setState(() {
        _taskDueTimeController.text = time;
      });
    }

    return time;
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
                listDepartmentWiseUserList.add(dataResponse.data![n]);
              }

              if (taskListData.userAssignTo != null) {
                if (taskListData.userAssignTo!.userId != null) {
                  selectedAssigneesId = checkValidString(taskListData.userAssignTo!.userId);
                  for (var n = 0; n < listDepartmentWiseUserList.length; n++) {
                    if (listDepartmentWiseUserList[n].id == selectedAssigneesId) {
                      listDepartmentWiseUserListSelected.add(listDepartmentWiseUserList[n]);
                    }
                  }
                }
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
  }

  _updateTaskAPI() async {
    if (isOnline) {
      setState(() {
        _isLoading = true;
      });
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + taskUpdate);
      Map<String, String> jsonBody = {
        'call_app': CALL_APP,
        'from_app': IS_FROM_APP,
        'logged_in_user_id': sessionManager.getId().toString(),
        'title': _taskTitleController.text.toString().trim(),
        'description': _descriptionController.text.toString().trim(),
        'due_date': selectedDateFinal.isNotEmpty ? getTimeStampDate(selectedDateFinal.trim(), "dd MMM, yyyy hh:mm a").toString() : "",
        'priority_id': selectedPriorityId,
        'task_id': checkValidString(taskListData.id),
        'user_id_assign': selectedAssigneesId.isNotEmpty ? selectedAssigneesId : "",
        'sub_description': _subDescriptionController.text.toString().trim(),
        'task_tags_array': selectedTags,
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = BasicResponseModel.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          showSnackBar(dataResponse.message, context);
          isReloadList = "success";
        } catch (e) {
          print(e);
        }
      } else {
        showSnackBar(dataResponse.message, context);
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      noInterNet(context);
    }
  }

  _getTaskDetailsDataFromAPI() async {
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
        'call_app': CALL_APP,
        'task_id': checkValidString(taskListData.id)
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = TaskListResponseModel.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              setState(() {
                taskListData = dataResponse.data![0];
              });
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
    widget is TaskDetailPage;
  }

  void setUpdata() {
    if (taskListData.title != null) {
      _taskTitleController.text = checkValidString(taskListData.title);
    }

    if (taskListData.description != null) {
      _descriptionController.text = checkValidString(taskListData.description);
    }

    if (taskListData.dueDateTime != null) {
      if (taskListData.dueDateTime!.date != null) {
        _taskDueDateController.text = checkValidString(taskListData.dueDateTime!.date);
      }

      if (taskListData.dueDateTime!.time != null) {
        _taskDueTimeController.text = checkValidString(taskListData.dueDateTime!.time);
      }
    }

    if (taskListData.priority != null) {
      if (taskListData.priority!.id != null) {
        selectedPriorityId = checkValidString(taskListData.priority!.id);
        for (var n = 0; n < listPriority.length; n++) {
          if (listPriority[n].id == selectedPriorityId) {
            listPriority[n].selected = true;
          } else {
            listPriority[n].selected = false;
          }
        }
      }
    }

    if (taskListData.subDescription != null) {
      _subDescriptionController.text = checkValidString(taskListData.subDescription);
    }

    if (taskListData.tagsArray != null) {
      listTags = taskListData.tagsArray!;
    }
  }
}
