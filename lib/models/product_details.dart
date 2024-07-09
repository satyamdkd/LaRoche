class ProductDetails {
  Data? data;
  int? responseCode;
  String? responseMessage;

  ProductDetails({this.data, this.responseCode, this.responseMessage});

  ProductDetails.fromJson(Map<String, dynamic> json) {
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
  List<Newproduct>? newproduct;
  List<Newproduct>? relatedproduct;

  Data({this.newproduct, this.relatedproduct});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['newproduct'] != null) {
      newproduct = <Newproduct>[];
      json['newproduct'].forEach((v) {
        newproduct!.add(Newproduct.fromJson(v));
      });
    }
    if (json['relatedproduct'] != null) {
      relatedproduct = <Newproduct>[];
      json['relatedproduct'].forEach((v) {
        relatedproduct!.add(Newproduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (newproduct != null) {
      data['newproduct'] = newproduct!.map((v) => v.toJson()).toList();
    }
    if (relatedproduct != null) {
      data['relatedproduct'] =
          relatedproduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Newproduct {
  String? id;
  String? name;
  String? price;
  String? itemDescription;
  String? itemcode;
  String? subSubFamilyID;
  String? qty;
  String? view;
  String? oldprice;
  String? percentoff;
  String? imagePath;
  String? docsPath;
  String? docsPathtwo;
  String? promotion;
  String?  promotionPro;

  Newproduct(
      {this.id,
        this.name,
        this.price,
        this.itemDescription,
        this.itemcode,
        this.subSubFamilyID,
        this.qty,
        this.view,
        this.oldprice,
        this.percentoff,
        this.imagePath,
      this.docsPath,
      this.docsPathtwo,
      this.promotion,
      this.promotionPro});

  Newproduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    itemDescription = json['ItemDescription'];
    itemcode = json['itemcode'];
    subSubFamilyID = json['SubSubFamilyID'];
    qty = json['qty'];
    view = "${json['view'].toString()}";
    oldprice = "${json['oldprice']}";
    percentoff = "${json['percentoff']}";
    imagePath = json['image_path'];
    docsPath = json['docs_path'];
    docsPathtwo = json['docs_pathtwo'];
    promotion= json['promotion'];
     promotionPro=json['promoti_pro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['ItemDescription'] = itemDescription;
    data['itemcode'] = itemcode;
    data['SubSubFamilyID'] = subSubFamilyID;
    data['qty'] = qty;
    data['view'] = view;
    data['oldprice'] = oldprice;
    data['percentoff'] = percentoff;
    data['image_path'] = imagePath;
    data['docs_path']=docsPath;
    data['docs_pathtwo']=docsPathtwo;
data['promotion']=promotion;
data['promoti_pro']=promotionPro;


return data;
  }
}
