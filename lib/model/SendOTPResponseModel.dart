import 'dart:convert';
/// success : 1
/// message : "OTP is sent to your registered mobile number."
/// user_id : "2"

SendOtpResponseModel sendOtpResponseModelFromJson(String str) => SendOtpResponseModel.fromJson(json.decode(str));
String sendOtpResponseModelToJson(SendOtpResponseModel data) => json.encode(data.toJson());
class SendOtpResponseModel {
  SendOtpResponseModel({
      num? success, 
      String? message, 
      String? userId,}){
    _success = success;
    _message = message;
    _userId = userId;
}

  SendOtpResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _userId = json['user_id'];
  }
  num? _success;
  String? _message;
  String? _userId;
SendOtpResponseModel copyWith({  num? success,
  String? message,
  String? userId,
}) => SendOtpResponseModel(  success: success ?? _success,
  message: message ?? _message,
  userId: userId ?? _userId,
);
  num? get success => _success;
  String? get message => _message;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['user_id'] = _userId;
    return map;
  }

}