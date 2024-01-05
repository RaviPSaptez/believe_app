class EventType{
  String? _name;
  int? _id;

  EventType({String? name, int? id}){
    _name = name;
    _id = id;
  }

  String? get name => _name;
  int? get id => _id;

  set setName(String? name){
    _name = name;
  }

  set setId(int? id){
    _id = id;
  }
}

class Department{
  String? _name;
  int? _id;

  Department({String? name, int? id}){
    _name = name;
    _id = id;
  }

  String? get name => _name;
  int? get id => _id;

  set setName(String? name){
    _name = name;
  }

  set setId(int? id){
    _id = id;
  }
}