import 'dart:convert';
/// data : [{"id":"1","name":"Urgent","flag_color":"https://demo1.saptez.com/believeapp/api/assets/priority/1.png","flag_white":"https://demo1.saptez.com/believeapp/api/assets/priority/5.png","color":"#F17771","sort":"1","created_at":"04 Dec, 2023","selected":false}]
/// success : 1
/// message : "Records found."
/// total_records : 4

TaskPriorityListResponse taskPriorityListResponseFromJson(String str) => TaskPriorityListResponse.fromJson(json.decode(str));
String taskPriorityListResponseToJson(TaskPriorityListResponse data) => json.encode(data.toJson());
class TaskPriorityListResponse {
  TaskPriorityListResponse({
      List<TaskPriorityData>? data, 
      num? success, 
      String? message, 
      num? totalRecords,}){
    _data = data;
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
}

  TaskPriorityListResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaskPriorityData.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
  }
  List<TaskPriorityData>? _data;
  num? _success;
  String? _message;
  num? _totalRecords;
TaskPriorityListResponse copyWith({  List<TaskPriorityData>? data,
  num? success,
  String? message,
  num? totalRecords,
}) => TaskPriorityListResponse(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
);
  List<TaskPriorityData>? get data => _data;
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
/// name : "Urgent"
/// flag_color : "https://demo1.saptez.com/believeapp/api/assets/priority/1.png"
/// flag_white : "https://demo1.saptez.com/believeapp/api/assets/priority/5.png"
/// color : "#F17771"
/// sort : "1"
/// created_at : "04 Dec, 2023"
/// selected : false

TaskPriorityData dataFromJson(String str) => TaskPriorityData.fromJson(json.decode(str));
String dataToJson(TaskPriorityData data) => json.encode(data.toJson());
class TaskPriorityData {
  TaskPriorityData({
      String? id, 
      String? name, 
      String? flagColor, 
      String? flagWhite, 
      String? color, 
      String? sort, 
      String? createdAt, 
      bool? selected,}){
    _id = id;
    _name = name;
    _flagColor = flagColor;
    _flagWhite = flagWhite;
    _color = color;
    _sort = sort;
    _createdAt = createdAt;
    _selected = selected;
}

  TaskPriorityData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _flagColor = json['flag_color'];
    _flagWhite = json['flag_white'];
    _color = json['color'];
    _sort = json['sort'];
    _createdAt = json['created_at'];
    _selected = json['selected'];
  }
  String? _id;
  String? _name;
  String? _flagColor;
  String? _flagWhite;
  String? _color;
  String? _sort;
  String? _createdAt;
  bool? _selected;
TaskPriorityData copyWith({  String? id,
  String? name,
  String? flagColor,
  String? flagWhite,
  String? color,
  String? sort,
  String? createdAt,
  bool? selected,
}) => TaskPriorityData(  id: id ?? _id,
  name: name ?? _name,
  flagColor: flagColor ?? _flagColor,
  flagWhite: flagWhite ?? _flagWhite,
  color: color ?? _color,
  sort: sort ?? _sort,
  createdAt: createdAt ?? _createdAt,
  selected: selected ?? _selected,
);
  String? get id => _id;
  String? get name => _name;
  String? get flagColor => _flagColor;
  String? get flagWhite => _flagWhite;
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
    map['flag_color'] = _flagColor;
    map['flag_white'] = _flagWhite;
    map['color'] = _color;
    map['sort'] = _sort;
    map['created_at'] = _createdAt;
    map['selected'] = _selected;
    return map;
  }

}