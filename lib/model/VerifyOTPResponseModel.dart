import 'dart:convert';
/// success : 1
/// message : ""
/// data : {"id":"2","department_id":"1","department":"Factory","designation_id":"2","designation":"General Manager","name":"vrushik patel","email_address":"dasd@dasd.com","country":"91","contact_no":"91 1234567892","aadhaar_card_no":"123112341233","aadhaar_card_front_photo":"","aadhaar_card_back_photo":"","aadhaar_card_pdf":"https://demo1.saptez.com/believeapp/api/assets/documents/aadhaar/aadhaar_1701764725_88.pdf","aadhaar_card_photo_0_or_pdf_1":"1","pan_card_no":"","pan_card_photo":"","pan_card_pdf":"https://demo1.saptez.com/believeapp/api/assets/documents/pan/pan_1701764725_56.pdf","pan_card_photo_0_or_pdf_1":"1","passport_size_photo":"https://demo1.saptez.com/believeapp/api/assets/documents/profile/profile_1701764725_60.png","created_at":"05 Dec, 2023","updated_at":"05 Dec, 2023","is_active":"1"}

VerifyOtpResponseModel verifyOtpResponseModelFromJson(String str) => VerifyOtpResponseModel.fromJson(json.decode(str));
String verifyOtpResponseModelToJson(VerifyOtpResponseModel data) => json.encode(data.toJson());
class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
      num? success, 
      String? message, 
      Data? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  VerifyOtpResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _success;
  String? _message;
  Data? _data;
VerifyOtpResponseModel copyWith({  num? success,
  String? message,
  Data? data,
}) => VerifyOtpResponseModel(  success: success ?? _success,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get success => _success;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : "2"
/// department_id : "1"
/// department : "Factory"
/// designation_id : "2"
/// designation : "General Manager"
/// name : "vrushik patel"
/// email_address : "dasd@dasd.com"
/// country : "91"
/// contact_no : "91 1234567892"
/// aadhaar_card_no : "123112341233"
/// aadhaar_card_front_photo : ""
/// aadhaar_card_back_photo : ""
/// aadhaar_card_pdf : "https://demo1.saptez.com/believeapp/api/assets/documents/aadhaar/aadhaar_1701764725_88.pdf"
/// aadhaar_card_photo_0_or_pdf_1 : "1"
/// pan_card_no : ""
/// pan_card_photo : ""
/// pan_card_pdf : "https://demo1.saptez.com/believeapp/api/assets/documents/pan/pan_1701764725_56.pdf"
/// pan_card_photo_0_or_pdf_1 : "1"
/// passport_size_photo : "https://demo1.saptez.com/believeapp/api/assets/documents/profile/profile_1701764725_60.png"
/// created_at : "05 Dec, 2023"
/// updated_at : "05 Dec, 2023"
/// is_active : "1"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? departmentId, 
      String? department, 
      String? designationId, 
      String? designation, 
      String? name, 
      String? emailAddress, 
      String? country, 
      String? contactNo, 
      String? aadhaarCardNo, 
      String? aadhaarCardFrontPhoto, 
      String? aadhaarCardBackPhoto, 
      String? aadhaarCardPdf, 
      String? aadhaarCardPhoto0OrPdf1, 
      String? panCardNo, 
      String? panCardPhoto, 
      String? panCardPdf, 
      String? panCardPhoto0OrPdf1, 
      String? passportSizePhoto, 
      String? createdAt, 
      String? updatedAt, 
      String? isActive,}){
    _id = id;
    _departmentId = departmentId;
    _department = department;
    _designationId = designationId;
    _designation = designation;
    _name = name;
    _emailAddress = emailAddress;
    _country = country;
    _contactNo = contactNo;
    _aadhaarCardNo = aadhaarCardNo;
    _aadhaarCardFrontPhoto = aadhaarCardFrontPhoto;
    _aadhaarCardBackPhoto = aadhaarCardBackPhoto;
    _aadhaarCardPdf = aadhaarCardPdf;
    _aadhaarCardPhoto0OrPdf1 = aadhaarCardPhoto0OrPdf1;
    _panCardNo = panCardNo;
    _panCardPhoto = panCardPhoto;
    _panCardPdf = panCardPdf;
    _panCardPhoto0OrPdf1 = panCardPhoto0OrPdf1;
    _passportSizePhoto = passportSizePhoto;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _isActive = isActive;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _departmentId = json['department_id'];
    _department = json['department'];
    _designationId = json['designation_id'];
    _designation = json['designation'];
    _name = json['name'];
    _emailAddress = json['email_address'];
    _country = json['country'];
    _contactNo = json['contact_no'];
    _aadhaarCardNo = json['aadhaar_card_no'];
    _aadhaarCardFrontPhoto = json['aadhaar_card_front_photo'];
    _aadhaarCardBackPhoto = json['aadhaar_card_back_photo'];
    _aadhaarCardPdf = json['aadhaar_card_pdf'];
    _aadhaarCardPhoto0OrPdf1 = json['aadhaar_card_photo_0_or_pdf_1'];
    _panCardNo = json['pan_card_no'];
    _panCardPhoto = json['pan_card_photo'];
    _panCardPdf = json['pan_card_pdf'];
    _panCardPhoto0OrPdf1 = json['pan_card_photo_0_or_pdf_1'];
    _passportSizePhoto = json['passport_size_photo'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _isActive = json['is_active'];
  }
  String? _id;
  String? _departmentId;
  String? _department;
  String? _designationId;
  String? _designation;
  String? _name;
  String? _emailAddress;
  String? _country;
  String? _contactNo;
  String? _aadhaarCardNo;
  String? _aadhaarCardFrontPhoto;
  String? _aadhaarCardBackPhoto;
  String? _aadhaarCardPdf;
  String? _aadhaarCardPhoto0OrPdf1;
  String? _panCardNo;
  String? _panCardPhoto;
  String? _panCardPdf;
  String? _panCardPhoto0OrPdf1;
  String? _passportSizePhoto;
  String? _createdAt;
  String? _updatedAt;
  String? _isActive;
Data copyWith({  String? id,
  String? departmentId,
  String? department,
  String? designationId,
  String? designation,
  String? name,
  String? emailAddress,
  String? country,
  String? contactNo,
  String? aadhaarCardNo,
  String? aadhaarCardFrontPhoto,
  String? aadhaarCardBackPhoto,
  String? aadhaarCardPdf,
  String? aadhaarCardPhoto0OrPdf1,
  String? panCardNo,
  String? panCardPhoto,
  String? panCardPdf,
  String? panCardPhoto0OrPdf1,
  String? passportSizePhoto,
  String? createdAt,
  String? updatedAt,
  String? isActive,
}) => Data(  id: id ?? _id,
  departmentId: departmentId ?? _departmentId,
  department: department ?? _department,
  designationId: designationId ?? _designationId,
  designation: designation ?? _designation,
  name: name ?? _name,
  emailAddress: emailAddress ?? _emailAddress,
  country: country ?? _country,
  contactNo: contactNo ?? _contactNo,
  aadhaarCardNo: aadhaarCardNo ?? _aadhaarCardNo,
  aadhaarCardFrontPhoto: aadhaarCardFrontPhoto ?? _aadhaarCardFrontPhoto,
  aadhaarCardBackPhoto: aadhaarCardBackPhoto ?? _aadhaarCardBackPhoto,
  aadhaarCardPdf: aadhaarCardPdf ?? _aadhaarCardPdf,
  aadhaarCardPhoto0OrPdf1: aadhaarCardPhoto0OrPdf1 ?? _aadhaarCardPhoto0OrPdf1,
  panCardNo: panCardNo ?? _panCardNo,
  panCardPhoto: panCardPhoto ?? _panCardPhoto,
  panCardPdf: panCardPdf ?? _panCardPdf,
  panCardPhoto0OrPdf1: panCardPhoto0OrPdf1 ?? _panCardPhoto0OrPdf1,
  passportSizePhoto: passportSizePhoto ?? _passportSizePhoto,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  isActive: isActive ?? _isActive,
);
  String? get id => _id;
  String? get departmentId => _departmentId;
  String? get department => _department;
  String? get designationId => _designationId;
  String? get designation => _designation;
  String? get name => _name;
  String? get emailAddress => _emailAddress;
  String? get country => _country;
  String? get contactNo => _contactNo;
  String? get aadhaarCardNo => _aadhaarCardNo;
  String? get aadhaarCardFrontPhoto => _aadhaarCardFrontPhoto;
  String? get aadhaarCardBackPhoto => _aadhaarCardBackPhoto;
  String? get aadhaarCardPdf => _aadhaarCardPdf;
  String? get aadhaarCardPhoto0OrPdf1 => _aadhaarCardPhoto0OrPdf1;
  String? get panCardNo => _panCardNo;
  String? get panCardPhoto => _panCardPhoto;
  String? get panCardPdf => _panCardPdf;
  String? get panCardPhoto0OrPdf1 => _panCardPhoto0OrPdf1;
  String? get passportSizePhoto => _passportSizePhoto;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['department_id'] = _departmentId;
    map['department'] = _department;
    map['designation_id'] = _designationId;
    map['designation'] = _designation;
    map['name'] = _name;
    map['email_address'] = _emailAddress;
    map['country'] = _country;
    map['contact_no'] = _contactNo;
    map['aadhaar_card_no'] = _aadhaarCardNo;
    map['aadhaar_card_front_photo'] = _aadhaarCardFrontPhoto;
    map['aadhaar_card_back_photo'] = _aadhaarCardBackPhoto;
    map['aadhaar_card_pdf'] = _aadhaarCardPdf;
    map['aadhaar_card_photo_0_or_pdf_1'] = _aadhaarCardPhoto0OrPdf1;
    map['pan_card_no'] = _panCardNo;
    map['pan_card_photo'] = _panCardPhoto;
    map['pan_card_pdf'] = _panCardPdf;
    map['pan_card_photo_0_or_pdf_1'] = _panCardPhoto0OrPdf1;
    map['passport_size_photo'] = _passportSizePhoto;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['is_active'] = _isActive;
    return map;
  }

}