import 'dart:convert';
/// data : [{"id":"1","name":"New","color":"#37DDF0","sort":"1","created_at":"04 Dec, 2023","selected":false}]
/// success : 1
/// message : "Records found."
/// total_records : 4

TaskStatusListResponse taskStatusListResponseFromJson(String str) => TaskStatusListResponse.fromJson(json.decode(str));
String taskStatusListResponseToJson(TaskStatusListResponse data) => json.encode(data.toJson());
class TaskStatusListResponse {
  TaskStatusListResponse({
      List<TaskStatusData>? data, 
      num? success, 
      String? message, 
      num? totalRecords,}){
    _data = data;
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
}

  TaskStatusListResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaskStatusData.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
  }
  List<TaskStatusData>? _data;
  num? _success;
  String? _message;
  num? _totalRecords;
TaskStatusListResponse copyWith({  List<TaskStatusData>? data,
  num? success,
  String? message,
  num? totalRecords,
}) => TaskStatusListResponse(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
);
  List<TaskStatusData>? get data => _data;
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
/// name : "New"
/// color : "#37DDF0"
/// sort : "1"
/// created_at : "04 Dec, 2023"
/// selected : false

TaskStatusData dataFromJson(String str) => TaskStatusData.fromJson(json.decode(str));
String dataToJson(TaskStatusData data) => json.encode(data.toJson());
class TaskStatusData {
  TaskStatusData({
      String? id, 
      String? name, 
      String? color, 
      String? sort, 
      String? createdAt, 
      bool? selected,}){
    _id = id;
    _name = name;
    _color = color;
    _sort = sort;
    _createdAt = createdAt;
    _selected = selected;
}

  TaskStatusData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _color = json['color'];
    _sort = json['sort'];
    _createdAt = json['created_at'];
    _selected = json['selected'];
  }
  String? _id;
  String? _name;
  String? _color;
  String? _sort;
  String? _createdAt;
  bool? _selected;
TaskStatusData copyWith({  String? id,
  String? name,
  String? color,
  String? sort,
  String? createdAt,
  bool? selected,
}) => TaskStatusData(  id: id ?? _id,
  name: name ?? _name,
  color: color ?? _color,
  sort: sort ?? _sort,
  createdAt: createdAt ?? _createdAt,
  selected: selected ?? _selected,
);
  String? get id => _id;
  String? get name => _name;
  String? get color => _color;
  String? get sort => _sort;
  String? get createdAt => _createdAt;
  bool? get selected => _selected;


  set selected(bool? value) {
    _selected = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['color'] = _color;
    map['sort'] = _sort;
    map['created_at'] = _createdAt;
    map['selected'] = _selected;
    return map;
  }

}