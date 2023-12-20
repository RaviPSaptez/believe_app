class Type{
  String? _name;
  int? _id;

  Type({String? name, int? id}){
    _name = name;
    _id = id;
  }

  String? get name => _name;
  int? get id => _id;

  set name(String? name){
    _name = name;
  }

  set id(int? id){
    _id = id;
  }
}


class Condition{
  String? _name;
  int? _id;

  Condition({String? name, int? id}){
    _name = name;
    _id = id;
  }

  String? get name => _name;
  int? get id => _id;

  set name(String? name){
    _name = name;
  }

  set id(int? id){
    _id = id;
  }
}

class Status{
  String? _name;
  String? _id;

  Status({String? name, String? id}){
    _name = name;
    _id = id;
  }

  String? get name => _name;
  String? get id => _id;

  set name(String? name){
    _name = name;
  }

  set id(String? id){
    _id = id;
  }

}