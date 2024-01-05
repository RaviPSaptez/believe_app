class StorageData{
  String? _folderName;
  int? _folderId;
  int? _subFolder;
  int? _items;

  StorageData({required String folderName,required int folderId, int? subFolder, int? items}){
    _folderName = folderName;
    _folderId = folderId;
    _subFolder = subFolder;
    _items = items;
  }

  String? get folderName => _folderName;
  int? get folderId => _folderId;
  int? get subFolder => _subFolder;
  int? get items => _items;

  set folderName(String? folderName){
    _folderName = folderName;
  }
  set folderId(int? folderId){
    _folderId = folderId;
  }
  set subFolder(int? subFolder){
    _subFolder = subFolder;
  }
  set items(int? items){
    _items = items;
  }
}

class FileType{
  String? _name;
  int? _id;

  FileType({String? name, int? id}){
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

class SubFolder{
  String? _folderName;
  int? _folderId;
  int? _subFolder;
  int? _items;

  SubFolder({required String folderName,required int folderId, int? subFolder, int? items}){
    _folderName = folderName;
    _folderId = folderId;
    _subFolder = subFolder;
    _items = items;
  }

  String? get folderName => _folderName;
  int? get folderId => _folderId;
  int? get subFolder => _subFolder;
  int? get items => _items;

  set folderName(String? folderName){
    _folderName = folderName;
  }
  set folderId(int? folderId){
    _folderId = folderId;
  }
  set subFolder(int? subFolder){
    _subFolder = subFolder;
  }
  set items(int? items){
    _items = items;
  }
}

class FolderFiles{
  String? _fileName;
  int? _filesId;
  String? _fileSize;
  String? _date;

  FolderFiles({String? fileName, int? fileId, String? fileSize, String? date}){
    _fileName = fileName;
    _filesId = fileId;
    _fileSize = fileSize;
    _date = date;
  }

  String? get fileName => _fileName;
  int? get fileId => _filesId;
  String? get fileSize => _fileSize;
  String? get date => _date;

  set fileName(String? fileName){
    _fileName = fileName;
  }
  set fileId(int? fileId){
    _filesId = fileId;
  }
  set fileSize(String? fileSize){
    _fileSize = fileSize;
  }
  set date(String? date){
    _date = date;
  }
}