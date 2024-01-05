import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../constant/api_end_point.dart';
import '../../constant/colors.dart';
import '../../constant/global_context.dart';
import '../../model/other/filter_model.dart';
import '../../model/leave/leave_list_model.dart';
import '../../model/leave/leave_type_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/base_class.dart';
import '../../widget/loading.dart';
import '../../widget/no_data.dart';
import '../tabs/dashboard_menu.dart';
import 'apply_leave.dart';

class LeavesScreen extends StatefulWidget {
  bool isFromNotification = false;
  LeavesScreen({this.isFromNotification = false,Key? key}) : super(key: key);

  @override
  _LeavesScreenState createState() => _LeavesScreenState();
}

class _LeavesScreenState extends BaseState<LeavesScreen> {
  bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  String searchText = "";
  String _selectedType = "All";
  String _selectedTypeId = "";
  String _selectedCondition = 'Is';
  String _selectedStatusFilter = 'All';
  String _selectedStatusFilterId = "";
  bool isFilterOn = false;
  List<Condition> conditions = [];
  List<Status> status = List<Status>.empty(growable: true);
  List<LeaveTypeData> leaveTypes = List<LeaveTypeData>.empty(growable: true);
  List<LeaveListData> listLeave = List<LeaveListData>.empty(growable: true);
  final ScrollController _scrollViewController = ScrollController();
  bool isFromNotification = false;

  @override
  void initState() {
    isFromNotification = (widget as LeavesScreen).isFromNotification;
    conditions = [
      Condition(name: 'Is', id: 1),
      Condition(name: 'Is Not', id: 0),
    ];
    _getLeaveTypeDataFromAPI();
    super.initState();
  }

  void tempTypeValueChange(value, id) {
    setState(() {
      _selectedType = value;
      _selectedTypeId = id;
    });
  }

  void tempConditionValueChange(value) {
    setState(() {
      _selectedCondition = value;
    });
  }

  void tempStatusValueChange(value, id) {
    setState(() {
      _selectedStatusFilter = value;
      _selectedStatusFilterId = id;
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: themePurple,
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
        backgroundColor: themePurple,
        appBar: AppBar(
            toolbarHeight: 110,
            automaticallyImplyLeading: false,
            backgroundColor: themePurple,
            elevation: 0,
            titleSpacing: 12,
            centerTitle: false,
            title: Column(
              children: [appBar(context), const Gap(12), searchBar()],
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
                        leaveTypeListWidget(),
                        Expanded(child: listLeave.isNotEmpty ? leaveListWidget() : const MyNoDataWidget(msg: "No data found!"))
                      ],
                    )),
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
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: themePurpleDark),
              height: 42,
              width: 42,
              padding: const EdgeInsets.all(13),
              child: Image.asset('assets/images/ic_back_arrow.png', height: 28, width: 28)),
        ),
        const Gap(12),
        Expanded(
          child: Text(
            "My Leaves",
            textAlign: TextAlign.start,
            style: titleFontNormal(white, 20),
          ),
        ),
        const Gap(12),
        Visibility(
          visible: sessionManager.getIsHOD().toString().trim() == "1",
          child: GestureDetector(
            onTap: () {
              _redirectToAdd(false, LeaveListData());
            },
            child: Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: themePurpleDark),
                height: 42,
                width: 42,
                padding: const EdgeInsets.all(13),
                child: Image.asset('assets/images/ic_add.png', height: 28, width: 28)),
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
              fillColor: themePurpleDark,
              contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                  borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: themePurpleDark)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                  borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: themePurpleDark)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kButtonCornerRadius12), borderSide: const BorderSide(width: 0.5, color: themePurpleDark)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kButtonCornerRadius12), borderSide: const BorderSide(width: 0.5, color: themePurpleDark)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                  borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: themePurpleDark)),
              hintText: 'Search Leaves...',
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
            bottomSheetforFilter();
          },
          child: Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: themePurpleDark),
              height: 44,
              width: 44,
              padding: const EdgeInsets.all(12),
              child: Image.asset('assets/images/ic_filter.png', height: 28, width: 28)),
        ),
      ],
    );
  }

  Container leaveTypeListWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 15),
      height: 40,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          itemCount: leaveTypes.length,
          itemBuilder: (ctx, index) => Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                height: 40,
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kButtonCornerRadius8), side: const BorderSide(color: themePurpleDark, width: 0.7)),
                      ),
                      backgroundColor: leaveTypes[index].id == _selectedTypeId
                          ? MaterialStateProperty.all<Color>(themePurpleDark)
                          : MaterialStateProperty.all<Color>(white)),
                  onPressed: () {
                    if (leaveTypes[index].id != _selectedTypeId) {
                      setState(() {
                        _selectedTypeId = checkValidString(leaveTypes[index].id);
                        _selectedType = checkValidString(leaveTypes[index].name);
                      });

                      if (isOnline) {
                        _getListDataFromAPI();
                      } else {
                        noInterNet(context);
                      }
                    }
                  },
                  child: Text(checkValidString(toDisplayCase(leaveTypes[index].name.toString().trim())),
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w400, color: leaveTypes[index].id == _selectedTypeId ? white : themePurpleDark)),
                ),
              )),
    );
  }

  ListView leaveListWidget() {
    return ListView.builder(
      controller: _scrollViewController,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemCount: listLeave.length,
      itemBuilder: (ctx, index) => leaveListItem(index),
    );
  }

  leaveListItem(int index) {
    Color statusColor = Colors.black;
    String status = checkValidString(listLeave[index].leaveStatus!.name);
    if (status == 'Approved') {
      statusColor = Colors.green.shade900;
    }
    if (status == 'Rejected') {
      statusColor = Colors.red.shade900;
    }
    if (status == 'Pending') {
      statusColor = Colors.yellow.shade600;
    }

    String formattedFromDate = checkValidString(listLeave[index].leaveDays!.fromDate);
    String formattedToDate = checkValidString(listLeave[index].leaveDays!.toDate).toString().isNotEmpty
        ? checkValidString(listLeave[index].leaveDays!.toDate)
        : checkValidString(listLeave[index].leaveDays!.fromDate);

    DateTime dateFrom = DateFormat('dd MMM, yyyy').parse(checkValidString(listLeave[index].leaveDays!.fromDate));
    DateTime dateTo = checkValidString(listLeave[index].leaveDays!.toDate).toString().isEmpty
        ? DateFormat('dd MMM, yyyy').parse(checkValidString(listLeave[index].leaveDays!.fromDate))
        : DateFormat('dd MMM, yyyy').parse(checkValidString(listLeave[index].leaveDays!.toDate));
    int days = dateTo.difference(dateFrom).inDays;

    String totalDays;

    if (days == 1 || days == 0) {
      totalDays = '1 Day';
    } else {
      totalDays = '$days Days';
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        //_redirectToAdd(true,listTask[index]);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(12), border: Border.all(color: editTextBorder, width: 0.5)),
        padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
        margin: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(toDisplayCase(checkValidString(listLeave[index].subject)),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 70,
                      // padding:EdgeInsets.all(6),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: themePurpleLight),
                      child: Center(
                          child: Text(toDisplayCase(checkValidString(listLeave[index].leaveType!.name.toString())),
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: themePurple))),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 30,
                      width: 60,
                      // padding:EdgeInsets.all(6),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: themePurpleLight),
                      child: Center(child: Text(totalDays, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: themePurple))),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(toDisplayCase(checkValidString(listLeave[index].description)),
                style: const TextStyle(fontSize: 12, color: themeGrey), maxLines: 3, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/svgs/date.svg', width: 14, height: 14),
                    const SizedBox(width: 5),
                    Text('$formattedFromDate to $formattedToDate', style: const TextStyle(color: themeGrey, fontSize: 12))
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.circle, color: statusColor, size: 12),
                    const SizedBox(width: 4),
                    Text(toDisplayCase(checkValidString(listLeave[index].leaveStatus!.name.toString())),
                        style: TextStyle(fontFamily: 'Recoleta', color: statusColor, fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _isController = TextEditingController();
  final TextEditingController _selectOptionController = TextEditingController();

  Future<dynamic> bottomSheetforFilter() {
    _typeController.text = _selectedType;
    _isController.text = _selectedCondition;
    _selectOptionController.text = checkValidString(_selectedStatusFilter);
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Center(
                  child: Container(
                    height: 6,
                    width: 60,
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: grayLight, width: 1.0))),
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
                                  child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Image.asset('assets/images/ic_close.png', height: 16, width: 16, color: black)),
                                ),
                                Expanded(
                                  child: Text(
                                    "Filter",
                                    textAlign: TextAlign.center,
                                    style: font20(themePurple),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      setState(() {
                                        _selectedTypeId = "";
                                        _selectedType = "All";
                                        _selectedCondition = 'Is';
                                        _selectedStatusFilter = 'All';
                                        _selectedStatusFilterId = "";
                                         isFilterOn = false;
                                      });
                                    });
                                    if (isOnline) {
                                      _getListDataFromAPI();
                                    } else {
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
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Gap(10),
                              Text(
                                "Type",
                                textAlign: TextAlign.start,
                                style: font18SemiBold(black),
                              ),
                              const Gap(16),
                              TextField(
                                cursorColor: editTextColor,
                                controller: _typeController,
                                keyboardType: TextInputType.text,
                                style: editTextStyleAll(),
                                readOnly: true,
                                onTap: () {
                                  bottomSheetforSelection(_selectedType, leaveTypes, 'Type', _typeController);
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
                                  bottomSheetforSelection(_selectedCondition, conditions, 'Is', _isController);
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
                                  bottomSheetforSelection(_selectedStatusFilter, status, 'Status', _selectOptionController);
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
                                      backgroundColor: MaterialStateProperty.all<Color>(themePurple)),
                                  onPressed: () async {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    Navigator.pop(context);
                                    if(isOnline)
                                    {
                                      _getListDataFromAPI();
                                    }
                                    else
                                    {
                                      showToast("Please check your internet connection!", context);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                                    child: const Text(
                                      "Apply",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16, fontFamily: otherFont, color: white, fontWeight: FontWeight.w600),
                                    ),
                                  )),
                            ),
                            ],
                          ))
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

  Future<dynamic> bottomSheetforSelection(value, List options, String type, TextEditingController controller) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Center(
                  child: Container(
                    height: 6,
                    width: 60,
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffD9D9D9), width: 1.5))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: SvgPicture.asset('assets/svgs/close.svg', width: 20, height: 20),
                                  ),
                                ),
                                Expanded(child: Text("Select $type", textAlign : TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)))
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 28, bottom: 28),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            String data = options[index].name;
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                setState(() {
                                  value = data;
                                  if (type == 'Type') {
                                    _selectedType = value;
                                    _selectedTypeId = options[index].id;
                                  }
                                  
                                  if (type == 'Is') {
                                    _selectedCondition = value;
                                  }
                                  
                                  if (type == 'Status') {
                                    _selectedStatusFilter = value;
                                    _selectedStatusFilterId = options[index].id;
                                  }
                                  controller.text = value;
                                  Navigator.pop(context);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data,
                                    style: TextStyle(color: value == data ? themePurple : const Color(0xff666666), fontSize: 18),
                                  ),
                                  value == data ? const Icon(Icons.circle, size: 10, color: themePurple) : const SizedBox()
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 22),
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

  Widget filterOptions(String title, String leaveType) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: themeBlack, fontSize: 20, fontWeight: FontWeight.w500)),
          const SizedBox(height: 14),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 55,
            decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(12)), border: Border.all(color: const Color(0xff666666))),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(leaveType, style: const TextStyle(color: Color(0xff666666))),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22, top: 22),
                    child: SvgPicture.asset('assets/svgs/downArrow.svg', height: 25, width: 25),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getLeaveTypeDataFromAPI() async {
    setState(() {
      _isLoading = true;
    });
    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + leaveTypesApi);
      Map<String, String> jsonBody = {'call_app': CALL_APP, 'from_app': IS_FROM_APP, 'logged_in_user_id': sessionManager.getId().toString().trim()};

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = LeaveTypes.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              var allObj = LeaveTypeData(id: "", name: "All");
              leaveTypes.add(allObj);
              for (var n = 0; n < dataResponse.data!.length; n++) {
                leaveTypes.add(dataResponse.data![n]);
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

    _getLeaveStatusDataFromAPI();
  }

  _getLeaveStatusDataFromAPI() async {
    setState(() {
      _isLoading = true;
    });
    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + leaveStatusApi);
      Map<String, String> jsonBody = {'call_app': CALL_APP, 'from_app': IS_FROM_APP, 'logged_in_user_id': sessionManager.getId().toString().trim()};

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = LeaveTypes.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1)
      {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              var allObj = Status(id: "", name: "All");
              status.add(allObj);
              for (var n = 0; n < dataResponse.data!.length; n++)
              {
                status.add(Status(id: dataResponse.data![n].id.toString(), name: dataResponse.data![n].name));
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

    _getListDataFromAPI();
  }

  _getListDataFromAPI() async {
    if (isOnline) {
      setState(() {
        _isLoading = true;
      });
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + leaveListApi);
      Map<String, String> jsonBody = {
        'logged_in_user_id': sessionManager.getId().toString().trim(),
        'call_app': CALL_APP,
        'from_app': IS_FROM_APP,
        'search': searchText,
        'type_ids': _selectedTypeId.isNotEmpty ? _selectedTypeId : "",
        'type_is_or_not': _selectedCondition == 'Is' ? "1" : "0",
        'status_ids': _selectedStatusFilterId
      };

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      listLeave = [];
      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = LeaveListModel.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              listLeave = dataResponse.data!;
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

  Future<void> _redirectToAdd(bool isFrom, LeaveListData listData) async {
    hideKeyboard(context);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApplyLeaveScreen()),
    );
    print("result ===== $result");
    if (result == "success") {
      setState(() {});
      _getListDataFromAPI();
    }
  }

  @override
  void castStatefulWidget() {
    // TODO: implement castStatefulWidget
  }
}
