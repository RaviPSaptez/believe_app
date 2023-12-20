// import 'package:believe_intl/my_leaves_screen.dart';
import 'package:believe_app/pages/blank_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/apply_leave.dart';
import '../pages/birthdays_screen.dart';
import '../pages/blank_page_new.dart';
import '../pages/dashboard.dart';
import '../pages/event_and_news_screen.dart';
import '../pages/login/update_profile_screen.dart';
import '../pages/my_leave_screen.dart';
import '../pages/storage_screen.dart';
import '../pages/task/my_task_list_screen.dart';
import '../pages/transfer_request_screen.dart';



class BirthdayPeople{
  String? name;
  String? birthDate;
  String? profileImg;

  BirthdayPeople({this.name, this.profileImg, this.birthDate});

  static List<BirthdayPeople> peopleList = [
    BirthdayPeople(
        name: 'Jinkal Patel',
        birthDate: '21 Dec',
        profileImg: 'https://res.cloudinary.com/demo/image/facebook/65646572251.jpg'
    ),
    BirthdayPeople(
        name: 'Hiral Vadodariya',
        birthDate: '23 Dec',
        profileImg: 'https://media.licdn.com/dms/image/C4D03AQF_uDlEmOWr9Q/profile-displayphoto-shrink_800_800/0/1609942027869?e=2147483647&v=beta&t=cmnpoMrhzQv9_7wQnTwDkvKXq8i0SKlxo1Ml4FoTYNU'
    ),
    BirthdayPeople(
        name: 'Amisha Kotadia',
        birthDate: '22 Dec',
        profileImg: 'https://res.cloudinary.com/demo/image/facebook/65646572251.jpg'
    ),
    BirthdayPeople(
        name: 'Jinkal Patel',
        birthDate: '24 Dec',
        profileImg: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiWZb6tHFE9nQ64IIGUnluFlwYfk4D2Rql3ZUBzQ_KwHwvxLY8_Gj1Cr_Kn5Emq_O7dZQ&usqp=CAU'
    ),
  ];
}


class TodayBirthday{
  String? name;
  String? profileImg;

  TodayBirthday({
    this.name,
    this.profileImg
  });


  static List<TodayBirthday> todaybirthdays = [
    TodayBirthday(
        name: 'Raj Vadodariya',
        profileImg: 'https://res.cloudinary.com/demo/image/facebook/65646572251.jpg'
    ),
    TodayBirthday(
        name: 'Vrushik Radadiya',
        profileImg: 'https://media.licdn.com/dms/image/C4D03AQF_uDlEmOWr9Q/profile-displayphoto-shrink_800_800/0/1609942027869?e=2147483647&v=beta&t=cmnpoMrhzQv9_7wQnTwDkvKXq8i0SKlxo1Ml4FoTYNU'
    ),
    TodayBirthday(
        name: 'Maharshi Saparia',
        profileImg: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiWZb6tHFE9nQ64IIGUnluFlwYfk4D2Rql3ZUBzQ_KwHwvxLY8_Gj1Cr_Kn5Emq_O7dZQ&usqp=CAU'
    ),
    TodayBirthday(
        name: 'Jay Patel',
        profileImg: 'https://res.cloudinary.com/demo/image/facebook/65646572251.jpg'
    ),
  ];
}

class DurationLabel{
  String? _name;
  int? _id;

  DurationLabel({String? name, int? id}){
    _name = name;
    _id = id;
  }

  String? get name => _name;
  int? get id => _id;

  set name(String? name){
    _name = name;
  }

  set id(int? id){
    _id = id;
  }
}

class StaticData {
  static List<String> img = [
    'assets/images/1.jpg',
    'assets/images/1.jpg',
    'assets/images/1.jpg',
    'assets/images/1.jpg'
  ];

  // static List<String> leaveTypes = [
  //   'All',
  //   'Causal',
  //   'Sick',
  //   'Maternity',
  //   'Marriage',
  //   'Paternity',
  //   'Travel'
  // ];
  //
  // static List<String> leaveTypesforSheet = [
  //   'Causal',
  //   'Sick',
  //   'Maternity',
  //   'Marriage',
  //   'Paternity',
  //   'Travel'
  // ];
  //
  //
  // static List<String> conditionalforSheet = [
  //   'Is',
  //   'Is Not'
  // ];
  //
  // static List<String> statusOptionsforSheet = [
  //   'Approved',
  //   'Rejected',
  //   'Pending'
  // ];

  static List<String> duration = [
    'Full Time',
    'First Half',
    'Second Half'
  ];
}

class QuickLinks {
  String? name;
  String? svgPath;
  Color? backgroundColor;

  QuickLinks({this.svgPath, this.name, this.backgroundColor});

  static List<QuickLinks> linkdata = [
    QuickLinks(
        name: 'Apply Leave',
        svgPath: 'assets/svgs/ApplyLeave.svg',
        backgroundColor: Colors.purple),
    QuickLinks(
        name: 'Locker',
        svgPath: 'assets/svgs/Locker.svg',
        backgroundColor: Colors.blue),
    QuickLinks(
        name: 'Announcement',
        svgPath: 'assets/svgs/Announcement.svg',
        backgroundColor: Colors.teal),
    QuickLinks(
        name: 'Events',
        svgPath: 'assets/svgs/Events.svg',
        backgroundColor: Colors.pink)
  ];
}

class QuickInfo {
  String? title;
  String? description;
  String? svgPath;
  Color? iconBackgroundColor;
  Widget? screen;

  QuickInfo(
      {this.description,
      this.svgPath,
      this.iconBackgroundColor,
      this.title,
      this.screen});

  static List<QuickInfo> quickInfo = [
    QuickInfo(
        title: 'Profile Information',
        description: 'Work & Personal Informations',
        svgPath: 'assets/svgs/profile.svg',
        iconBackgroundColor: Colors.orange,
        screen: UpdateProfileScreen()
    ),
    QuickInfo(
        title: 'Locker-My Documents',
        description: 'Store all documents at one place',
        svgPath: 'assets/svgs/Locker.svg',
        iconBackgroundColor: Colors.blue,
        screen: StorageScreen()),
    QuickInfo(
        title: 'My Leaves',
        description: 'Apply for leaves from here',
        svgPath: 'assets/svgs/ApplyLeave.svg',
        iconBackgroundColor: Colors.purple[900],
        screen: const LeavesScreen()),
    QuickInfo(
        title: 'My Tasks',
        description: 'Find alloted task here',
        svgPath: 'assets/svgs/tasklist.svg',
        iconBackgroundColor: Colors.blue[700],
        screen: const MyTaskListScreen()),
    QuickInfo(
        title: 'Transfer Application',
        description: 'Track your tranfer application',
        svgPath: 'assets/svgs/EmployeeTransfer.svg',
        iconBackgroundColor: Colors.red[600],
        screen: TranferRequestScreen())
  ];
}

class ActivityData {
  String? title;
  String? description;
  String? svgPath;
  Color? iconBackgroundColor;
  Widget? screen;

  ActivityData(
      {this.description,
      this.svgPath,
      this.iconBackgroundColor,
      this.title,
      this.screen});

  static List<ActivityData> activityInfo = [
    ActivityData(
        title: 'Kudos',
        description: 'Find given/received kudos here',
        svgPath: 'assets/svgs/kudosSVG.svg',
        iconBackgroundColor: Colors.teal,
        screen: BlankPageNew('Kudos')),
    ActivityData(
        title: 'Motivate Quotes',
        description: 'Find Motivational quotes here',
        svgPath: 'assets/svgs/motivateQuotes.svg',
        iconBackgroundColor: Colors.yellow,
        screen: BlankPageNew('Motivate Quotes')),
    ActivityData(
        title: 'Announcement',
        description: 'Believe\'s announcement here',
        svgPath: 'assets/svgs/Announcement.svg',
        iconBackgroundColor: Colors.teal[800],
        screen: BlankPageNew('Announcement')),
    ActivityData(
        title: 'Events',
        description: 'Check Events / Meetings here',
        svgPath: 'assets/svgs/Events.svg',
        iconBackgroundColor: Colors.pink,
        screen: const EventScreen()),
    ActivityData(
        title: 'Birthday Reminders',
        description: 'Find Collegue\'s upcoming birthdays',
        svgPath: 'assets/svgs/birthday.svg',
        iconBackgroundColor: Colors.pink[300],
        screen: BirthDayScreen()),
  ];
}

class AppSettings {
  String? title;
  String? description;
  String? svgPath;
  Color? iconBackgroundColor;
  Widget? screen;

  AppSettings(
      {this.description,
      this.svgPath,
      this.iconBackgroundColor,
      this.title,
      this.screen});

  static List<AppSettings> settings = [
    AppSettings(
        title: 'Settings',
        description: 'Edit your settings',
        svgPath: 'assets/svgs/settings.svg',
        iconBackgroundColor: Colors.orange,
        screen: BlankPageNew('Settings')),
    AppSettings(
        title: 'Notifications',
        description: 'Check your notifications here',
        svgPath: 'assets/svgs/notificationWhite.svg',
        iconBackgroundColor: Colors.teal,
        screen: BlankPageNew('Notifications')),
    AppSettings(
        title: 'Feedback',
        description: 'Tell us what you think',
        svgPath: 'assets/svgs/shareFeedback.svg',
        iconBackgroundColor: Colors.green,
        screen: BlankPageNew('Feedback')),
  ];
}

class OtherSections {
  String? name;
  String? svgPath;
  Color? backgroundColor;

  OtherSections({ this.svgPath, this.name, this.backgroundColor});

  static List<OtherSections> sectionData = [
    OtherSections(
        name: 'Employee Transfer',
        svgPath: 'assets/svgs/EmployeeTransfer.svg',
        backgroundColor: Colors.red),
    OtherSections(
        name: 'Task List',
        svgPath: 'assets/svgs/tasklist.svg',
        backgroundColor: Colors.blue),
    OtherSections(
        name: 'Upcoming Birthday',
        svgPath: 'assets/svgs/birthday.svg',
        backgroundColor: Colors.pink[300]),
    OtherSections(
        name: 'Share Feedback',
        svgPath: 'assets/svgs/shareFeedback.svg',
        backgroundColor: Colors.green)
  ];
}

class MyLeaves {
  String? title;
  String? reason;
  DateTime? from;
  DateTime? to;
  String? status;

  MyLeaves({this.from, this.reason, this.status, this.title, this.to});

  static List<MyLeaves> travelList = [
    MyLeaves(
      title: 'Family Trip',
      reason:
          'Hello Sir, Planning to travel with family in this diwali. Applying for 03 days leave, Request you to please approve my leave.',
      status: 'Approved',
      from: DateTime(2023, 09, 23),
      to: DateTime(2023, 09, 29),
    ),
    MyLeaves(
      title: 'Friend’s Birthday',
      reason:
          'Hello Sir, Planning to travel with family in this diwali. Applying for 03 days leave, Request you to please approve my leave.',
      status: 'Pending',
      from: DateTime(2023, 09, 23),
      to: DateTime(2023, 09, 23),
    ),
    MyLeaves(
      title: 'Cousin’s Wedding',
      reason:
      'Hello Sir, Planning to travel with family in this diwali. Applying for 03 days leave, Request you to please approve my leave.',
      status: 'Rejected',
      from: DateTime(2023, 09, 23),
      to: DateTime(2023, 9, 25),
    )
  ];
}
