class WorkExperience{
  String? _range;
  int? _id;

  WorkExperience({String? range, int? id}){
    _range = range;
    _id = id;
  }

  String? get range => _range;
  int? get id => _id;

  set range(String? range){
    _range = range;
  }

  set id(int? id){
    _id = id;
  }
}