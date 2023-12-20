import 'dart:convert';
/// data : [{"id":"2","name":"vrushik patel","profile_pic_full":"https://demo1.saptez.com/believeapp/api/image-tool/index.php?src=https://demo1.saptez.com/believeapp/api/assets/user_dummy.jpg","contact_no":"91 1234567892","department":"Factory","designation":"General Manager","selected":false},{"id":"3","name":"vrushik patel","profile_pic_full":"https://demo1.saptez.com/believeapp/api/image-tool/index.php?src=https://demo1.saptez.com/believeapp/api/assets/user_dummy.jpg","contact_no":"91 1234567800","department":"Factory","designation":"General Manager","selected":false}]
/// success : 1
/// message : "Records found."
/// total_records : 2

DepartmentWiseUserResponse departmentWiseUserResponseFromJson(String str) => DepartmentWiseUserResponse.fromJson(json.decode(str));
String departmentWiseUserResponseToJson(DepartmentWiseUserResponse data) => json.encode(data.toJson());
class DepartmentWiseUserResponse {
  DepartmentWiseUserResponse({
      List<DepartmentWiseUserList>? data, 
      num? success, 
      String? message, 
      num? totalRecords,}){
    _data = data;
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
}

  DepartmentWiseUserResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DepartmentWiseUserList.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
  }
  List<DepartmentWiseUserList>? _data;
  num? _success;
  String? _message;
  num? _totalRecords;
DepartmentWiseUserResponse copyWith({  List<DepartmentWiseUserList>? data,
  num? success,
  String? message,
  num? totalRecords,
}) => DepartmentWiseUserResponse(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
);
  List<DepartmentWiseUserList>? get data => _data;
  num? get success => _success;
  String? get message => _message;
  num? get totalRecords => _totalRecords;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    map['total_records'] = _totalRecords;
    return map;
  }

}

/// id : "2"
/// name : "vrushik patel"
/// profile_pic_full : "https://demo1.saptez.com/believeapp/api/image-tool/index.php?src=https://demo1.saptez.com/believeapp/api/assets/user_dummy.jpg"
/// contact_no : "91 1234567892"
/// department : "Factory"
/// designation : "General Manager"
/// selected : false

DepartmentWiseUserList dataFromJson(String str) => DepartmentWiseUserList.fromJson(json.decode(str));
String dataToJson(DepartmentWiseUserList data) => json.encode(data.toJson());
class DepartmentWiseUserList {
  DepartmentWiseUserList({
      String? id, 
      String? name, 
      String? profilePicFull, 
      String? contactNo, 
      String? department, 
      String? designation, 
      bool? selected,}){
    _id = id;
    _name = name;
    _profilePicFull = profilePicFull;
    _contactNo = contactNo;
    _department = department;
    _designation = designation;
    _selected = selected;
}

  DepartmentWiseUserList.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _profilePicFull = json['profile_pic_full'];
    _contactNo = json['contact_no'];
    _department = json['department'];
    _designation = json['designation'];
    _selected = json['selected'];
  }
  String? _id;
  String? _name;
  String? _profilePicFull;
  String? _contactNo;
  String? _department;
  String? _designation;
  bool? _selected;
DepartmentWiseUserList copyWith({  String? id,
  String? name,
  String? profilePicFull,
  String? contactNo,
  String? department,
  String? designation,
  bool? selected,
}) => DepartmentWiseUserList(  id: id ?? _id,
  name: name ?? _name,
  profilePicFull: profilePicFull ?? _profilePicFull,
  contactNo: contactNo ?? _contactNo,
  department: department ?? _department,
  designation: designation ?? _designation,
  selected: selected ?? _selected,
);
  String? get id => _id;
  String? get name => _name;
  String? get profilePicFull => _profilePicFull;
  String? get contactNo => _contactNo;
  String? get department => _department;
  String? get designation => _designation;
  bool? get selected => _selected;


  set selected(bool? value) {
    _selected = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['profile_pic_full'] = _profilePicFull;
    map['contact_no'] = _contactNo;
    map['department'] = _department;
    map['designation'] = _designation;
    map['selected'] = _selected;
    return map;
  }

}