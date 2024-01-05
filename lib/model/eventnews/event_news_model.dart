/// data : [{"id":"1","department_id":"101","title":"news 1","description":"This is a detailed description for news 1. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget turpis ultricies, vestibulum ante sed, accumsan ligula. Vivamus non risus vitae odio semper finibus vel id lorem. Nam convallis enim vel dolor fermentum, ut sagittis dui lacinia. In euismod dui eget urna tincidunt, vitae tempor justo eleifend. Sed lacinia augue vel lorem malesuada, nec fermentum metus tempor. Quisque hendrerit semper sapien, eget auctor orci fermentum nec. Donec suscipit gravida metus at facilisis. Nullam vitae interdum orci. Integer id cursus libero.","attachment":"file1.jpg","attachment_full":"https://images.unsplash.com/photo-1682687220945-922198770e60?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D","campaign_time":"1702364275","campaign_type":"1","rsvp":"0","created_at_date_time":{"date":"12 Dec, 2023","time":"12:42 PM"},"updated_at_date_time":{"date":"13 Dec, 2023","time":"09:30 AM"}},{"id":"2","department_id":"102","title":"news 2","description":"Another comprehensive description for news 2. Morbi vitae neque ac ligula iaculis interdum. Vivamus convallis libero ut elit tincidunt, sed dictum massa posuere. Proin et dui auctor, sodales magna sit amet, facilisis metus. Donec nec ante quis ante consequat hendrerit eget eu libero. Quisque sed purus non enim ullamcorper ultricies. Phasellus nec dui sed purus tristique condimentum. Suspendisse potenti. Cras eget lobortis libero, id posuere justo. Integer fringilla purus vel velit tempor, sit amet volutpat est fermentum.","attachment":"file2.pdf","attachment_full":"https://images.unsplash.com/photo-1702228194672-146175b6a243?q=80&w=2112&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D","campaign_time":"1702364276","campaign_type":"2","rsvp":"1","created_at_date_time":{"date":"13 Dec, 2023","time":"10:15 AM"},"updated_at_date_time":{"date":"14 Dec, 2023","time":"11:20 AM"}},{"id":"3","department_id":"103","title":"news 3","description":"This is a lengthy description for news 3. Etiam nec dui id metus ullamcorper vestibulum. Curabitur bibendum hendrerit lectus, vel dapibus leo commodo vel. Integer ac elit vitae metus convallis lacinia. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec nec purus non metus dapibus volutpat. Quisque at eros quis neque tincidunt vehicula eu sit amet mauris. In hac habitasse platea dictumst. Sed bibendum risus id dui consectetur ullamcorper.","attachment":"","attachment_full":"https://images.unsplash.com/photo-1682687220208-22d7a2543e88?q=80&w=1975&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D","campaign_time":"1702364277","campaign_type":"1","rsvp":"0","created_at_date_time":{"date":"14 Dec, 2023","time":"03:30 PM"},"updated_at_date_time":{"date":"","time":""}},{"id":"4","department_id":"104","title":"news 4","description":"A detailed and elaborate description for news 4. Duis auctor arcu id elit hendrerit, a convallis metus bibendum. Sed in orci id nisl bibendum placerat. Fusce at mauris eu tellus fermentum tempor nec vel massa. Nunc vel lacus in ipsum pharetra iaculis. Integer eget massa sed dolor laoreet bibendum. Aliquam erat volutpat. Sed commodo feugiat justo, vitae sollicitudin dolor accumsan vitae.","attachment":"file4.doc","attachment_full":"https://images.unsplash.com/photo-1682686580391-615b1f28e5ee?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D","campaign_time":"1702364278","campaign_type":"2","rsvp":"1","created_at_date_time":{"date":"15 Dec, 2023","time":"09:00 AM"},"updated_at_date_time":{"date":"15 Dec, 2023","time":"11:30 AM"}},{"id":"5","department_id":"105","title":"news 5","description":"This description for news 5 is quite extensive. Curabitur nec vestibulum eros. In hac habitasse platea dictumst. Aenean a risus libero. Phasellus vitae quam in libero pellentesque mollis. Mauris ut ipsum a nisi tristique aliquet ut a ligula. Morbi eget semper orci. Ut vestibulum justo vitae ex viverra, quis hendrerit arcu eleifend.","attachment":"file5.png","attachment_full":"https://images.unsplash.com/photo-1702145754106-05d909f08c9d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D","campaign_time":"1702364279","campaign_type":"1","rsvp":"1","created_at_date_time":{"date":"16 Dec, 2023","time":"01:00 PM"},"updated_at_date_time":{"date":"16 Dec, 2023","time":"03:45 PM"}}]
/// success : 1
/// message : "Records found."

class EventNewsModel {
  EventNewsModel({
      List<EventNewsListItem>? data, 
      num? success, 
      String? message,}){
    _data = data;
    _success = success;
    _message = message;
}

  EventNewsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(EventNewsListItem.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<EventNewsListItem>? _data;
  num? _success;
  String? _message;
EventNewsModel copyWith({  List<EventNewsListItem>? data,
  num? success,
  String? message,
}) => EventNewsModel(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
);
  List<EventNewsListItem>? get data => _data;
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
/// department_id : "101"
/// title : "news 1"
/// description : "This is a detailed description for news 1. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget turpis ultricies, vestibulum ante sed, accumsan ligula. Vivamus non risus vitae odio semper finibus vel id lorem. Nam convallis enim vel dolor fermentum, ut sagittis dui lacinia. In euismod dui eget urna tincidunt, vitae tempor justo eleifend. Sed lacinia augue vel lorem malesuada, nec fermentum metus tempor. Quisque hendrerit semper sapien, eget auctor orci fermentum nec. Donec suscipit gravida metus at facilisis. Nullam vitae interdum orci. Integer id cursus libero."
/// attachment : "file1.jpg"
/// attachment_full : "https://images.unsplash.com/photo-1682687220945-922198770e60?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
/// campaign_time : "1702364275"
/// campaign_type : "1"
/// rsvp : "0"
/// created_at_date_time : {"date":"12 Dec, 2023","time":"12:42 PM"}
/// updated_at_date_time : {"date":"13 Dec, 2023","time":"09:30 AM"}

class EventNewsListItem {
  EventNewsListItem({
      String? id, 
      String? departmentId, 
      String? title, 
      String? description, 
      String? attachment, 
      String? attachmentFull, 
      String? campaignTime, 
      String? campaignType, 
      String? rsvp, 
      CreatedAtDateTime? createdAtDateTime, 
      UpdatedAtDateTime? updatedAtDateTime,}){
    _id = id;
    _departmentId = departmentId;
    _title = title;
    _description = description;
    _attachment = attachment;
    _attachmentFull = attachmentFull;
    _campaignTime = campaignTime;
    _campaignType = campaignType;
    _rsvp = rsvp;
    _createdAtDateTime = createdAtDateTime;
    _updatedAtDateTime = updatedAtDateTime;
}

  EventNewsListItem.fromJson(dynamic json) {
    _id = json['id'];
    _departmentId = json['department_id'];
    _title = json['title'];
    _description = json['description'];
    _attachment = json['attachment'];
    _attachmentFull = json['attachment_full'];
    _campaignTime = json['campaign_time'];
    _campaignType = json['campaign_type'];
    _rsvp = json['rsvp'];
    _createdAtDateTime = json['created_at_date_time'] != null ? CreatedAtDateTime.fromJson(json['created_at_date_time']) : null;
    _updatedAtDateTime = json['updated_at_date_time'] != null ? UpdatedAtDateTime.fromJson(json['updated_at_date_time']) : null;
  }
  String? _id;
  String? _departmentId;
  String? _title;
  String? _description;
  String? _attachment;
  String? _attachmentFull;
  String? _campaignTime;
  String? _campaignType;
  String? _rsvp;
  CreatedAtDateTime? _createdAtDateTime;
  UpdatedAtDateTime? _updatedAtDateTime;
EventNewsListItem copyWith({  String? id,
  String? departmentId,
  String? title,
  String? description,
  String? attachment,
  String? attachmentFull,
  String? campaignTime,
  String? campaignType,
  String? rsvp,
  CreatedAtDateTime? createdAtDateTime,
  UpdatedAtDateTime? updatedAtDateTime,
}) => EventNewsListItem(  id: id ?? _id,
  departmentId: departmentId ?? _departmentId,
  title: title ?? _title,
  description: description ?? _description,
  attachment: attachment ?? _attachment,
  attachmentFull: attachmentFull ?? _attachmentFull,
  campaignTime: campaignTime ?? _campaignTime,
  campaignType: campaignType ?? _campaignType,
  rsvp: rsvp ?? _rsvp,
  createdAtDateTime: createdAtDateTime ?? _createdAtDateTime,
  updatedAtDateTime: updatedAtDateTime ?? _updatedAtDateTime,
);
  String? get id => _id;
  String? get departmentId => _departmentId;
  String? get title => _title;
  String? get description => _description;
  String? get attachment => _attachment;
  String? get attachmentFull => _attachmentFull;
  String? get campaignTime => _campaignTime;
  String? get campaignType => _campaignType;
  String? get rsvp => _rsvp;
  CreatedAtDateTime? get createdAtDateTime => _createdAtDateTime;
  UpdatedAtDateTime? get updatedAtDateTime => _updatedAtDateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['department_id'] = _departmentId;
    map['title'] = _title;
    map['description'] = _description;
    map['attachment'] = _attachment;
    map['attachment_full'] = _attachmentFull;
    map['campaign_time'] = _campaignTime;
    map['campaign_type'] = _campaignType;
    map['rsvp'] = _rsvp;
    if (_createdAtDateTime != null) {
      map['created_at_date_time'] = _createdAtDateTime?.toJson();
    }
    if (_updatedAtDateTime != null) {
      map['updated_at_date_time'] = _updatedAtDateTime?.toJson();
    }
    return map;
  }

}

/// date : "13 Dec, 2023"
/// time : "09:30 AM"

class UpdatedAtDateTime {
  UpdatedAtDateTime({
      String? date, 
      String? time,}){
    _date = date;
    _time = time;
}

  UpdatedAtDateTime.fromJson(dynamic json) {
    _date = json['date'];
    _time = json['time'];
  }
  String? _date;
  String? _time;
UpdatedAtDateTime copyWith({  String? date,
  String? time,
}) => UpdatedAtDateTime(  date: date ?? _date,
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

/// date : "12 Dec, 2023"
/// time : "12:42 PM"

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