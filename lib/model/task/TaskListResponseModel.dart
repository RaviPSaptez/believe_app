import 'dart:convert';
/// data : [{"id":"2","title":"api for believes","description":"api descriptions","sub_description":"check all right","priority":{"id":"1","name":"Urgent","color":"#F17771","flag":"https://demo1.saptez.com/believeapp/api/assets/priority/1.png"},"status":{"id":"1","name":"New","color":"#37DDF0"},"created_at_date_time":{"date":"08 Dec, 2023","time":"06:47 PM"},"user_assign_to":{"user_id":"2","name":"vrushik patel"},"user_created_task":{"user_id":"1","name":"vrushik patel"},"tags_comma":"web,app,both","tags_array":["web","app","both"]}]
/// success : 1
/// message : "Records found."
/// total_records : 2

TaskListResponseModel taskListResponseModelFromJson(String str) => TaskListResponseModel.fromJson(json.decode(str));
String taskListResponseModelToJson(TaskListResponseModel data) => json.encode(data.toJson());
class TaskListResponseModel {
  TaskListResponseModel({
      List<TaskListData>? data, 
      num? success, 
      String? message, 
      num? totalRecords,}){
    _data = data;
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
}

  TaskListResponseModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaskListData.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
  }
  List<TaskListData>? _data;
  num? _success;
  String? _message;
  num? _totalRecords;
TaskListResponseModel copyWith({  List<TaskListData>? data,
  num? success,
  String? message,
  num? totalRecords,
}) => TaskListResponseModel(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
);
  List<TaskListData>? get data => _data;
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
/// title : "api for believes"
/// description : "api descriptions"
/// sub_description : "check all right"
/// priority : {"id":"1","name":"Urgent","color":"#F17771","flag":"https://demo1.saptez.com/believeapp/api/assets/priority/1.png"}
/// status : {"id":"1","name":"New","color":"#37DDF0"}
/// created_at_date_time : {"date":"08 Dec, 2023","time":"06:47 PM"}
/// user_assign_to : {"user_id":"2","name":"vrushik patel"}
/// user_created_task : {"user_id":"1","name":"vrushik patel"}
/// tags_comma : "web,app,both"
/// tags_array : ["web","app","both"]

TaskListData dataFromJson(String str) => TaskListData.fromJson(json.decode(str));
String dataToJson(TaskListData data) => json.encode(data.toJson());
class TaskListData {
  TaskListData({
      String? id, 
      String? title, 
      String? description, 
      String? subDescription, 
      Priority? priority, 
      Status? status, 
      CreatedAtDateTime? createdAtDateTime, 
      UserAssignTo? userAssignTo, 
      UserCreatedTask? userCreatedTask, 
      String? tagsComma, 
      List<String>? tagsArray,}){
    _id = id;
    _title = title;
    _description = description;
    _subDescription = subDescription;
    _priority = priority;
    _status = status;
    _createdAtDateTime = createdAtDateTime;
    _userAssignTo = userAssignTo;
    _userCreatedTask = userCreatedTask;
    _tagsComma = tagsComma;
    _tagsArray = tagsArray;
}

  TaskListData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _subDescription = json['sub_description'];
    _priority = json['priority'] != null ? Priority.fromJson(json['priority']) : null;
    _status = json['status'] != null ? Status.fromJson(json['status']) : null;
    _createdAtDateTime = json['created_at_date_time'] != null ? CreatedAtDateTime.fromJson(json['created_at_date_time']) : null;
    _userAssignTo = json['user_assign_to'] != null ? UserAssignTo.fromJson(json['user_assign_to']) : null;
    _userCreatedTask = json['user_created_task'] != null ? UserCreatedTask.fromJson(json['user_created_task']) : null;
    _tagsComma = json['tags_comma'];
    _tagsArray = json['tags_array'] != null ? json['tags_array'].cast<String>() : [];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _subDescription;
  Priority? _priority;
  Status? _status;
  CreatedAtDateTime? _createdAtDateTime;
  UserAssignTo? _userAssignTo;
  UserCreatedTask? _userCreatedTask;
  String? _tagsComma;
  List<String>? _tagsArray;
TaskListData copyWith({  String? id,
  String? title,
  String? description,
  String? subDescription,
  Priority? priority,
  Status? status,
  CreatedAtDateTime? createdAtDateTime,
  UserAssignTo? userAssignTo,
  UserCreatedTask? userCreatedTask,
  String? tagsComma,
  List<String>? tagsArray,
}) => TaskListData(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  subDescription: subDescription ?? _subDescription,
  priority: priority ?? _priority,
  status: status ?? _status,
  createdAtDateTime: createdAtDateTime ?? _createdAtDateTime,
  userAssignTo: userAssignTo ?? _userAssignTo,
  userCreatedTask: userCreatedTask ?? _userCreatedTask,
  tagsComma: tagsComma ?? _tagsComma,
  tagsArray: tagsArray ?? _tagsArray,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get subDescription => _subDescription;
  Priority? get priority => _priority;
  Status? get status => _status;
  CreatedAtDateTime? get createdAtDateTime => _createdAtDateTime;
  UserAssignTo? get userAssignTo => _userAssignTo;
  UserCreatedTask? get userCreatedTask => _userCreatedTask;
  String? get tagsComma => _tagsComma;
  List<String>? get tagsArray => _tagsArray;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['sub_description'] = _subDescription;
    if (_priority != null) {
      map['priority'] = _priority?.toJson();
    }
    if (_status != null) {
      map['status'] = _status?.toJson();
    }
    if (_createdAtDateTime != null) {
      map['created_at_date_time'] = _createdAtDateTime?.toJson();
    }
    if (_userAssignTo != null) {
      map['user_assign_to'] = _userAssignTo?.toJson();
    }
    if (_userCreatedTask != null) {
      map['user_created_task'] = _userCreatedTask?.toJson();
    }
    map['tags_comma'] = _tagsComma;
    map['tags_array'] = _tagsArray;
    return map;
  }

}

/// user_id : "1"
/// name : "vrushik patel"

UserCreatedTask userCreatedTaskFromJson(String str) => UserCreatedTask.fromJson(json.decode(str));
String userCreatedTaskToJson(UserCreatedTask data) => json.encode(data.toJson());
class UserCreatedTask {
  UserCreatedTask({
      String? userId, 
      String? name,}){
    _userId = userId;
    _name = name;
}

  UserCreatedTask.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
  }
  String? _userId;
  String? _name;
UserCreatedTask copyWith({  String? userId,
  String? name,
}) => UserCreatedTask(  userId: userId ?? _userId,
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

UserAssignTo userAssignToFromJson(String str) => UserAssignTo.fromJson(json.decode(str));
String userAssignToToJson(UserAssignTo data) => json.encode(data.toJson());
class UserAssignTo {
  UserAssignTo({
      String? userId, 
      String? name,
      String? profilePicFull,
  }){
    _userId = userId;
    _name = name;
    _profilePicFull = profilePicFull;
}

  UserAssignTo.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _profilePicFull = json['profile_pic_full'];
  }
  String? _userId;
  String? _name;
  String? _profilePicFull;
UserAssignTo copyWith({  String? userId,
  String? name,
  String? profilePicFull
}) => UserAssignTo(  userId: userId ?? _userId,
  name: name ?? _name,
    profilePicFull : profilePicFull ?? _profilePicFull
);
  String? get userId => _userId;
  String? get name => _name;
  String? get profilePicFull => _profilePicFull;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['profile_pic_full'] = _profilePicFull;
    return map;
  }

}

/// date : "08 Dec, 2023"
/// time : "06:47 PM"

CreatedAtDateTime createdAtDateTimeFromJson(String str) => CreatedAtDateTime.fromJson(json.decode(str));
String createdAtDateTimeToJson(CreatedAtDateTime data) => json.encode(data.toJson());
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

/// id : "1"
/// name : "New"
/// color : "#37DDF0"

Status statusFromJson(String str) => Status.fromJson(json.decode(str));
String statusToJson(Status data) => json.encode(data.toJson());
class Status {
  Status({
      String? id, 
      String? name, 
      String? color,}){
    _id = id;
    _name = name;
    _color = color;
}

  Status.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _color = json['color'];
  }
  String? _id;
  String? _name;
  String? _color;
Status copyWith({  String? id,
  String? name,
  String? color,
}) => Status(  id: id ?? _id,
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

/// id : "1"
/// name : "Urgent"
/// color : "#F17771"
/// flag : "https://demo1.saptez.com/believeapp/api/assets/priority/1.png"

Priority priorityFromJson(String str) => Priority.fromJson(json.decode(str));
String priorityToJson(Priority data) => json.encode(data.toJson());
class Priority {
  Priority({
      String? id, 
      String? name, 
      String? color, 
      String? flag,}){
    _id = id;
    _name = name;
    _color = color;
    _flag = flag;
}

  Priority.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _color = json['color'];
    _flag = json['flag'];
  }
  String? _id;
  String? _name;
  String? _color;
  String? _flag;
Priority copyWith({  String? id,
  String? name,
  String? color,
  String? flag,
}) => Priority(  id: id ?? _id,
  name: name ?? _name,
  color: color ?? _color,
  flag: flag ?? _flag,
);
  String? get id => _id;
  String? get name => _name;
  String? get color => _color;
  String? get flag => _flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['color'] = _color;
    map['flag'] = _flag;
    return map;
  }

}