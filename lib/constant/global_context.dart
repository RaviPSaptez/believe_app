import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> navigatorKeyHome = GlobalKey<NavigatorState>();
  static String notif_type = "";
  static List<String> genderList = ["Male" , "Female",];
}