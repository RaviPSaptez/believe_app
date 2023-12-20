class MyLeave {
  Leaves? leaves;

  MyLeave({this.leaves});

  MyLeave.fromJson(Map<String, dynamic> json) {
    leaves =
    json['leaves'] != null ? new Leaves.fromJson(json['leaves']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaves != null) {
      data['leaves'] = this.leaves!.toJson();
    }
    return data;
  }
}

class Leaves {
  List<Details>? causal;
  List<Details>? sick;
  List<Details>? maternity;
  List<Details>? marriage;
  List<Details>? paternity;
  List<Details>? travel;

  Leaves(
      {this.causal, this.sick, this.maternity, this.marriage, this.paternity, this.travel});

  Leaves.fromJson(Map<String, dynamic> json) {
    if (json['Causal'] != null) {
      causal = <Details>[];
      json['Causal'].forEach((v) {
        causal!.add(new Details.fromJson(v));
      });
    }
    if (json['Sick'] != null) {
      sick = <Details>[];
      json['Sick'].forEach((v) {
        sick!.add(new Details.fromJson(v));
      });
    }
    if (json['Maternity'] != null) {
      maternity = <Details>[];
      json['Maternity'].forEach((v) {
        maternity!.add(new Details.fromJson(v));
      });
    }
    if (json['Marriage'] != null) {
      marriage = <Details>[];
      json['Marriage'].forEach((v) {
        marriage!.add(new Details.fromJson(v));
      });
    }
    if (json['Paternity'] != null) {
      paternity = <Details>[];
      json['Paternity'].forEach((v) {
        paternity!.add(new Details.fromJson(v));
      });
    }
    if (json['Travel'] != null) {
      travel = <Details>[];
      json['Travel'].forEach((v) {
        travel!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.causal != null) {
      data['Causal'] = this.causal!.map((v) => v.toJson()).toList();
    }
    if (this.sick != null) {
      data['Sick'] = this.sick!.map((v) => v.toJson()).toList();
    }
    if (this.maternity != null) {
      data['Maternity'] = this.maternity!.map((v) => v.toJson()).toList();
    }
    if (this.marriage != null) {
      data['Marriage'] = this.marriage!.map((v) => v.toJson()).toList();
    }
    if (this.paternity != null) {
      data['Paternity'] = this.paternity!.map((v) => v.toJson()).toList();
    }
    if (this.travel != null) {
      data['Travel'] = this.travel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? type;
  String? title;
  String? description;
  int? days;
  String? dateFrom;
  String? dateTo;
  String? status;

  Details(
      {
        this.type,
        this.title,
        this.description,
        this.days,
        this.dateFrom,
        this.dateTo,
        this.status});

  Details.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    description = json['description'];
    days = json['days'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    data['days'] = this.days;
    data['dateFrom'] = this.dateFrom;
    data['dateTo'] = this.dateTo;
    data['status'] = this.status;
    return data;
  }
}

