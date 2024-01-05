import 'dart:convert';
/// data : [{"id":"10","title":"Task No 1","description":"task no 1 test description","sub_description":"","priority":{"id":"1","name":"Urgent","color":"#F17771","flag":"https://demo1.saptez.com/believeapp/api/assets/priority/1.png"},"status":{"id":"1","name":"New","color":"#37DDF0"},"status_update_values":{"text":"Mark as Doing","status_id":"2","approve_text":{"text":"","status_id":"","text_1":"","status_id_1":""}},"created_at_date_time":{"date":"13 Dec, 2023","time":"12:57 PM"},"due_date_time":{"date":"13 Dec, 2023","time":"12:56 AM"},"user_assign_to":{"user_id":"","name":"","profile_pic_full":""},"user_created_task":{"user_id":"1","name":"vrushik patel"},"tags_comma":"task,demo","tags_array":["task","demo"]}]
/// success : 1
/// message : "Records found."
/// total_records : 1

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

/// id : "10"
/// title : "Task No 1"
/// description : "task no 1 test description"
/// sub_description : ""
/// priority : {"id":"1","name":"Urgent","color":"#F17771","flag":"https://demo1.saptez.com/believeapp/api/assets/priority/1.png"}
/// status : {"id":"1","name":"New","color":"#37DDF0"}
/// status_update_values : {"text":"Mark as Doing","status_id":"2","approve_text":{"text":"","status_id":"","text_1":"","status_id_1":""}}
/// created_at_date_time : {"date":"13 Dec, 2023","time":"12:57 PM"}
/// due_date_time : {"date":"13 Dec, 2023","time":"12:56 AM"}
/// user_assign_to : {"user_id":"","name":"","profile_pic_full":""}
/// user_created_task : {"user_id":"1","name":"vrushik patel"}
/// tags_comma : "task,demo"
/// tags_array : ["task","demo"]

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
      StatusUpdateValues? statusUpdateValues, 
      CreatedAtDateTime? createdAtDateTime, 
      DueDateTime? dueDateTime, 
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
    _statusUpdateValues = statusUpdateValues;
    _createdAtDateTime = createdAtDateTime;
    _dueDateTime = dueDateTime;
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
    _statusUpdateValues = json['status_update_values'] != null ? StatusUpdateValues.fromJson(json['status_update_values']) : null;
    _createdAtDateTime = json['created_at_date_time'] != null ? CreatedAtDateTime.fromJson(json['created_at_date_time']) : null;
    _dueDateTime = json['due_date_time'] != null ? DueDateTime.fromJson(json['due_date_time']) : null;
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
  StatusUpdateValues? _statusUpdateValues;
  CreatedAtDateTime? _createdAtDateTime;
  DueDateTime? _dueDateTime;
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
  StatusUpdateValues? statusUpdateValues,
  CreatedAtDateTime? createdAtDateTime,
  DueDateTime? dueDateTime,
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
  statusUpdateValues: statusUpdateValues ?? _statusUpdateValues,
  createdAtDateTime: createdAtDateTime ?? _createdAtDateTime,
  dueDateTime: dueDateTime ?? _dueDateTime,
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
  StatusUpdateValues? get statusUpdateValues => _statusUpdateValues;
  CreatedAtDateTime? get createdAtDateTime => _createdAtDateTime;
  DueDateTime? get dueDateTime => _dueDateTime;
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
    if (_statusUpdateValues != null) {
      map['status_update_values'] = _statusUpdateValues?.toJson();
    }
    if (_createdAtDateTime != null) {
      map['created_at_date_time'] = _createdAtDateTime?.toJson();
    }
    if (_dueDateTime != null) {
      map['due_date_time'] = _dueDateTime?.toJson();
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

/// user_id : ""
/// name : ""
/// profile_pic_full : ""

UserAssignTo userAssignToFromJson(String str) => UserAssignTo.fromJson(json.decode(str));
String userAssignToToJson(UserAssignTo data) => json.encode(data.toJson());
class UserAssignTo {
  UserAssignTo({
      String? userId, 
      String? name, 
      String? profilePicFull,}){
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
  String? profilePicFull,
}) => UserAssignTo(  userId: userId ?? _userId,
  name: name ?? _name,
  profilePicFull: profilePicFull ?? _profilePicFull,
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

/// date : "13 Dec, 2023"
/// time : "12:56 AM"

DueDateTime dueDateTimeFromJson(String str) => DueDateTime.fromJson(json.decode(str));
String dueDateTimeToJson(DueDateTime data) => json.encode(data.toJson());
class DueDateTime {
  DueDateTime({
      String? date, 
      String? time,}){
    _date = date;
    _time = time;
}

  DueDateTime.fromJson(dynamic json) {
    _date = json['date'];
    _time = json['time'];
  }
  String? _date;
  String? _time;
DueDateTime copyWith({  String? date,
  String? time,
}) => DueDateTime(  date: date ?? _date,
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

/// date : "13 Dec, 2023"
/// time : "12:57 PM"

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

/// text : "Mark as Doing"
/// status_id : "2"
/// approve_text : {"text":"","status_id":"","text_1":"","status_id_1":""}

StatusUpdateValues statusUpdateValuesFromJson(String str) => StatusUpdateValues.fromJson(json.decode(str));
String statusUpdateValuesToJson(StatusUpdateValues data) => json.encode(data.toJson());
class StatusUpdateValues {
  StatusUpdateValues({
      String? text, 
      String? statusId, 
      ApproveText? approveText,}){
    _text = text;
    _statusId = statusId;
    _approveText = approveText;
}

  StatusUpdateValues.fromJson(dynamic json) {
    _text = json['text'];
    _statusId = json['status_id'];
    _approveText = json['approve_text'] != null ? ApproveText.fromJson(json['approve_text']) : null;
  }
  String? _text;
  String? _statusId;
  ApproveText? _approveText;
StatusUpdateValues copyWith({  String? text,
  String? statusId,
  ApproveText? approveText,
}) => StatusUpdateValues(  text: text ?? _text,
  statusId: statusId ?? _statusId,
  approveText: approveText ?? _approveText,
);
  String? get text => _text;
  String? get statusId => _statusId;
  ApproveText? get approveText => _approveText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['status_id'] = _statusId;
    if (_approveText != null) {
      map['approve_text'] = _approveText?.toJson();
    }
    return map;
  }

}

/// text : ""
/// status_id : ""
/// text_1 : ""
/// status_id_1 : ""

ApproveText approveTextFromJson(String str) => ApproveText.fromJson(json.decode(str));
String approveTextToJson(ApproveText data) => json.encode(data.toJson());
class ApproveText {
  ApproveText({
      String? text, 
      String? statusId, 
      String? text1, 
      String? statusId1,}){
    _text = text;
    _statusId = statusId;
    _text1 = text1;
    _statusId1 = statusId1;
}

  ApproveText.fromJson(dynamic json) {
    _text = json['text'];
    _statusId = json['status_id'];
    _text1 = json['text_1'];
    _statusId1 = json['status_id_1'];
  }
  String? _text;
  String? _statusId;
  String? _text1;
  String? _statusId1;
ApproveText copyWith({  String? text,
  String? statusId,
  String? text1,
  String? statusId1,
}) => ApproveText(  text: text ?? _text,
  statusId: statusId ?? _statusId,
  text1: text1 ?? _text1,
  statusId1: statusId1 ?? _statusId1,
);
  String? get text => _text;
  String? get statusId => _statusId;
  String? get text1 => _text1;
  String? get statusId1 => _statusId1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['status_id'] = _statusId;
    map['text_1'] = _text1;
    map['status_id_1'] = _statusId1;
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