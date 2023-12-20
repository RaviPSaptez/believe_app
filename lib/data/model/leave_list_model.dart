/// data : [{"id":"2","subject":"Attend marriage","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","leave_days":{"total_day":"1 Day","from_date":"20 Dec, 2023","from_date_timestamp":"1703030400","to_date":"21 Dec, 2023","to_date_timestamp":"1703116800"},"leave_type":{"id":"2","name":"Sick"},"leave_duration":{"id":"2","name":"First Half"},"leave_status":{"id":"1","name":"Pending","color":"#FFB000"},"user_apply":{"user_id":"2","name":"vrushik patel"},"user_approve_by":{"user_id":"","name":""},"created_at_date_time":{"date":"11 Dec, 2023","time":"05:35 PM"}},{"id":"3","subject":"Attend marriage","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","leave_days":{"total_day":"1 Day","from_date":"20 Dec, 2023","from_date_timestamp":"1703034000","to_date":"","to_date_timestamp":""},"leave_type":{"id":"1","name":"Casual"},"leave_duration":{"id":"2","name":"First Half"},"leave_status":{"id":"1","name":"Pending","color":"#FFB000"},"user_apply":{"user_id":"2","name":"vrushik patel"},"user_approve_by":{"user_id":"","name":""},"created_at_date_time":{"date":"11 Dec, 2023","time":"05:35 PM"}},{"id":"1","subject":"Attend marriage","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","leave_days":{"total_day":"3 Days","from_date":"20 Dec, 2023","from_date_timestamp":"1703030400","to_date":"23 Dec, 2023","to_date_timestamp":"1703289600"},"leave_type":{"id":"1","name":"Casual"},"leave_duration":{"id":"1","name":"Full Time"},"leave_status":{"id":"2","name":"Approved","color":"#0C8A00"},"user_apply":{"user_id":"2","name":"vrushik patel"},"user_approve_by":{"user_id":"1","name":"vrushik patel"},"created_at_date_time":{"date":"11 Dec, 2023","time":"05:30 PM"}}]
/// success : 1
/// message : "Records found."
/// total_records : 3

class LeaveListModel {
  LeaveListModel({
      List<LeaveListData>? data, 
      num? success, 
      String? message, 
      num? totalRecords,}){
    _data = data;
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
}

  LeaveListModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LeaveListData.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
  }
  List<LeaveListData>? _data;
  num? _success;
  String? _message;
  num? _totalRecords;
LeaveListModel copyWith({  List<LeaveListData>? data,
  num? success,
  String? message,
  num? totalRecords,
}) => LeaveListModel(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
);
  List<LeaveListData>? get data => _data;
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
/// subject : "Attend marriage"
/// description : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
/// leave_days : {"total_day":"1 Day","from_date":"20 Dec, 2023","from_date_timestamp":"1703030400","to_date":"21 Dec, 2023","to_date_timestamp":"1703116800"}
/// leave_type : {"id":"2","name":"Sick"}
/// leave_duration : {"id":"2","name":"First Half"}
/// leave_status : {"id":"1","name":"Pending","color":"#FFB000"}
/// user_apply : {"user_id":"2","name":"vrushik patel"}
/// user_approve_by : {"user_id":"","name":""}
/// created_at_date_time : {"date":"11 Dec, 2023","time":"05:35 PM"}

class LeaveListData {
  LeaveListData({
    String? id,
    String? subject,
    String? description,
    LeaveDays? leaveDays,
    LeaveType? leaveType,
    LeaveDuration? leaveDuration,
    LeaveStatus? leaveStatus,
    UserApply? userApply,
    UserApproveBy? userApproveBy,
    CreatedAtDateTime? createdAtDateTime,}){
    _id = id;
    _subject = subject;
    _description = description;
    _leaveDays = leaveDays;
    _leaveType = leaveType;
    _leaveDuration = leaveDuration;
    _leaveStatus = leaveStatus;
    _userApply = userApply;
    _userApproveBy = userApproveBy;
    _createdAtDateTime = createdAtDateTime;
  }

  LeaveListData.fromJson(dynamic json) {
    _id = json['id'];
    _subject = json['subject'];
    _description = json['description'];
    _leaveDays = json['leave_days'] != null ? LeaveDays.fromJson(json['leave_days']) : null;
    _leaveType = json['leave_type'] != null ? LeaveType.fromJson(json['leave_type']) : null;
    _leaveDuration = json['leave_duration'] != null ? LeaveDuration.fromJson(json['leave_duration']) : null;
    _leaveStatus = json['leave_status'] != null ? LeaveStatus.fromJson(json['leave_status']) : null;
    _userApply = json['user_apply'] != null ? UserApply.fromJson(json['user_apply']) : null;
    _userApproveBy = json['user_approve_by'] != null ? UserApproveBy.fromJson(json['user_approve_by']) : null;
    _createdAtDateTime = json['created_at_date_time'] != null ? CreatedAtDateTime.fromJson(json['created_at_date_time']) : null;
  }
  String? _id;
  String? _subject;
  String? _description;
  LeaveDays? _leaveDays;
  LeaveType? _leaveType;
  LeaveDuration? _leaveDuration;
  LeaveStatus? _leaveStatus;
  UserApply? _userApply;
  UserApproveBy? _userApproveBy;
  CreatedAtDateTime? _createdAtDateTime;
  LeaveListData copyWith({  String? id,
    String? subject,
    String? description,
    LeaveDays? leaveDays,
    LeaveType? leaveType,
    LeaveDuration? leaveDuration,
    LeaveStatus? leaveStatus,
    UserApply? userApply,
    UserApproveBy? userApproveBy,
    CreatedAtDateTime? createdAtDateTime,
  }) => LeaveListData(  id: id ?? _id,
    subject: subject ?? _subject,
    description: description ?? _description,
    leaveDays: leaveDays ?? _leaveDays,
    leaveType: leaveType ?? _leaveType,
    leaveDuration: leaveDuration ?? _leaveDuration,
    leaveStatus: leaveStatus ?? _leaveStatus,
    userApply: userApply ?? _userApply,
    userApproveBy: userApproveBy ?? _userApproveBy,
    createdAtDateTime: createdAtDateTime ?? _createdAtDateTime,
  );
  String? get id => _id;
  String? get subject => _subject;
  String? get description => _description;
  LeaveDays? get leaveDays => _leaveDays;
  LeaveType? get leaveType => _leaveType;
  LeaveDuration? get leaveDuration => _leaveDuration;
  LeaveStatus? get leaveStatus => _leaveStatus;
  UserApply? get userApply => _userApply;
  UserApproveBy? get userApproveBy => _userApproveBy;
  CreatedAtDateTime? get createdAtDateTime => _createdAtDateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['subject'] = _subject;
    map['description'] = _description;
    if (_leaveDays != null) {
      map['leave_days'] = _leaveDays?.toJson();
    }
    if (_leaveType != null) {
      map['leave_type'] = _leaveType?.toJson();
    }
    if (_leaveDuration != null) {
      map['leave_duration'] = _leaveDuration?.toJson();
    }
    if (_leaveStatus != null) {
      map['leave_status'] = _leaveStatus?.toJson();
    }
    if (_userApply != null) {
      map['user_apply'] = _userApply?.toJson();
    }
    if (_userApproveBy != null) {
      map['user_approve_by'] = _userApproveBy?.toJson();
    }
    if (_createdAtDateTime != null) {
      map['created_at_date_time'] = _createdAtDateTime?.toJson();
    }
    return map;
  }

}

/// date : "11 Dec, 2023"
/// time : "05:35 PM"

class CreatedAtDateTime {
  CreatedAtDateTime({
      String? date, 
      String? time,}){
    _date = date;
    _time = time;
}

  CreatedAtDateTime.fromJson(dynamic json) {
    _date = json['date'];
    _time = json['time'];
  }
  String? _date;
  String? _time;
CreatedAtDateTime copyWith({  String? date,
  String? time,
}) => CreatedAtDateTime(  date: date ?? _date,
  time: time ?? _time,
);
  String? get date => _date;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['time'] = _time;
    return map;
  }

}

/// user_id : ""
/// name : ""

class UserApproveBy {
  UserApproveBy({
      String? userId, 
      String? name,}){
    _userId = userId;
    _name = name;
}

  UserApproveBy.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
  }
  String? _userId;
  String? _name;
UserApproveBy copyWith({  String? userId,
  String? name,
}) => UserApproveBy(  userId: userId ?? _userId,
  name: name ?? _name,
);
  String? get userId => _userId;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    return map;
  }

}

/// user_id : "2"
/// name : "vrushik patel"

class UserApply {
  UserApply({
      String? userId, 
      String? name,}){
    _userId = userId;
    _name = name;
}

  UserApply.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
  }
  String? _userId;
  String? _name;
UserApply copyWith({  String? userId,
  String? name,
}) => UserApply(  userId: userId ?? _userId,
  name: name ?? _name,
);
  String? get userId => _userId;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    return map;
  }

}

/// id : "1"
/// name : "Pending"
/// color : "#FFB000"

class LeaveStatus {
  LeaveStatus({
      String? id, 
      String? name, 
      String? color,}){
    _id = id;
    _name = name;
    _color = color;
}

  LeaveStatus.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _color = json['color'];
  }
  String? _id;
  String? _name;
  String? _color;
LeaveStatus copyWith({  String? id,
  String? name,
  String? color,
}) => LeaveStatus(  id: id ?? _id,
  name: name ?? _name,
  color: color ?? _color,
);
  String? get id => _id;
  String? get name => _name;
  String? get color => _color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['color'] = _color;
    return map;
  }

}

/// id : "2"
/// name : "First Half"

class LeaveDuration {
  LeaveDuration({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  LeaveDuration.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
LeaveDuration copyWith({  String? id,
  String? name,
}) => LeaveDuration(  id: id ?? _id,
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

/// id : "2"
/// name : "Sick"

class LeaveType {
  LeaveType({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  LeaveType.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
LeaveType copyWith({  String? id,
  String? name,
}) => LeaveType(  id: id ?? _id,
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

/// total_day : "1 Day"
/// from_date : "20 Dec, 2023"
/// from_date_timestamp : "1703030400"
/// to_date : "21 Dec, 2023"
/// to_date_timestamp : "1703116800"

class LeaveDays {
  LeaveDays({
      String? totalDay, 
      String? fromDate, 
      String? fromDateTimestamp, 
      String? toDate, 
      String? toDateTimestamp,}){
    _totalDay = totalDay;
    _fromDate = fromDate;
    _fromDateTimestamp = fromDateTimestamp;
    _toDate = toDate;
    _toDateTimestamp = toDateTimestamp;
}

  LeaveDays.fromJson(dynamic json) {
    _totalDay = json['total_day'];
    _fromDate = json['from_date'];
    _fromDateTimestamp = json['from_date_timestamp'];
    _toDate = json['to_date'];
    _toDateTimestamp = json['to_date_timestamp'];
  }
  String? _totalDay;
  String? _fromDate;
  String? _fromDateTimestamp;
  String? _toDate;
  String? _toDateTimestamp;
LeaveDays copyWith({  String? totalDay,
  String? fromDate,
  String? fromDateTimestamp,
  String? toDate,
  String? toDateTimestamp,
}) => LeaveDays(  totalDay: totalDay ?? _totalDay,
  fromDate: fromDate ?? _fromDate,
  fromDateTimestamp: fromDateTimestamp ?? _fromDateTimestamp,
  toDate: toDate ?? _toDate,
  toDateTimestamp: toDateTimestamp ?? _toDateTimestamp,
);
  String? get totalDay => _totalDay;
  String? get fromDate => _fromDate;
  String? get fromDateTimestamp => _fromDateTimestamp;
  String? get toDate => _toDate;
  String? get toDateTimestamp => _toDateTimestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_day'] = _totalDay;
    map['from_date'] = _fromDate;
    map['from_date_timestamp'] = _fromDateTimestamp;
    map['to_date'] = _toDate;
    map['to_date_timestamp'] = _toDateTimestamp;
    return map;
  }

}