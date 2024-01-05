import 'dart:convert';
/// data : [{"id":"5","type":"announcement","name":"Announcement","view_rights":"1","add_rights":"0","delete_rights":"0","color":"#008DA4","icon":"https://demo1.saptez.com/believeapp/api/assets/module/icon/announcement.png"},{"id":"7","type":"birthday_reminders","name":"Birthday Reminders","view_rights":"1","add_rights":"","delete_rights":"","color":"#FF42D7","icon":"https://demo1.saptez.com/believeapp/api/assets/module/icon/birthdate.png"},{"id":"6","type":"events","name":"Events","view_rights":"1","add_rights":"0","delete_rights":"0","color":"#DC0168","icon":"https://demo1.saptez.com/believeapp/api/assets/module/icon/events.png"},{"id":"8","type":"feedback","name":"Feedback","view_rights":"1","add_rights":"0","delete_rights":"0","color":"#2ACB52","icon":"https://demo1.saptez.com/believeapp/api/assets/module/icon/feedback.png"},{"id":"3","type":"kudos","name":"Kudos","view_rights":"1","add_rights":"0","delete_rights":"0","color":"#00B09F","icon":"https://demo1.saptez.com/believeapp/api/assets/module/icon/kudos.png"},{"id":"1","type":"locker_my_Documents","name":"Locker-My Documents","view_rights":"1","add_rights":"0","delete_rights":"0","color":"#20A4FF","icon":"https://demo1.saptez.com/believeapp/api/assets/module/icon/locker.png"},{"id":"4","type":"motivate_morivational_quotes","name":"Motivate-Morivational Quotes","view_rights":"1","add_rights":"0","delete_rights":"0","color":"#FFB000","icon":"https://demo1.saptez.com/believeapp/api/assets/module/icon/quotes.png"},{"id":"2","type":"my_tasks","name":"My Tasks","view_rights":"1","add_rights":"0","delete_rights":"0","color":"#0087FF","icon":"https://demo1.saptez.com/believeapp/api/assets/module/icon/task.png"}]
/// success : 1
/// message : ""

MenuItemsReposnse menuItemsReposnseFromJson(String str) => MenuItemsReposnse.fromJson(json.decode(str));
String menuItemsReposnseToJson(MenuItemsReposnse data) => json.encode(data.toJson());
class MenuItemsReposnse {
  MenuItemsReposnse({
      List<MenuItems>? data, 
      num? success, 
      String? message,}){
    _data = data;
    _success = success;
    _message = message;
}

  MenuItemsReposnse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MenuItems.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<MenuItems>? _data;
  num? _success;
  String? _message;
MenuItemsReposnse copyWith({  List<MenuItems>? data,
  num? success,
  String? message,
}) => MenuItemsReposnse(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
);
  List<MenuItems>? get data => _data;
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

/// id : "5"
/// type : "announcement"
/// name : "Announcement"
/// view_rights : "1"
/// add_rights : "0"
/// delete_rights : "0"
/// color : "#008DA4"
/// icon : "https://demo1.saptez.com/believeapp/api/assets/module/icon/announcement.png"

MenuItems dataFromJson(String str) => MenuItems.fromJson(json.decode(str));
String dataToJson(MenuItems data) => json.encode(data.toJson());
class MenuItems {
  MenuItems({
      String? id, 
      String? type, 
      String? name, 
      String? viewRights, 
      String? addRights, 
      String? deleteRights, 
      String? color, 
      String? icon,}){
    _id = id;
    _type = type;
    _name = name;
    _viewRights = viewRights;
    _addRights = addRights;
    _deleteRights = deleteRights;
    _color = color;
    _icon = icon;
}

  MenuItems.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _name = json['name'];
    _viewRights = json['view_rights'];
    _addRights = json['add_rights'];
    _deleteRights = json['delete_rights'];
    _color = json['color'];
    _icon = json['icon'];
  }
  String? _id;
  String? _type;
  String? _name;
  String? _viewRights;
  String? _addRights;
  String? _deleteRights;
  String? _color;
  String? _icon;
MenuItems copyWith({  String? id,
  String? type,
  String? name,
  String? viewRights,
  String? addRights,
  String? deleteRights,
  String? color,
  String? icon,
}) => MenuItems(  id: id ?? _id,
  type: type ?? _type,
  name: name ?? _name,
  viewRights: viewRights ?? _viewRights,
  addRights: addRights ?? _addRights,
  deleteRights: deleteRights ?? _deleteRights,
  color: color ?? _color,
  icon: icon ?? _icon,
);
  String? get id => _id;
  String? get type => _type;
  String? get name => _name;
  String? get viewRights => _viewRights;
  String? get addRights => _addRights;
  String? get deleteRights => _deleteRights;
  String? get color => _color;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['name'] = _name;
    map['view_rights'] = _viewRights;
    map['add_rights'] = _addRights;
    map['delete_rights'] = _deleteRights;
    map['color'] = _color;
    map['icon'] = _icon;
    return map;
  }

}