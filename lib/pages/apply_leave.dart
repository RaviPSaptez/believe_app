import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../data/model/leave_type_model.dart';
import '../model/BasicResponseModel.dart';
import '../model/leave/LeaveDurationResponse.dart';
import '../model/task/FilterValueModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../widget/loading.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  _ApplyLeaveScreenState createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends BaseState<ApplyLeaveScreen> {
  bool _isLoading = false;
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _subjectTextController = TextEditingController();
  final TextEditingController _reasonTextController = TextEditingController();
  List<FilterMenuGetSet> types = List<FilterMenuGetSet>.empty(growable: true);
  String _selectedType = '';
  List<FilterMenuGetSet> durations = List<FilterMenuGetSet>.empty(growable: true);
  String selectedDuration = "";
  String fromDate = '';
  String toDate = '';

  @override
  void initState() {
    _getLeaveTypeDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: themePurple,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: themePurple,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 22, right: 22),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 15,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)), color: themePurpleDark),
            ),
          ),
          Expanded(
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    header(),
                    Expanded(
                      child: _isLoading
                          ? const LoadingWidget() : ListView(
                        children: [
                          typeRow(), // Type Selection
                          fromRow(), // For Date Selection From
                          toDateRow(), // For Date Selection To
                          subjectRow(), // For Subject
                          reasonRow(), //For Reason
                          durationRow(), //Duration List
                          const SizedBox(height: 25)
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
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
          const Row(
            children: [
              SizedBox(width: 12),
              Center(child: Text('Apply Leave', style: TextStyle(color: themePurple, fontSize: 20, fontWeight: FontWeight.w900))),
            ],
          ),
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: ()
              {

                if (_typeController.text.toString().trim().isEmpty) {
                  showToast("Please select type", context);
                } else if (_fromDateController.text.toString().trim().isEmpty) {
                  showToast("Please select from date", context);
                } else if (_toDateController.text.toString().trim().isEmpty) {
                  showToast("Please select to date", context);
                } else if (_subjectTextController.text.toString().trim().isEmpty) {
                  showToast("Please enter subject", context);
                } else if (_reasonTextController.text.toString().trim().isEmpty) {
                  showToast("Please enter reason of absence", context);
                } else if (selectedDuration.toString().trim().isEmpty) {
                  showToast("Please select duration", context);
                }  else {

                  if (isOnline) {
                    _saveInfoAPI();
                  } else {
                    noInterNet(context);
                  }
                }
              },
              child: const Text('Save', style: TextStyle(fontSize: 20)))
        ],
      ),
    );
  }

  Widget typeRow() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Type', style: TextStyle(color: themeBlack, fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 14),
              TextField(
                cursorColor: editTextColor,
                controller: _typeController,
                keyboardType: TextInputType.text,
                style: editTextStyleAll(),
                readOnly: true,
                onTap: () {
                  bottomSheetforTypes(types);
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
            ],
          ),
        ),
      ],
    );
  }

  Widget fromRow() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('From', style: TextStyle(color: themeBlack, fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 14),
              TextField(
                cursorColor: editTextColor,
                controller: _fromDateController,
                keyboardType: TextInputType.text,
                style: editTextStyleAll(),
                readOnly: true,
                onTap: () {
                  _showDatePicker(_fromDateController);
                },
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      'assets/images/ic_due_date.png',
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
            ],
          ),
        ),
      ],
    );
  }

  Widget toDateRow() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('To', style: TextStyle(color: themeBlack, fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 14),
              TextField(
                cursorColor: editTextColor,
                controller: _toDateController,
                keyboardType: TextInputType.text,
                style: editTextStyleAll(),
                readOnly: true,
                onTap: () {
                  _showDatePicker(_toDateController);
                },
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      'assets/images/ic_due_date.png',
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
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget subjectRow() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Subject', style: TextStyle(color: themeBlack, fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 14),
              TextField(
                cursorColor: editTextColor,
                controller: _subjectTextController,
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
                  hintStyle: const TextStyle(color: editTextColor, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget reasonRow() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Reason for Absence', style: TextStyle(color: themeBlack, fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 14),
              TextField(
                cursorColor: editTextColor,
                controller: _reasonTextController,
                keyboardType: TextInputType.text,
                style: editTextStyleAll(),
                maxLines: 6,
                minLines: 4,
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
                  hintStyle: const TextStyle(color: editTextColor, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget durationRow() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Duration', style: TextStyle(color: themeBlack, fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 14),
              SizedBox(
                  height: 45,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 20,
                          decoration: BoxDecoration(
                              color: durations[index].id.toString() == selectedDuration ? themePurple : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: const Border.symmetric(horizontal: BorderSide(color: themePurple), vertical: BorderSide(color: themePurple))),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15),
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedDuration = durations[index].id.toString();
                                  });
                                },
                                child: Text(durations[index].name,
                                    style: TextStyle(color: durations[index].id.toString() == selectedDuration ? Colors.white : themePurple))),
                          )),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemCount: durations.length,
                      scrollDirection: Axis.horizontal)),
            ],
          ),
        ),
      ],
    );
  }

  Future<dynamic> bottomSheetforTypes(List<FilterMenuGetSet> options) {
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
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: SvgPicture.asset('assets/svgs/close.svg', width: 20, height: 20),
                                  ),
                                ),
                                Expanded(child: Text('Type',textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)))
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
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                setState(() {
                                  _selectedType = options[index].id.toString();
                                  _typeController.text = options[index].name.toString().trim();
                                });

                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    options[index].name,
                                    style: TextStyle(color: _selectedType == options[index].id ? themePurple : const Color(0xff666666), fontSize: 18),
                                  ),
                                  _selectedType == options[index].id ? const Icon(Icons.circle, size: 10, color: themePurple) : const SizedBox()
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
              for (var n = 0; n < dataResponse.data!.length; n++) {
                types.add(
                    FilterMenuGetSet(idStatic: checkValidString(dataResponse.data![n].id), nameStatic: checkValidString(dataResponse.data![n].name)));
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

    _getLeaveDurationFromAPI();
  }

  _getLeaveDurationFromAPI() async {

    if (isOnline) {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + leaveDurationApi);
      Map<String, String> jsonBody = {'call_app': CALL_APP, 'from_app': IS_FROM_APP, 'logged_in_user_id': sessionManager.getId().toString().trim()};

      final response = await http.post(url, body: jsonBody, headers: {
        "Authorization": API_Token,
      });

      final statusCode = response.statusCode;
      final body = response.body;
      Map<String, dynamic> apiData = jsonDecode(body);
      var dataResponse = LeaveDurationResponse.fromJson(apiData);
      if (statusCode == 200 && dataResponse.success == 1) {
        try {
          if (dataResponse.data != null) {
            if (dataResponse.data!.isNotEmpty) {
              for (var n = 0; n < dataResponse.data!.length; n++) {
                durations.add(FilterMenuGetSet(idStatic: checkValidString(dataResponse.data![n].id), nameStatic: checkValidString(dataResponse.data![n].name)));
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
  void dispose() {
    _subjectTextController.dispose();
    _reasonTextController.dispose();
    super.dispose();
  }

  void valueChanger(value, id) {
    setState(() {
      _selectedType = value;
    });
  }

  Future<void> _showDatePicker(TextEditingController textcontroller) async {

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
        initialDate: textcontroller.text.toString().trim().isNotEmpty
            ? DateFormat('dd MMM, yyyy').parse(textcontroller.text.toString().trim())
            : DateTime.now());

    if (result != null) {
      String startDateFormat = DateFormat('dd MMM, yyyy').format(result);
      print("<><> SHOW DATE ::: $startDateFormat <><>");
      if (startDateFormat.isNotEmpty) {
        setState(() {
          textcontroller.text = startDateFormat;
        });
        print("<><> SHOW DATETIME ::: $startDateFormat<><>");
      }
    }
  }


  _saveInfoAPI() async {
    if (isOnline) {
      setState(() {
        _isLoading = true;
      });
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(API_URL + leaveSaveApi);
      Map<String, String> jsonBody = {
        'call_app': CALL_APP,
        'from_app': IS_FROM_APP,
        'logged_in_user_id': sessionManager.getId().toString(),
        'subject': _subjectTextController.text.toString().trim(),
        'description': _reasonTextController.text.toString().trim(),
        'from_date': _fromDateController.text.toString().isNotEmpty ? getTimeStampDate(_fromDateController.text.toString(), "dd MMM, yyyy").toString() : "",
        'to_date': _fromDateController.text.toString().isNotEmpty ? getTimeStampDate(_toDateController.text.toString(), "dd MMM, yyyy").toString() : "",
        'duration_id': selectedDuration,
        'type_id': _selectedType
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
          Navigator.pop(context, "success");
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

  @override
  void castStatefulWidget() {
    // TODO: implement castStatefulWidget
  }
}
