class ProductListItem {
  Data? data;
  int? responseCode;
  String? responseMessage;

  ProductListItem({this.data, this.responseCode, this.responseMessage});

  ProductListItem.fromJson(Map<String, dynamic> json) {
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
  List<Newrangeproductallview>? newrangeproductallview;
  List<Newrangeproductallview>? topSelling;
  List<Newrangeproductallview>? viewAllCategoryItems;
  List<Newrangeproductallview>? products;

  Data(
      {this.newrangeproductallview,
      this.topSelling,
      this.viewAllCategoryItems,
      this.products});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['newrangeproductallview'] != null) {
      newrangeproductallview = <Newrangeproductallview>[];
      json['newrangeproductallview'].forEach((v) {
        newrangeproductallview!.add(Newrangeproductallview.fromJson(v));
      });
    }
    if (json['topselling'] != null) {
      topSelling = <Newrangeproductallview>[];
      json['topselling'].forEach((v) {
        topSelling!.add(Newrangeproductallview.fromJson(v));
      });
    }
    if (json['subcategory'] != null) {
      viewAllCategoryItems = <Newrangeproductallview>[];
      json['subcategory'].forEach((v) {
        viewAllCategoryItems!.add(Newrangeproductallview.fromJson(v));
      });
    }
    if (json['newproduct'] != null) {
      products = <Newrangeproductallview>[];
      json['newproduct'].forEach((v) {
        products!.add(Newrangeproductallview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (newrangeproductallview != null) {
      data['newrangeproductallview'] =
          newrangeproductallview!.map((v) => v.toJson()).toList();
    }
    if (topSelling != null) {
      data['topselling'] = topSelling!.map((v) => v.toJson()).toList();
    }
    if (viewAllCategoryItems != null) {
      data['subcategory'] =
          viewAllCategoryItems!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['newproduct'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Newrangeproductallview {
  String? id;
  String? name;
  String? price;
  String? view;
  String? oldprice;
  String? imagePath;
  String? code;
  String? categorycode;

  Newrangeproductallview(
      {this.id,
      this.name,
      this.price,
      this.view,
      this.oldprice,
      this.imagePath,
      this.code,
      this.categorycode});

  Newrangeproductallview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toString();
    view = json['view'].toString();
    oldprice = json['oldprice'].toString();
    imagePath = json['image_path'];
    code=json['code'];
    categorycode=json['category_code'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['view'] = view;
    data['oldprice'] = oldprice;
    data['image_path'] = imagePath;
    data['code'] = code;
    data['category_code']=categorycode;
    return data;
  }
}
