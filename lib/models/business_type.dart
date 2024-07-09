class BusinessType {
  Data? data;
  int? responseCode;
  String? responseMessage;

  BusinessType({this.data, this.responseCode, this.responseMessage});

  BusinessType.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['responseCode'] = responseCode;
    data['responseMessage'] = responseMessage;
    return data;
  }
}

class Data {
  List<MyData>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyData>[];
      json['data'].forEach((v) {
        data!.add(MyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyData {
  String? id;
  String? businessType;
  String? status;

  MyData({this.id, this.businessType, this.status});

  MyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessType = json['business_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['business_type'] = businessType;
    data['status'] = status;
    return data;
  }
}
