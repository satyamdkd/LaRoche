class SearchModel {
  List<Data>? data;
  int? responseCode;
  String? responseMessage;

  SearchModel({this.data, this.responseCode, this.responseMessage});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['responseCode'] = responseCode;
    data['responseMessage'] = responseMessage;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? price;
  String? qty;
  String? familyID;
  String? subFamilyID;
  String? subSubFamilyID;
  String? oldprice;
  String? imagePath;

  Data(
      {this.id,
        this.name,
        this.price,
        this.qty,
        this.familyID,
        this.subFamilyID,
        this.subSubFamilyID,
        this.oldprice,
        this.imagePath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    qty = json['qty'];
    familyID = json['FamilyID'];
    subFamilyID = json['SubFamilyID'];
    subSubFamilyID = json['SubSubFamilyID'];
    oldprice = json['oldprice'].toString();
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['qty'] = qty;
    data['FamilyID'] = familyID;
    data['SubFamilyID'] = subFamilyID;
    data['SubSubFamilyID'] = subSubFamilyID;
    data['oldprice'] = oldprice;
    data['image_path'] = imagePath;
    return data;
  }
}