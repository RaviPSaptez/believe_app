import 'dart:convert';
/// success : 1
/// message : "Task updated successfully."

BasicResponseModel basicResponseModelFromJson(String str) => BasicResponseModel.fromJson(json.decode(str));
String basicResponseModelToJson(BasicResponseModel data) => json.encode(data.toJson());
class BasicResponseModel {
  BasicResponseModel({
      num? success, 
      String? message,}){
    _success = success;
    _message = message;
}

  BasicResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
  }
  num? _success;
  String? _message;
BasicResponseModel copyWith({  num? success,
  String? message,
}) => BasicResponseModel(  success: success ?? _success,
  message: message ?? _message,
);
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}