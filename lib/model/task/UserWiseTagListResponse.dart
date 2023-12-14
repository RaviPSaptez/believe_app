import 'dart:convert';
/// data : [{"id":"1","name":"web","selected":false}]
/// success : 1
/// message : "Records found."
/// total_records : 5

UserWiseTagListResponse userWiseTagListResponseFromJson(String str) => UserWiseTagListResponse.fromJson(json.decode(str));
String userWiseTagListResponseToJson(UserWiseTagListResponse data) => json.encode(data.toJson());
class UserWiseTagListResponse {
  UserWiseTagListResponse({
      List<UserWiseTagData>? data, 
      num? success, 
      String? message, 
      num? totalRecords,}){
    _data = data;
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
}

  UserWiseTagListResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UserWiseTagData.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
  }
  List<UserWiseTagData>? _data;
  num? _success;
  String? _message;
  num? _totalRecords;
UserWiseTagListResponse copyWith({  List<UserWiseTagData>? data,
  num? success,
  String? message,
  num? totalRecords,
}) => UserWiseTagListResponse(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
);
  List<UserWiseTagData>? get data => _data;
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

/// id : "1"
/// name : "web"
/// selected : false

UserWiseTagData dataFromJson(String str) => UserWiseTagData.fromJson(json.decode(str));
String dataToJson(UserWiseTagData data) => json.encode(data.toJson());
class UserWiseTagData {
  UserWiseTagData({
      String? id, 
      String? name, 
      bool? selected,}){
    _id = id;
    _name = name;
    _selected = selected;
}

  UserWiseTagData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _selected = json['selected'];
  }
  String? _id;
  String? _name;
  bool? _selected;
UserWiseTagData copyWith({  String? id,
  String? name,
  bool? selected,
}) => UserWiseTagData(  id: id ?? _id,
  name: name ?? _name,
  selected: selected ?? _selected,
);
  String? get id => _id;
  String? get name => _name;
  bool? get selected => _selected;


  set selected(bool? value) {
    _selected = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['selected'] = _selected;
    return map;
  }

}