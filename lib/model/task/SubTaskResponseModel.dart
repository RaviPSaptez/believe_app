import 'dart:convert';
/// data : [{"user_id_assign":"2","description":"sub task 1","name":"vrushik patel","contact_no":"91 1234567800","department":"Factory","designation":"General Manager"}]

SubTaskResponseModel subTaskResponseModelFromJson(String str) => SubTaskResponseModel.fromJson(json.decode(str));
String subTaskResponseModelToJson(SubTaskResponseModel data) => json.encode(data.toJson());
class SubTaskResponseModel {
  SubTaskResponseModel({
      List<SubTaskData>? data,}){
    _data = data;
}

  SubTaskResponseModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SubTaskData.fromJson(v));
      });
    }
  }
  List<SubTaskData>? _data;
SubTaskResponseModel copyWith({  List<SubTaskData>? data,
}) => SubTaskResponseModel(  data: data ?? _data,
);
  List<SubTaskData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// user_id_assign : "2"
/// description : "sub task 1"
/// name : "vrushik patel"
/// contact_no : "91 1234567800"
/// department : "Factory"
/// designation : "General Manager"

SubTaskData dataFromJson(String str) => SubTaskData.fromJson(json.decode(str));
String dataToJson(SubTaskData data) => json.encode(data.toJson());
class SubTaskData {
  SubTaskData({
      String? userIdAssign, 
      String? description, 
      String? name, 
      String? contactNo, 
      String? department, 
      String? designation,}){
    _userIdAssign = userIdAssign;
    _description = description;
    _name = name;
    _contactNo = contactNo;
    _department = department;
    _designation = designation;
}

  SubTaskData.fromJson(dynamic json) {
    _userIdAssign = json['user_id_assign'];
    _description = json['description'];
    _name = json['name'];
    _contactNo = json['contact_no'];
    _department = json['department'];
    _designation = json['designation'];
  }
  String? _userIdAssign;
  String? _description;
  String? _name;
  String? _contactNo;
  String? _department;
  String? _designation;
SubTaskData copyWith({  String? userIdAssign,
  String? description,
  String? name,
  String? contactNo,
  String? department,
  String? designation,
}) => SubTaskData(  userIdAssign: userIdAssign ?? _userIdAssign,
  description: description ?? _description,
  name: name ?? _name,
  contactNo: contactNo ?? _contactNo,
  department: department ?? _department,
  designation: designation ?? _designation,
);
  String? get userIdAssign => _userIdAssign;
  String? get description => _description;
  String? get name => _name;
  String? get contactNo => _contactNo;
  String? get department => _department;
  String? get designation => _designation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id_assign'] = _userIdAssign;
    map['description'] = _description;
    return map;
  }
}