import 'dart:convert';

import 'package:believe_app/utils/app_utils.dart';
import 'package:believe_app/utils/session_manager_new.dart';

import '../model/login/VerifyOtpResponseModel.dart';

class SessionManager {
  final String isLoggedIn = "isLoggedIn";
  final String id = "id";
  final String departmentId = "department_id";
  final String department = "department";
  final String designationId = "designation_id";
  final String designation = "designation";
  final String name = "name";
  final String emailAddress = "email_address";
  final String contactNo = "contact_no";
  final String isActive = "is_active";
  final String deviceToken = "deviceToken";
  final String accessToken = "access_token";
  final String profilePic = "profilePic";
  final String hodLogin = "hod_login";
  final String permissions = "user_permissions";

  Future createLoginSession(Data? data) async {
    await SessionManagerNew.setBool(isLoggedIn, true);
    await SessionManagerNew.setString(id, checkValidString(data?.id));
    await SessionManagerNew.setString(departmentId, checkValidString(data?.departmentId));
    await SessionManagerNew.setString(department, checkValidString(data?.department));
    await SessionManagerNew.setString(designationId, checkValidString(data?.designationId));
    await SessionManagerNew.setString(designation, checkValidString(data?.designation));
    await SessionManagerNew.setString(name, checkValidString(data?.name));
    await SessionManagerNew.setString(emailAddress, checkValidString(data?.emailAddress));
    await SessionManagerNew.setString(contactNo, checkValidString(data?.contactNo));
    await SessionManagerNew.setString(isActive, checkValidString(data?.isActive));
    await SessionManagerNew.setString(hodLogin, checkValidString(data?.hod));
    await SessionManagerNew.setString(profilePic, checkValidString(data?.profilePicFull));
  }

  Future<void> setIsLoggedIn(bool isLoginIn)
  async {
    await SessionManagerNew.setBool(isLoggedIn, isLoginIn);
  }

  String? getDepartment() {
    return SessionManagerNew.getString(department);
  }

  String? getDesignation() {
    return SessionManagerNew.getString(designation);
  }

  bool? checkIsLoggedIn() {
    return SessionManagerNew.getBool(isLoggedIn);
  }

  Future<void> setDeviceToken(String apiDeviceToken)
  async {
    await SessionManagerNew.setString(deviceToken, apiDeviceToken);
  }

  String? getDeviceToken() {
    return SessionManagerNew.getString(deviceToken);
  }

  String? getId() {
    return SessionManagerNew.getString(id);
  }

  String? getProfilePic() {
    return SessionManagerNew.getString(profilePic);
  }

  String? getName() {
    return SessionManagerNew.getString(name);
  }

  String? getEmail() {
    return SessionManagerNew.getString(emailAddress);
  }

  String? getContactNo() {
    return SessionManagerNew.getString(contactNo);
  }

  String? getIsHOD() {
    return SessionManagerNew.getString(hodLogin);
  }

  Future<void> setPermissions(List<ModuleRights> listItems) async {
    var json = jsonEncode(listItems);
    await SessionManagerNew.setString(permissions, json);
  }

  List<ModuleRights> getPermissions() {
    List<ModuleRights> listJsonData = List<ModuleRights>.empty(growable: true);
    String jsonString = checkValidString(SessionManagerNew.getString(permissions));
    if (jsonString.isNotEmpty)
    {
      List<dynamic> jsonDataList = jsonDecode(jsonString);
      listJsonData = jsonDataList.map((jsonData) => ModuleRights.fromJson(jsonData)).toList();
    }
    return listJsonData;
  }
}