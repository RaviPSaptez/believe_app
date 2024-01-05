/// data : [{"id":"1","name":"Casual"},{"id":"4","name":"Marriage"},{"id":"3","name":"Maternity"},{"id":"5","name":"Paternity"},{"id":"2","name":"Sick"},{"id":"6","name":"Travelling"}]
/// success : 1
/// message : "Records found."

class LeaveTypes {
  LeaveTypes({
      List<LeaveTypeData>? data, 
      num? success, 
      String? message,}){
    _data = data;
    _success = success;
    _message = message;
}

  LeaveTypes.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LeaveTypeData.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<LeaveTypeData>? _data;
  num? _success;
  String? _message;
LeaveTypes copyWith({  List<LeaveTypeData>? data,
  num? success,
  String? message,
}) => LeaveTypes(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
);
  List<LeaveTypeData>? get data => _data;
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
/// name : "Casual"

class LeaveTypeData {
  LeaveTypeData({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  LeaveTypeData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
LeaveTypeData copyWith({  String? id,
  String? name,
}) => LeaveTypeData(  id: id ?? _id,
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