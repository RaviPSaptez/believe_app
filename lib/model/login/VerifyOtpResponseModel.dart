import 'dart:convert';
/// success : 1
/// message : ""
/// data : {"id":"1","department_id":"1","department":"Factory","designation_id":"2","designation":"General Manager","name":"vrushik patel","name_small":"V","email_address":"dasd@dasd.com","country":"91","contact_no":"91 1234567891","hod":"1","aadhaar_card_no":"123112341233","aadhaar_card_front_photo":"","aadhaar_card_front_photo_full":"","aadhaar_card_back_photo":"","aadhaar_card_back_photo_full":"","aadhaar_card_pdf":"aadhaar_1701764692_28.pdf","aadhaar_card_pdf_full":"https://demo1.saptez.com/believeapp/api/assets/documents/aadhaar/aadhaar_1701764692_28.pdf","aadhaar_card_photo_0_or_pdf_1":"1","pan_card_no":"","pan_card_photo":"","pan_card_photo_full":"","pan_card_pdf":"pan_1701764692_77.pdf","pan_card_pdf_full":"https://demo1.saptez.com/believeapp/api/assets/documents/pan/pan_1701764692_77.pdf","pan_card_photo_0_or_pdf_1":"1","passport_size_photo":"profile_1701764692_40.png","passport_size_photo_full":"https://demo1.saptez.com/believeapp/api/image-tool/index.php?src=https://demo1.saptez.com/believeapp/api/assets/documents/profile/profile_1701764692_40.png","created_at_date_time":{"date":"05 Dec, 2023","time":"01:54 PM"},"updated_at_date_time":{"date":"","time":""},"is_active":"1"}

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

/// id : "1"
/// department_id : "1"
/// department : "Factory"
/// designation_id : "2"
/// designation : "General Manager"
/// name : "vrushik patel"
/// name_small : "V"
/// email_address : "dasd@dasd.com"
/// country : "91"
/// contact_no : "91 1234567891"
/// hod : "1"
/// aadhaar_card_no : "123112341233"
/// aadhaar_card_front_photo : ""
/// aadhaar_card_front_photo_full : ""
/// aadhaar_card_back_photo : ""
/// aadhaar_card_back_photo_full : ""
/// aadhaar_card_pdf : "aadhaar_1701764692_28.pdf"
/// aadhaar_card_pdf_full : "https://demo1.saptez.com/believeapp/api/assets/documents/aadhaar/aadhaar_1701764692_28.pdf"
/// aadhaar_card_photo_0_or_pdf_1 : "1"
/// pan_card_no : ""
/// pan_card_photo : ""
/// pan_card_photo_full : ""
/// pan_card_pdf : "pan_1701764692_77.pdf"
/// pan_card_pdf_full : "https://demo1.saptez.com/believeapp/api/assets/documents/pan/pan_1701764692_77.pdf"
/// pan_card_photo_0_or_pdf_1 : "1"
/// passport_size_photo : "profile_1701764692_40.png"
/// passport_size_photo_full : "https://demo1.saptez.com/believeapp/api/image-tool/index.php?src=https://demo1.saptez.com/believeapp/api/assets/documents/profile/profile_1701764692_40.png"
/// created_at_date_time : {"date":"05 Dec, 2023","time":"01:54 PM"}
/// updated_at_date_time : {"date":"","time":""}
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
      String? nameSmall, 
      String? emailAddress, 
      String? country, 
      String? contactNo, 
      String? hod, 
      String? aadhaarCardNo, 
      String? aadhaarCardFrontPhoto, 
      String? aadhaarCardFrontPhotoFull, 
      String? aadhaarCardBackPhoto, 
      String? aadhaarCardBackPhotoFull, 
      String? aadhaarCardPdf, 
      String? aadhaarCardPdfFull, 
      String? aadhaarCardPhoto0OrPdf1, 
      String? panCardNo, 
      String? panCardPhoto, 
      String? panCardPhotoFull, 
      String? panCardPdf, 
      String? panCardPdfFull, 
      String? panCardPhoto0OrPdf1, 
      String? passportSizePhoto, 
      String? passportSizePhotoFull, 
      CreatedAtDateTime? createdAtDateTime, 
      UpdatedAtDateTime? updatedAtDateTime, 
      String? isActive,}){
    _id = id;
    _departmentId = departmentId;
    _department = department;
    _designationId = designationId;
    _designation = designation;
    _name = name;
    _nameSmall = nameSmall;
    _emailAddress = emailAddress;
    _country = country;
    _contactNo = contactNo;
    _hod = hod;
    _aadhaarCardNo = aadhaarCardNo;
    _aadhaarCardFrontPhoto = aadhaarCardFrontPhoto;
    _aadhaarCardFrontPhotoFull = aadhaarCardFrontPhotoFull;
    _aadhaarCardBackPhoto = aadhaarCardBackPhoto;
    _aadhaarCardBackPhotoFull = aadhaarCardBackPhotoFull;
    _aadhaarCardPdf = aadhaarCardPdf;
    _aadhaarCardPdfFull = aadhaarCardPdfFull;
    _aadhaarCardPhoto0OrPdf1 = aadhaarCardPhoto0OrPdf1;
    _panCardNo = panCardNo;
    _panCardPhoto = panCardPhoto;
    _panCardPhotoFull = panCardPhotoFull;
    _panCardPdf = panCardPdf;
    _panCardPdfFull = panCardPdfFull;
    _panCardPhoto0OrPdf1 = panCardPhoto0OrPdf1;
    _passportSizePhoto = passportSizePhoto;
    _passportSizePhotoFull = passportSizePhotoFull;
    _createdAtDateTime = createdAtDateTime;
    _updatedAtDateTime = updatedAtDateTime;
    _isActive = isActive;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _departmentId = json['department_id'];
    _department = json['department'];
    _designationId = json['designation_id'];
    _designation = json['designation'];
    _name = json['name'];
    _nameSmall = json['name_small'];
    _emailAddress = json['email_address'];
    _country = json['country'];
    _contactNo = json['contact_no'];
    _hod = json['hod'];
    _aadhaarCardNo = json['aadhaar_card_no'];
    _aadhaarCardFrontPhoto = json['aadhaar_card_front_photo'];
    _aadhaarCardFrontPhotoFull = json['aadhaar_card_front_photo_full'];
    _aadhaarCardBackPhoto = json['aadhaar_card_back_photo'];
    _aadhaarCardBackPhotoFull = json['aadhaar_card_back_photo_full'];
    _aadhaarCardPdf = json['aadhaar_card_pdf'];
    _aadhaarCardPdfFull = json['aadhaar_card_pdf_full'];
    _aadhaarCardPhoto0OrPdf1 = json['aadhaar_card_photo_0_or_pdf_1'];
    _panCardNo = json['pan_card_no'];
    _panCardPhoto = json['pan_card_photo'];
    _panCardPhotoFull = json['pan_card_photo_full'];
    _panCardPdf = json['pan_card_pdf'];
    _panCardPdfFull = json['pan_card_pdf_full'];
    _panCardPhoto0OrPdf1 = json['pan_card_photo_0_or_pdf_1'];
    _passportSizePhoto = json['passport_size_photo'];
    _passportSizePhotoFull = json['passport_size_photo_full'];
    _createdAtDateTime = json['created_at_date_time'] != null ? CreatedAtDateTime.fromJson(json['created_at_date_time']) : null;
    _updatedAtDateTime = json['updated_at_date_time'] != null ? UpdatedAtDateTime.fromJson(json['updated_at_date_time']) : null;
    _isActive = json['is_active'];
  }
  String? _id;
  String? _departmentId;
  String? _department;
  String? _designationId;
  String? _designation;
  String? _name;
  String? _nameSmall;
  String? _emailAddress;
  String? _country;
  String? _contactNo;
  String? _hod;
  String? _aadhaarCardNo;
  String? _aadhaarCardFrontPhoto;
  String? _aadhaarCardFrontPhotoFull;
  String? _aadhaarCardBackPhoto;
  String? _aadhaarCardBackPhotoFull;
  String? _aadhaarCardPdf;
  String? _aadhaarCardPdfFull;
  String? _aadhaarCardPhoto0OrPdf1;
  String? _panCardNo;
  String? _panCardPhoto;
  String? _panCardPhotoFull;
  String? _panCardPdf;
  String? _panCardPdfFull;
  String? _panCardPhoto0OrPdf1;
  String? _passportSizePhoto;
  String? _passportSizePhotoFull;
  CreatedAtDateTime? _createdAtDateTime;
  UpdatedAtDateTime? _updatedAtDateTime;
  String? _isActive;
Data copyWith({  String? id,
  String? departmentId,
  String? department,
  String? designationId,
  String? designation,
  String? name,
  String? nameSmall,
  String? emailAddress,
  String? country,
  String? contactNo,
  String? hod,
  String? aadhaarCardNo,
  String? aadhaarCardFrontPhoto,
  String? aadhaarCardFrontPhotoFull,
  String? aadhaarCardBackPhoto,
  String? aadhaarCardBackPhotoFull,
  String? aadhaarCardPdf,
  String? aadhaarCardPdfFull,
  String? aadhaarCardPhoto0OrPdf1,
  String? panCardNo,
  String? panCardPhoto,
  String? panCardPhotoFull,
  String? panCardPdf,
  String? panCardPdfFull,
  String? panCardPhoto0OrPdf1,
  String? passportSizePhoto,
  String? passportSizePhotoFull,
  CreatedAtDateTime? createdAtDateTime,
  UpdatedAtDateTime? updatedAtDateTime,
  String? isActive,
}) => Data(  id: id ?? _id,
  departmentId: departmentId ?? _departmentId,
  department: department ?? _department,
  designationId: designationId ?? _designationId,
  designation: designation ?? _designation,
  name: name ?? _name,
  nameSmall: nameSmall ?? _nameSmall,
  emailAddress: emailAddress ?? _emailAddress,
  country: country ?? _country,
  contactNo: contactNo ?? _contactNo,
  hod: hod ?? _hod,
  aadhaarCardNo: aadhaarCardNo ?? _aadhaarCardNo,
  aadhaarCardFrontPhoto: aadhaarCardFrontPhoto ?? _aadhaarCardFrontPhoto,
  aadhaarCardFrontPhotoFull: aadhaarCardFrontPhotoFull ?? _aadhaarCardFrontPhotoFull,
  aadhaarCardBackPhoto: aadhaarCardBackPhoto ?? _aadhaarCardBackPhoto,
  aadhaarCardBackPhotoFull: aadhaarCardBackPhotoFull ?? _aadhaarCardBackPhotoFull,
  aadhaarCardPdf: aadhaarCardPdf ?? _aadhaarCardPdf,
  aadhaarCardPdfFull: aadhaarCardPdfFull ?? _aadhaarCardPdfFull,
  aadhaarCardPhoto0OrPdf1: aadhaarCardPhoto0OrPdf1 ?? _aadhaarCardPhoto0OrPdf1,
  panCardNo: panCardNo ?? _panCardNo,
  panCardPhoto: panCardPhoto ?? _panCardPhoto,
  panCardPhotoFull: panCardPhotoFull ?? _panCardPhotoFull,
  panCardPdf: panCardPdf ?? _panCardPdf,
  panCardPdfFull: panCardPdfFull ?? _panCardPdfFull,
  panCardPhoto0OrPdf1: panCardPhoto0OrPdf1 ?? _panCardPhoto0OrPdf1,
  passportSizePhoto: passportSizePhoto ?? _passportSizePhoto,
  passportSizePhotoFull: passportSizePhotoFull ?? _passportSizePhotoFull,
  createdAtDateTime: createdAtDateTime ?? _createdAtDateTime,
  updatedAtDateTime: updatedAtDateTime ?? _updatedAtDateTime,
  isActive: isActive ?? _isActive,
);
  String? get id => _id;
  String? get departmentId => _departmentId;
  String? get department => _department;
  String? get designationId => _designationId;
  String? get designation => _designation;
  String? get name => _name;
  String? get nameSmall => _nameSmall;
  String? get emailAddress => _emailAddress;
  String? get country => _country;
  String? get contactNo => _contactNo;
  String? get hod => _hod;
  String? get aadhaarCardNo => _aadhaarCardNo;
  String? get aadhaarCardFrontPhoto => _aadhaarCardFrontPhoto;
  String? get aadhaarCardFrontPhotoFull => _aadhaarCardFrontPhotoFull;
  String? get aadhaarCardBackPhoto => _aadhaarCardBackPhoto;
  String? get aadhaarCardBackPhotoFull => _aadhaarCardBackPhotoFull;
  String? get aadhaarCardPdf => _aadhaarCardPdf;
  String? get aadhaarCardPdfFull => _aadhaarCardPdfFull;
  String? get aadhaarCardPhoto0OrPdf1 => _aadhaarCardPhoto0OrPdf1;
  String? get panCardNo => _panCardNo;
  String? get panCardPhoto => _panCardPhoto;
  String? get panCardPhotoFull => _panCardPhotoFull;
  String? get panCardPdf => _panCardPdf;
  String? get panCardPdfFull => _panCardPdfFull;
  String? get panCardPhoto0OrPdf1 => _panCardPhoto0OrPdf1;
  String? get passportSizePhoto => _passportSizePhoto;
  String? get passportSizePhotoFull => _passportSizePhotoFull;
  CreatedAtDateTime? get createdAtDateTime => _createdAtDateTime;
  UpdatedAtDateTime? get updatedAtDateTime => _updatedAtDateTime;
  String? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['department_id'] = _departmentId;
    map['department'] = _department;
    map['designation_id'] = _designationId;
    map['designation'] = _designation;
    map['name'] = _name;
    map['name_small'] = _nameSmall;
    map['email_address'] = _emailAddress;
    map['country'] = _country;
    map['contact_no'] = _contactNo;
    map['hod'] = _hod;
    map['aadhaar_card_no'] = _aadhaarCardNo;
    map['aadhaar_card_front_photo'] = _aadhaarCardFrontPhoto;
    map['aadhaar_card_front_photo_full'] = _aadhaarCardFrontPhotoFull;
    map['aadhaar_card_back_photo'] = _aadhaarCardBackPhoto;
    map['aadhaar_card_back_photo_full'] = _aadhaarCardBackPhotoFull;
    map['aadhaar_card_pdf'] = _aadhaarCardPdf;
    map['aadhaar_card_pdf_full'] = _aadhaarCardPdfFull;
    map['aadhaar_card_photo_0_or_pdf_1'] = _aadhaarCardPhoto0OrPdf1;
    map['pan_card_no'] = _panCardNo;
    map['pan_card_photo'] = _panCardPhoto;
    map['pan_card_photo_full'] = _panCardPhotoFull;
    map['pan_card_pdf'] = _panCardPdf;
    map['pan_card_pdf_full'] = _panCardPdfFull;
    map['pan_card_photo_0_or_pdf_1'] = _panCardPhoto0OrPdf1;
    map['passport_size_photo'] = _passportSizePhoto;
    map['passport_size_photo_full'] = _passportSizePhotoFull;
    if (_createdAtDateTime != null) {
      map['created_at_date_time'] = _createdAtDateTime?.toJson();
    }
    if (_updatedAtDateTime != null) {
      map['updated_at_date_time'] = _updatedAtDateTime?.toJson();
    }
    map['is_active'] = _isActive;
    return map;
  }

}

/// date : ""
/// time : ""

UpdatedAtDateTime updatedAtDateTimeFromJson(String str) => UpdatedAtDateTime.fromJson(json.decode(str));
String updatedAtDateTimeToJson(UpdatedAtDateTime data) => json.encode(data.toJson());
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

/// date : "05 Dec, 2023"
/// time : "01:54 PM"

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