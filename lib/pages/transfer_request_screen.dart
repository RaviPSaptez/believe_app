import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/colors.dart';
import '../data/model/transfer_request_model.dart';
import '../utils/app_utils.dart';

class TranferRequestScreen extends StatefulWidget {
  const TranferRequestScreen({super.key});

  @override
  State<TranferRequestScreen> createState() => _TranferRequestScreenState();
}

class _TranferRequestScreenState extends State<TranferRequestScreen> {
  List<TransferReqType> reqTypes = [];
  List<CompaniesList> companies = [];
  List<Department> departments = [];
  String _selectedType = 'Temporary';
  String _selectedCompany = 'Believe International';
  String _selectedDepartment = 'Accountant';
  final TextEditingController descTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD11A22),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 22, right: 22),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 15,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12)),
                    color: Color(0xffFF333C)),
              ),
            ),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      header(),
                      Expanded(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(18),
                          children: [
                            userInfoBox(),
                            heading('Request Type'),
                            requestTypeSection(),
                            heading('Transfer to company'),
                            companiesList(),
                            heading('Department'),
                            departmentList(),
                            heading('Description'),
                            description()
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

  void valueSetterforCompany(String value){
    setState(() {
      _selectedCompany = value;
    });
  }

  void valueSetterforDep(String value){
    setState(() {
      _selectedDepartment = value;
    });
  }

  @override
  void initState() {
    reqTypes = [
      TransferReqType(name: 'Temporary', id: 1),
      TransferReqType(name: 'Permanent', id: 2)
    ];
    companies = [
      CompaniesList(name: 'Believe International', id: 1),
      CompaniesList(name: 'Wellness', id: 2),
      CompaniesList(name: 'Mars Remedies', id: 3),
      CompaniesList(name: 'Beatle Pharma', id: 4)
    ];
    departments = [
      Department(name: 'Accountant', id: 1),
      Department(name: 'Factory', id: 2),
      Department(name: 'Board', id: 3),
      Department(name: 'Sales', id: 4),
      Department(name: 'IT', id: 5)
    ];
    super.initState();
  }

  Widget heading(String heading){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: Text(heading, style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
    );
  }

  Widget userInfoBox(){
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffEFEFEF),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: const Color(0xff7E7E7E).withOpacity(0.4))
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              child: ClipOval(child: Image.network('https://res.cloudinary.com/demo/image/facebook/65646572251.jpg')),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hiral Vadodariya',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                Text('Beatle Pharma - Healthcare', style: TextStyle(fontSize: 13, color: Color(0xff7C7E88)))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 18),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xffD9D9D9)))),
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
                child: SvgPicture.asset('assets/svgs/close.svg',
                    width: 20, height: 20),
              ),
            ),
            const Row(
              children: [
                SizedBox(width: 12),
                Center(
                    child: Text('Transfer Request',
                        style: TextStyle(
                            color: Color(0xffFF333C),
                            fontSize: 20,
                            fontWeight: FontWeight.w900))),
              ],
            ),
            const Text('Save', style: TextStyle(fontSize: 20))
          ],
        ));
  }

  Widget requestTypeSection(){
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String name = reqTypes[index].name!;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedType = name;
            });
          },
          child: Container(
            padding: const EdgeInsets.only(right: 20,left: 20),
            decoration: BoxDecoration(
              color: _selectedType == name ? const Color(0xffFF333C) : const Color(0xffFFEBEC),
              borderRadius: const BorderRadius.all(Radius.circular(12))
            ),
            child: Center(child: Text(name,style: TextStyle(color: _selectedType == name ? Colors.white : const Color(0xffFF333C)))),
          ),
        );
      }, separatorBuilder: (context, index) => const SizedBox(width: 10), itemCount: reqTypes.length),
    );
  }

  Widget companiesList(){
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: const Color(0xff666666))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            sheetForCompanies(companies);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_selectedCompany,
                  style: const TextStyle(color: Color(0xff666666))),
              Padding(
                padding: const EdgeInsets.only(bottom: 21, top: 21),
                child: SvgPicture.asset('assets/svgs/downArrow.svg',
                    height: 25, width: 25),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<dynamic> sheetForCompanies(List options) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          String tempSelectedCompany = _selectedCompany;
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffD9D9D9), width: 1.5))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tempSelectedCompany = _selectedType;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SvgPicture.asset(
                                            'assets/svgs/close.svg',
                                            width: 20,
                                            height: 20),
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 25),
                                          child: Center(
                                              child: Text('Company',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight
                                                          .w900))),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          valueSetterforCompany(tempSelectedCompany);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Apply',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffFF333C))))
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
                                String data = options[index].name;
                                return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      tempSelectedCompany = data;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data,
                                        style: TextStyle(
                                            color: tempSelectedCompany == data
                                                ? const Color(0xffFF333C)
                                                : const Color(0xff666666),
                                            fontSize: 18),
                                      ),
                                      tempSelectedCompany == data
                                          ? const Icon(Icons.circle,
                                          size: 10,
                                          color: Color(0xffFF333C))
                                          : const SizedBox()
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                              const SizedBox(height: 22),
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

  Widget departmentList(){
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: const Color(0xff666666))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            sheetForDepartment(departments);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_selectedDepartment,
                  style: const TextStyle(color: Color(0xff666666))),
              Padding(
                padding: const EdgeInsets.only(bottom: 21, top: 21),
                child: SvgPicture.asset('assets/svgs/downArrow.svg',
                    height: 25, width: 25),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<dynamic> sheetForDepartment(List options) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Builder(builder: (context) {
          String tempSelectedDepartment = _selectedDepartment;
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(15))),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xffD9D9D9), width: 1.5))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          tempSelectedDepartment = _selectedDepartment;
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: SvgPicture.asset(
                                            'assets/svgs/close.svg',
                                            width: 20,
                                            height: 20),
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 25),
                                          child: Center(
                                              child: Text('Departments',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight
                                                          .w900))),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          valueSetterforDep(tempSelectedDepartment);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Apply',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xffFF333C))))
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
                                String data = options[index].name;
                                return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      tempSelectedDepartment = data;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data,
                                        style: TextStyle(
                                            color: tempSelectedDepartment == data
                                                ? const Color(0xffFF333C)
                                                : const Color(0xff666666),
                                            fontSize: 18),
                                      ),
                                      tempSelectedDepartment == data
                                          ? const Icon(Icons.circle,
                                          size: 10,
                                          color: Color(0xffFF333C))
                                          : const SizedBox()
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                              const SizedBox(height: 22),
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

  Widget description(){
    return TextField(
        cursorColor: editTextColor,
        controller: descTextController,
        keyboardType: TextInputType.text,
        style: editTextStyleAll(),
        maxLines: 6,
        minLines: 4,
        decoration: InputDecoration(
          fillColor: white,
          contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kButtonCornerRadius),
              borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: editTextBorder)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kButtonCornerRadius),
              borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: editTextBorder)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kButtonCornerRadius),
              borderSide: const BorderSide(width: 1, color: editTextBorder)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kButtonCornerRadius),
              borderSide: const BorderSide(width: 1, color: editTextBorder)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kButtonCornerRadius),
              borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: editTextBorder)),
          labelStyle: const TextStyle(
            color: editTextColor,
            fontSize: 16,
            fontFamily: otherFont,
            fontWeight: FontWeight.w500,
          ),
          hintText: 'Enter Description',
          hintStyle:
          const TextStyle(color: editTextColor, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
        )
    );
  }
}
