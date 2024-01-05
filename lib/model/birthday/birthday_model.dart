class BirthDayMonths{
  String? _name;
  int? _id;

  BirthDayMonths({String? name, int? id}){
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