import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../constant/api_end_point.dart';
import '../constant/colors.dart';
import '../data/model/event_news_model.dart';
import '../data/model/event_type_model.dart';
import '../model/BasicResponseModel.dart';
import '../utils/app_utils.dart';
import '../utils/base_class.dart';
import '../widget/loading.dart';

class AddEventScreen extends StatefulWidget {
  bool isFrom;
  EventNewsListItem item;
  AddEventScreen(this.isFrom, this.item, {Key? key}) : super(key: key);
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends BaseState<AddEventScreen> {
  bool _isLoading = false;
  String _selectedType = 'Event';
  String _selectedDepartment = '';
  String selectedDateFinal = '';
  bool _switchValue = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  File? pickedImage;
  String selectedFile = "";
  bool isImagePicked = false;
  List<EventType> types = [];
  List<Department> department = [];
  bool isFrom = false;
  EventNewsListItem  listItemData = EventNewsListItem();

  @override
  void initState() {
    isFrom = (widget as AddEventScreen).isFrom;
    listItemData = (widget as AddEventScreen).item;
    department = [
      Department(name: 'Factory', id: 1),
      Department(name: 'Account', id: 2),
      Department(name: 'Finance', id: 3),
    ];
    types = [EventType(name: 'Event', id: 1), EventType(name: 'News', id: 2)];

    if(isFrom)
      {
        setUpdata();
      }

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void setUpdata() {

    setState(() {
      if (listItemData.campaignType != null) {
        for (var n = 0; n < types.length; n++) {
          if (types[n].id.toString() == listItemData.campaignType) {
            _selectedType = types[n].name.toString();
          }
        }
      }

      if (listItemData.title != null) {
        _titleController.text = checkValidString(listItemData.title);
      }

      if (listItemData.description != null) {
        _descController.text = checkValidString(listItemData.description);
      }

      if (listItemData.createdAtDateTime != null) {
        if (listItemData.createdAtDateTime!.date != null) {
          _dateController.text = checkValidString(listItemData.createdAtDateTime!.date);
        }

        if (listItemData.createdAtDateTime!.time != null) {
          _timeController.text = checkValidString(listItemData.createdAtDateTime!.time);
        }
      }

      if (listItemData.departmentId != null) {
        for (var n = 0; n < department.length; n++) {
          if (department[n].id.toString() == listItemData.departmentId) {
            _departmentController.text = checkValidString(department[n].name);
            _selectedDepartment = department[n].id.toString();
          }
        }
      }

      if (listItemData.attachmentFull != null) {
        isImagePicked = true;
        selectedFile = listItemData.attachmentFull.toString().trim();
      }
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 22, right: 22),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 15,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)), color: const Color(0xffA0004B)),
              ),
            ),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                    color: Colors.white,
                  ),
                  child: _isLoading ? const LoadingWidget() : Column(
                    children: [
                      header(),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(18),
                          children: [
                            photoSection(),
                            selectTypeSection(),
                            titleSection(),
                            descriptionSection(),
                            eventDateSelection(),
                            eventTimeSelection(),
                            selectDepartment(),
                            rsvpSection()
                          ],
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void valueChanger(value) {
    setState(() {
      _selectedDepartment = value;
    });
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['jpg']);
      if (result != null) {
        var filepath = result.files.single.path!;
        setState(() {
          pickedImage = File(filepath);
          selectedFile = filepath;
          print("<><> FILE PATH :::" + selectedFile.toString() + " <><>");
          isImagePicked = true;
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print(e);
    }
  }

  Text titleText(String title) {
    return Text(title, style: font18SemiBold(black));
  }

  Widget header() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 18),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffD9D9D9)))),
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
          Row(
            children: [
              SizedBox(width: 12),
              Center(child: Text(isFrom ? 'Update Event' : 'Add Event', style: TextStyle(color: themePink, fontSize: 20, fontWeight: FontWeight.w900))),
            ],
          ),
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (_selectedType.toString().trim().isEmpty) {
                  showToast("Please select type", context);
                } else if (_titleController.text.toString().trim().isEmpty) {
                  showToast("Please enter title", context);
                } else if (_descController.text.toString().trim().isEmpty) {
                  showToast("Please enter description", context);
                } else if (_selectedType == 'Event' && _dateController.text.toString().trim().isEmpty) {
                  showToast("Please select event date", context);
                } else if (_selectedType == 'Event' && _timeController.text.toString().trim().isEmpty) {
                  showToast("Please select event time", context);
                } else {
                  if (_selectedType == 'Event') {
                    selectedDateFinal = "${_dateController.text.toString().trim()} ${_timeController.text.toString().trim()}";
                  }

                  if (isOnline) {
                    _saveInfo();
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

  _saveInfo() async {
    if (isOnline) {
      setState(() {
        _isLoading = true;
      });

      final url = Uri.parse(API_URL + addEvent);
      var request = await MultipartRequest("POST", url);
      Map<String, String> headers = {"Authorization": API_Token.toString()};
      request.headers.addAll(headers);

      if(isFrom)
        {
          request.fields['campaign_id'] = checkValidString(listItemData.id);
        }

      request.fields['call_app'] = CALL_APP;
      request.fields['from_app'] = IS_FROM_APP;
      request.fields['logged_in_user_id'] = sessionManager.getId().toString();
      request.fields['title'] = _titleController.text.toString().trim();
      request.fields['description'] = _descController.text.toString().trim();
      request.fields['department_id'] = _selectedDepartment;
      request.fields['campaign_type'] = _selectedType == 'Event' ? "1" : "2";
      request.fields['rsvp'] = _switchValue == true ? "1" : "0";

      request.fields['campaign_time'] = _selectedType == 'Event'
          ? selectedDateFinal.isNotEmpty
              ? getTimeStampDate(selectedDateFinal.trim(), "dd MMM, yyyy hh:mm a").toString()
              : ""
          : "";

      if (selectedFile.isNotEmpty && !selectedFile.toString().trim().startsWith("https"))
      {
        var multipartFile = await MultipartFile.fromPath("attachment", selectedFile);
        request.files.add(multipartFile);
      }
      else if(selectedFile.isNotEmpty && selectedFile.toString().trim().startsWith("https"))
        {
          request.fields['attachment'] = listItemData.attachment.toString().trim();
        }

      var response = await request.send();
      //Get the response from the server
      final statusCode = response.statusCode;
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      Map<String, dynamic> user = jsonDecode(responseString);
      var dataResponse = BasicResponseModel.fromJson(user);

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

  Widget photoSection() {
    double totalWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        selectedFile.isNotEmpty
            ? SizedBox(
                height: 200,
                width: totalWidth,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: selectedFile.startsWith("https") ?
                  FadeInImage.assetNetwork(
                    image: "${selectedFile.toString().trim()}&w=600",
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/bg_gray.jpeg',
                  ) : Image.file(
                    File(selectedFile),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                height: 200,
                width: totalWidth,
                decoration: BoxDecoration(color: Colors.grey[400], borderRadius: const BorderRadius.all(Radius.circular(12))),
              ),
        Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                pickImage();
              },
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 7, top: 7),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)), color: Colors.white, border: Border.all(color: themePink)),
                child: const Center(child: Text('Edit Photo', style: TextStyle(color: themePink, fontWeight: FontWeight.bold, fontSize: 12))),
              ),
            ))
      ],
    );
  }

  Widget selectTypeSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText('Select Type'),
          const SizedBox(height: 20),
          SizedBox(
              height: 42,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    String type = types[index].name!;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedType = type;
                        });
                      },
                      child: Container(
                        // padding: const EdgeInsets.only(left: 16,right: 16),
                        width: 80,
                        decoration: BoxDecoration(
                            color: _selectedType == type ? themePink : const Color(0xffFFD9EB),
                            borderRadius: const BorderRadius.all(Radius.circular(12))),
                        child: Center(child: Text(type, style: TextStyle(fontSize: 15, color: _selectedType == type ? Colors.white : themePink))),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemCount: types.length)),
        ],
      ),
    );
  }

  Widget titleSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText('Title'),
              const Gap(16),
              TextField(
                cursorColor: editTextColor,
                controller: _titleController,
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
                      borderRadius: BorderRadius.circular(kButtonCornerRadius), borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kButtonCornerRadius), borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
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

  Widget descriptionSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText('Description'),
              const Gap(16),
              TextField(
                  cursorColor: editTextColor,
                  controller: _descController,
                  keyboardType: TextInputType.multiline,
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
                        borderRadius: BorderRadius.circular(kButtonCornerRadius), borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius), borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
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
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget eventDateSelection() {
    return Visibility(
      visible: _selectedType == 'Event',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText('Event Date'),
                const Gap(16),
                TextField(
                  cursorColor: editTextColor,
                  controller: _dateController,
                  keyboardType: TextInputType.text,
                  style: editTextStyleAll(),
                  readOnly: true,
                  onTap: () {
                    _showDatePicker();
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
                        borderRadius: BorderRadius.circular(kButtonCornerRadius), borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius), borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
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
      ),
    );
  }

  Widget eventTimeSelection() {
    return Visibility(
        visible: _selectedType == 'Event',
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText('Event Time'),
                  const Gap(16),
                  TextField(
                    cursorColor: editTextColor,
                    controller: _timeController,
                    keyboardType: TextInputType.text,
                    style: editTextStyleAll(),
                    readOnly: true,
                    onTap: () {
                      _selectTime();
                    },
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          'assets/images/ic_due_time.png',
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
                          borderRadius: BorderRadius.circular(kButtonCornerRadius), borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(kButtonCornerRadius), borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
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
        ));
  }

  Widget selectDepartment() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText('Department'),
              const Gap(16),
              TextField(
                cursorColor: editTextColor,
                controller: _departmentController,
                keyboardType: TextInputType.text,
                style: editTextStyleAll(),
                readOnly: true,
                onTap: () {
                  bottomSheetforDepartment(department);
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
                      borderRadius: BorderRadius.circular(kButtonCornerRadius), borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kButtonCornerRadius), borderSide: const BorderSide(width: 0.5, color: editTextBorder)),
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

  Future<dynamic> bottomSheetforDepartment(List<Department> options) {
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
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: SvgPicture.asset('assets/svgs/close.svg', width: 20, height: 20),
                                  ),
                                ),
                                Expanded(child: Text('Type', textAlign : TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)))
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
                                  valueChanger(options[index].id.toString());
                                  _departmentController.text = toDisplayCase(checkValidString(options[index].name));
                                  Navigator.pop(context);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    toDisplayCase(checkValidString(options[index].name)),
                                    style: TextStyle(
                                        color: _selectedDepartment == options[index].id.toString().trim() ? themePink : const Color(0xff666666),
                                        fontSize: 18),
                                  ),
                                  _selectedDepartment == options[index].id.toString().trim()
                                      ? const Icon(Icons.circle, size: 10, color: themePink)
                                      : const SizedBox()
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

  Widget rsvpSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleText('RSVP Required?'),
          CupertinoSwitch(
            value: _switchValue,
            activeColor: themePink,
            onChanged: (bool value) {
              setState(() {
                _switchValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker() async {
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
        initialDate: _dateController.text.toString().trim().isNotEmpty
            ? DateFormat('dd MMM, yyyy').parse(_dateController.text.toString().trim())
            : DateTime.now());

    if (result != null) {
      String startDateFormat = DateFormat('dd MMM, yyyy').format(result);
      print("<><> SHOW DATE ::: $startDateFormat <><>");
      if (startDateFormat.isNotEmpty) {
        setState(() {
          _dateController.text = startDateFormat;
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
        _timeController.text = time;
      });
    }

    return time;
  }

  @override
  void castStatefulWidget() {
    // TODO: implement castStatefulWidget
  }
}
