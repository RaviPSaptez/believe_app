import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:loop_page_view/loop_page_view.dart';

import '../constant/colors.dart';
import '../data/model/birthday_model.dart';
import '../data/staticdata.dart';
import '../utils/app_utils.dart';

class BirthDayScreen extends StatefulWidget {
  const BirthDayScreen({super.key});

  @override
  State<BirthDayScreen> createState() => _BirthDayScreenState();
}

class _BirthDayScreenState extends State<BirthDayScreen> {
  int currentIndex = 0;
  List<BirthDayMonths> listofmonths = [];
  int _selectedMonthId = 1;

  @override
  void initState() {
    listofmonths = [
      BirthDayMonths(name:'This Week', id:1),
      BirthDayMonths(name:'This Month', id:2),
      BirthDayMonths(name:'Jan', id:3),
      BirthDayMonths(name:'Feb', id:4),
      BirthDayMonths(name:'Mar', id:5),
      BirthDayMonths(name:'Apr', id:6),
      BirthDayMonths(name:'May', id:7),
      BirthDayMonths(name:'Jun', id:8),
      BirthDayMonths(name:'Jul', id:9),
      BirthDayMonths(name:'Aug', id:10),
      BirthDayMonths(name:'Sep', id:11),
      BirthDayMonths(name:'Oct', id:12),
      BirthDayMonths(name:'Nov', id:13),
      BirthDayMonths(name:'Dec', id:14)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD31CAD),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            appBar(),
            const SizedBox(height: 20),
            searchBar(),
            const SizedBox(height: 20),
            birthdaySection(),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 55,
              width: 55,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Color(0xffFF42D7)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset('assets/svgs/backWhite.svg',
                    height: 20, width: 20),
              ),
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text('Birthdays',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Recoleta',
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
          ),
        ],
      ),
    );
  }
 
  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
              child: SizedBox(
                height: 44,
                child: TextField(
                  cursorColor: white,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {

                  },
                  style: editTextStyleWhite(),
                  onChanged: (value) {

                  },
                  decoration: InputDecoration(
                    fillColor: const Color(0xffFF42D7),
                    contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                        borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: Color(0xffFF42D7))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                        borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: Color(0xffFF42D7))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius12), borderSide: const BorderSide(width: 0.5, color: Color(0xffFF42D7))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius12), borderSide: const BorderSide(width: 0.5, color: Color(0xffFF42D7))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(kButtonCornerRadius12),
                        borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: Color(0xffFF42D7))),
                    hintText: 'Search...',
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
                    hintStyle: const TextStyle(color: white, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
                  ),
                ),
              )),
          const Gap(12),
          GestureDetector(
            onTap: () {
            },
            child: Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: Color(0xffFF42D7)),
                height: 42,
                width: 42,
                padding: const EdgeInsets.all(13),
                child: Image.asset('assets/images/ic_add.png', height: 28, width: 28)),
          ),
        ],
      ),
    );
  }


  Widget birthdaySection(){
    return Expanded(
      child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14), topRight: Radius.circular(14))),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading('Today\'s Birthdays'),
              todayBirthdaySlider(),
              heading('Upcoming Birthdays'),
              upcomingBirthDaySection()
            ],
          ),
        ),
    ));
  }

  Widget heading(String heading){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 25),
      child: Text(heading, style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
    );
  }
  
  
  Widget todayBirthdaySlider(){
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 300,
              child: LoopPageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                itemBuilder: (context, index) {
                return todayBirthdayCard(TodayBirthday.todaybirthdays[index].name.toString(), TodayBirthday.todaybirthdays[index].profileImg.toString());
              }, itemCount: TodayBirthday.todaybirthdays.length),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 20,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int i = 0; i < TodayBirthday.todaybirthdays.length; i++)
                  if (currentIndex == i)
                    bannerIndicator(true)
                  else
                    bannerIndicator(false)
              ]),
            ),
          ],
        ),
        Positioned(
            top: 80,
            left: -10,
            child: Image.asset('assets/images/firework.png',height: 100,width: 100)),
        Positioned(
            top: 80,
            right: -10,
            child: Transform.flip(
              flipX: true,
             child: Image.asset('assets/images/firework.png',height: 100,width: 100)),
         ),
      ],
    );
  }

  Widget bannerIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: isActive ? 12 : 6,
      width: isActive ? 12 : 6,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xffD31CAD) : const Color(0xffD31CAD).withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Widget todayBirthdayCard(String name, String imgPath){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              // begin: Alignment.topRight,
              // end: Alignment.bottomLeft,
                begin: Alignment(0.5, -0.4),
                end: Alignment(-0.8, 1),
                colors: [
                  Color(0xffE4D9F0), Color(0xffBFDCFC),
                ]),
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CircleAvatar(
                radius: 55,
                child: ClipOval(
                    child: Image.network(imgPath,fit: BoxFit.cover)),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15, fontFamily: 'Recoleta')),
            ),
            const Text('Happy Birthday', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26, fontFamily: 'Recoleta')),
            Image.asset('assets/images/cakeImage.png',height: 65,width: 65)
          ],
        ),
      ),
    );
  }

  Widget upcomingBirthDaySection(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          monthsList(),
          listOfPeople()
        ],
      ),
    );
  }

  Widget monthsList(){
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 20,right: 20),
        scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
          String monthName = listofmonths[index].name!;
          int monthId = listofmonths[index].id!;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMonthId = monthId;
                });
              },
              child: Container(
                padding: const EdgeInsets.only(right: 18, left: 18),
                decoration: BoxDecoration(
                  color: _selectedMonthId == monthId ? const Color(0xffFF42D7) : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: const Color(0xffFF42D7))
                ),
                child: Center(child: Text(monthName,style: TextStyle(color: _selectedMonthId == monthId ? Colors.white : const Color(0xffFF42D7)))),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 8), itemCount: listofmonths.length),
    );
  }

  Widget listOfPeople(){
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff7E7E7E).withOpacity(0.5)),
          borderRadius: const BorderRadius.all(Radius.circular(12))
        ),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            String name = BirthdayPeople.peopleList[index].name!;
            String birthDate = BirthdayPeople.peopleList[index].birthDate!;
            String imgPath = BirthdayPeople.peopleList[index].profileImg!;
          return Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  child: ClipOval(child: Image.network(imgPath)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                    Text(birthDate, style: const TextStyle(fontSize: 13, color: Color(0xff7C7E88)))
                  ],
                )
              ],
            ),
          );
        }, separatorBuilder: (context, index) => const Divider(), itemCount: BirthdayPeople.peopleList.length),
      ),
    );
  }
}
