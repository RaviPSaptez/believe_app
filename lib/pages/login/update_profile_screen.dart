import 'package:believe_app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../constant/colors.dart';
import '../../model/login/profile_models.dart';
import '../../utils/base_class.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends BaseState<UpdateProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _workEmailController = TextEditingController();
  final TextEditingController _workContactController = TextEditingController();
  final TextEditingController _personalEmailController = TextEditingController();
  final TextEditingController _personalContactController = TextEditingController();
  final TextEditingController _roleDescController = TextEditingController();
  final TextEditingController _bioontroller = TextEditingController();
  bool isPersonalInfoVisible = false;
  bool isAdditionalInfoVisible = false;
  bool isPersonalContactVisible = false;
  late Future<DateTime?> selectedBOD;
  String _formattedBOD = '';
  String _dateStampBOD = '';
  late Future<DateTime?> selectedJoiningDate;
  String _formattedJoiningDate = '';
  String _dateStampJoiningDate = '';
  String _selectedExperience = '0 to 3 Years';
  List<WorkExperience> listofexperince = [];

  void valueSetterforExperience(String value) {
    setState(() {
      _selectedExperience = value;
    });
  }

  void personalInfoVisibility() {
    setState(() {
      isPersonalInfoVisible = !isPersonalInfoVisible;
    });
  }

  void additionalInfoVisibility() {
    setState(() {
      isAdditionalInfoVisible = !isAdditionalInfoVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff003531),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 22, right: 22),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 15,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)), color: Color(0xffF78D28)),
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [photoSection(), personalInfoSection(), additionalInfoSection()],
                          ),
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

  @override
  void initState() {
    listofexperince = [
      WorkExperience(id: 1, range: '0 to 3 Years'),
      WorkExperience(id: 1, range: '3 to 6 Years'),
      WorkExperience(id: 1, range: '6 to 10 Years'),
      WorkExperience(id: 1, range: '10+ Years'),
    ];

    _nameController.text = toDisplayCase(checkValidString(sessionManager.getName()));
    _designationController.text = toDisplayCase(checkValidString(sessionManager.getDesignation()));
    _workEmailController.text = checkValidString(sessionManager.getEmail());
    _workContactController.text = toDisplayCase(checkValidString(sessionManager.getContactNo()));
    super.initState();
  }

  @override
  void dispose() {
    _bioontroller.dispose();
    _personalContactController.dispose();
    _personalEmailController.dispose();
    _workEmailController.dispose();
    _workContactController.dispose();
    _designationController.dispose();
    _nameController.dispose();
    _roleDescController.dispose();
    super.dispose();
  }

  Widget personalInfoSection() {
    return Column(
      children: [
        const Divider(color: Color(0xffE9E9E9)),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            personalInfoVisibility();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: isPersonalInfoVisible ? 0 : 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Personal Information', style: TextStyle(fontSize: 18)),
                isPersonalInfoVisible
                    ? Image.asset('assets/images/ic_down_arrow.png', height: 18, width: 18, color: graySemiDark)
                    : Image.asset('assets/images/ic_right_arrow.png', height: 18, width: 18, color: graySemiDark)
              ],
            ),
          ),
        ),
        Visibility(
          visible: isPersonalInfoVisible,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading('Name'),
                textBox(hintText: 'Jinkal Patel', controller: _nameController, isEnabled: false, isReadonly: true),
                heading('Designation'),
                textBox(hintText: 'Accountant', controller: _designationController, isEnabled: false, isReadonly: true),
                heading('Work Email'),
                textBox(hintText: 'jinkal@believeintl.com', controller: _workContactController, isEnabled: false, isReadonly: true),
                heading('Work Contact'),
                textBox(hintText: '+91 9797272747', controller: _workEmailController, isEnabled: false, isReadonly: true)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget additionalInfoSection() {
    return Column(
      children: [
        const Divider(color: Color(0xffE9E9E9)),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            additionalInfoVisibility();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: isAdditionalInfoVisible ? 0 : 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Additional Information', style: TextStyle(fontSize: 18)),
                isAdditionalInfoVisible
                    ? Image.asset('assets/images/ic_down_arrow.png', height: 18, width: 18, color: graySemiDark)
                    : Image.asset('assets/images/ic_right_arrow.png', height: 18, width: 18, color: graySemiDark)
              ],
            ),
          ),
        ),
        Visibility(
          visible: isAdditionalInfoVisible,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading('Personal Email'),
                textBox(hintText: 'jinkal@believeintl.com', controller: _personalEmailController, isEnabled: false, isReadonly: false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    heading('Personal Contact'),
                    CupertinoSwitch(
                      activeColor: const Color(0xffFF5D00),
                      value: isPersonalContactVisible,
                      onChanged: (value) {
                        setState(() {
                          isPersonalContactVisible = value;
                        });
                      },
                    )
                  ],
                ),
                textBox(
                    hintText: '+91 9727272747',
                    controller: _personalContactController,
                    isEnabled: true,
                    addText: 'This will allow you to make your personal contact number private or public.',
                    isReadonly: false),
                heading('Date of Birth'),
                boxForBODDate(),
                heading('Work Experience'),
                workExperienceDropDown(),
                heading('Date of Joining'),
                boxForJoiningDate(),
                heading('Role Description'),
                bigTextBox('Job Role, Responsibilities & objectives.', _roleDescController),
                heading('Bio'),
                bigTextBox('A brief description of the employee\'s background, skills, or interests.', _bioontroller)
              ],
            ),
          ),
        )
      ],
    );
  }

  void datePickerforBOD() {
    DateTime now = DateTime.now();
    selectedBOD = showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xffFF5D00),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: now,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    selectedBOD.then((value) {
      if (value != null) {
        setState(() {
          _formattedBOD = DateFormat('d MMM, EEEE').format(value);
          double tempStamp = value.millisecondsSinceEpoch / 1000;
          _dateStampBOD = tempStamp.toString();
        });
      }
    });
  }

  void datePickerforJoiningDate() {
    DateTime now = DateTime.now();
    selectedJoiningDate = showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xffFF5D00),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: now,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    selectedJoiningDate.then((value) {
      if (value != null) {
        setState(() {
          _formattedJoiningDate = DateFormat('d MMM, EEEE').format(value);
          double tempStamp = value.millisecondsSinceEpoch / 1000;
          _dateStampJoiningDate = tempStamp.toString();
        });
      }
    });
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
            const Row(
              children: [
                SizedBox(width: 12),
                Center(child: Text('Update Profile', style: TextStyle(color: Color(0xffF78D28), fontSize: 20, fontWeight: FontWeight.w900))),
              ],
            ),
            const Text('Save', style: TextStyle(fontSize: 20))
          ],
        ));
  }

  Widget heading(String heading) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: Text(heading, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget workExperienceDropDown() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(12)), border: Border.all(color: editTextBorder, width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            sheetForWorkExperience(listofexperince);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_selectedExperience, style: const TextStyle(color: Color(0xff666666))),
              Padding(
                padding: const EdgeInsets.only(bottom: 21, top: 21),
                child: SvgPicture.asset('assets/svgs/downArrow.svg', height: 25, width: 25),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> sheetForWorkExperience(List options) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          String tempSelectedExperience = _selectedExperience;
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
                                    setState(() {
                                      tempSelectedExperience = _selectedExperience;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: SvgPicture.asset('assets/svgs/close.svg', width: 20, height: 20),
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Center(child: Text('Company', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () {
                                      valueSetterforExperience(tempSelectedExperience);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Apply', style: TextStyle(fontSize: 20, color: Color(0xffFF333C))))
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
                            String data = options[index].range;
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                setState(() {
                                  tempSelectedExperience = data;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data,
                                    style: TextStyle(color: tempSelectedExperience == data ? const Color(0xffFF333C) : editTextBorder, fontSize: 18),
                                  ),
                                  tempSelectedExperience == data ? const Icon(Icons.circle, size: 10, color: Color(0xffFF333C)) : const SizedBox()
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

  Widget boxForBODDate() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(12)), border: Border.all(color: editTextBorder, width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            datePickerforBOD();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formattedBOD.isEmpty ? 'Select Date' : _formattedBOD,
                  style: TextStyle(color: _formattedBOD.isEmpty ? editTextBorder.withOpacity(0.5) : const Color(0xff666666))),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 16, right: 12),
                child: Opacity(
                  opacity: 0.7,
                  child: SvgPicture.asset('assets/svgs/date.svg', height: 25, width: 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget boxForJoiningDate() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(12)), border: Border.all(color: editTextBorder, width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            datePickerforJoiningDate();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formattedJoiningDate.isEmpty ? 'Select Date' : _formattedJoiningDate,
                  style: TextStyle(color: _formattedJoiningDate.isEmpty ? editTextBorder.withOpacity(0.5) : const Color(0xff666666))),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 16, right: 12),
                child: Opacity(
                  opacity: 0.7,
                  child: SvgPicture.asset('assets/svgs/date.svg', height: 25, width: 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bigTextBox(String hintText, TextEditingController controller) {
    return TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: 6,
        minLines: 3,
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
        style: const TextStyle(color: Color(0xff666666)));
  }

  Widget textBox(
      {required String hintText, required TextEditingController controller, required bool isEnabled, required bool isReadonly, String? addText}) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Column(
          children: [
            TextField(
                cursorColor: editTextColor,
                controller: controller,
                readOnly: isReadonly,
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
                style: const TextStyle(color: Color(0xff666666))),
            isEnabled
                ? Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(addText!, style: const TextStyle(fontSize: 8)),
                  )
                : const SizedBox()
          ],
        ));
  }

  Widget photoSection() {
    double size = 170;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: orange,
                  width: 1,
                )),
            child: ClipOval(
                child: checkValidString(sessionManager.getProfilePic()).toString().isNotEmpty
                    ? Image.network(fit: BoxFit.cover, checkValidString(sessionManager.getProfilePic()).toString())
                    : Image.asset('assets/images/placeholder.jpg')),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            width: size,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)), border: Border.all(color: const Color(0xffFF5D00), width: 1)),
            child: const Center(child: Text('Edit Photo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          ),
        )
      ],
    );
  }

  @override
  void castStatefulWidget() {
    // TODO: implement castStatefulWidget
  }
}
