class DistributorDashboardModel {
  String? message;
  Outstanding? outstanding;
  Overdues? overdues;
  CreditlimitWithMfg? creditlimitWithMfg;
  CreditlimitWithBank? creditlimitWithBank;

  DistributorDashboardModel(
      {this.message,
        this.outstanding,
        this.overdues,
        this.creditlimitWithMfg,
        this.creditlimitWithBank});

  DistributorDashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    outstanding = json['outstanding'] != null
        ? new Outstanding.fromJson(json['outstanding'])
        : null;
    overdues = json['overdues'] != null
        ? new Overdues.fromJson(json['overdues'])
        : null;
    creditlimitWithMfg = (json['creditlimit_with_mfg'] != null
        ? new CreditlimitWithMfg.fromJson(json['creditlimit_with_mfg'])
        : null)!;
    creditlimitWithBank = (json['creditlimit_with_bank'] != null
        ? new CreditlimitWithBank.fromJson(json['creditlimit_with_bank'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.outstanding != null) {
      data['outstanding'] = this.outstanding!.toJson();
    }
    if (this.overdues != null) {
      data['overdues'] = this.overdues!.toJson();
    }
    if (this.creditlimitWithMfg != null) {
      data['creditlimit_with_mfg'] = this.creditlimitWithMfg!.toJson();
    }
    if (this.creditlimitWithBank != null) {
      data['creditlimit_with_bank'] = this.creditlimitWithBank!.toJson();
    }
    return data;
  }
}

class Outstanding {
  int? total;
  int? p08;
  int? pBC;

  Outstanding({this.total, this.p08, this.pBC});

  Outstanding.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    p08 = json['P08'];
    pBC = json['PBC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['P08'] = this.p08;
    data['PBC'] = this.pBC;
    return data;
  }
}
class Overdues {
  int? total;
  int? p08;
  int? pBC;

  Overdues({this.total, this.p08, this.pBC});

  Overdues.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    p08 = json['P08'];
    pBC = json['PBC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['P08'] = this.p08;
    data['PBC'] = this.pBC;
    return data;
  }
}

class CreditlimitWithMfg {
  String? datetime;
  int? total;
  P08? p08;
  P08? pBC;

  CreditlimitWithMfg({this.datetime, this.total, this.p08, this.pBC});

  CreditlimitWithMfg.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    total = json['total'];
    p08 = json['P08'] != null ? new P08.fromJson(json['P08']) : null;
    pBC = json['PBC'] != null ? new P08.fromJson(json['PBC']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datetime'] = this.datetime;
    data['total'] = this.total;
    if (this.p08 != null) {
      data['P08'] = this.p08!.toJson();
    }
    if (this.pBC != null) {
      data['PBC'] = this.pBC!.toJson();
    }
    return data;
  }
}

class P08 {
  int? total;
  int? spent;
  int? available;

  P08({this.total, this.spent, this.available});

  P08.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    spent = json['spent'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['spent'] = this.spent;
    data['available'] = this.available;
    return data;
  }
}

class CreditlimitWithBank {
  String? datetime;
  int? total;
  int? spent;
  int? available;

  CreditlimitWithBank({this.datetime, this.total, this.spent, this.available});

  CreditlimitWithBank.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    total = json['total'];
    spent = json['spent'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datetime'] = this.datetime;
    data['total'] = this.total;
    data['spent'] = this.spent;
    data['available'] = this.available;
    return data;
  }
}
