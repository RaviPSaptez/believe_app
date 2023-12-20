import 'dart:convert';
/// data : [{"id":"1","name":"Full Time"},{"id":"2","name":"First Half"},{"id":"3","name":"Second Half"}]
/// success : 1
/// message : "Records found."

LeaveDurationResponse leaveDurationResponseFromJson(String str) => LeaveDurationResponse.fromJson(json.decode(str));
String leaveDurationResponseToJson(LeaveDurationResponse data) => json.encode(data.toJson());
class LeaveDurationResponse {
  LeaveDurationResponse({
      List<LeaveDurationData>? data, 
      num? success, 
      String? message,}){
    _data = data;
    _success = success;
    _message = message;
}

  LeaveDurationResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LeaveDurationData.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<LeaveDurationData>? _data;
  num? _success;
  String? _message;
LeaveDurationResponse copyWith({  List<LeaveDurationData>? data,
  num? success,
  String? message,
}) => LeaveDurationResponse(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
);
  List<LeaveDurationData>? get data => _data;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// id : "1"
/// name : "Full Time"

LeaveDurationData dataFromJson(String str) => LeaveDurationData.fromJson(json.decode(str));
String dataToJson(LeaveDurationData data) => json.encode(data.toJson());
class LeaveDurationData {
  LeaveDurationData({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  LeaveDurationData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
LeaveDurationData copyWith({  String? id,
  String? name,
}) => LeaveDurationData(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}