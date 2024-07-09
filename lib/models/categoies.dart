class Categories {
  Data? data;
  int? responseCode;
  String? responseMessage;

  Categories({this.data, this.responseCode, this.responseMessage});

  Categories.fromJson(Map<String, dynamic> json) {
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
  List<Maincategory>? maincategory;
  List<Subcategory>? subcategory;
  List<SubSubcategoryModel>? subSubcategory;

  Data({this.maincategory, this.subcategory, this.subSubcategory});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['maincategory'] != null) {
      maincategory = <Maincategory>[];
      json['maincategory'].forEach((v) {
        maincategory!.add(Maincategory.fromJson(v));
      });
    }
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(Subcategory.fromJson(v));
      });
    }
    if (json['subsubcategory'] != null) {
      subSubcategory = <SubSubcategoryModel>[];
      json['subsubcategory'].forEach((v) {
        subSubcategory!.add(SubSubcategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (maincategory != null) {
      data['maincategory'] = maincategory!.map((v) => v.toJson()).toList();
    }
    if (subcategory != null) {
      data['subcategory'] = subcategory!.map((v) => v.toJson()).toList();
    }
    if (subSubcategory != null) {
      data['subsubcategory'] = subSubcategory!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Maincategory {
  String? id;
  String? name;
  String? imagePath;
  String? code;

  Maincategory({this.id, this.name, this.imagePath, this.code});

  Maincategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imagePath = json['image_path'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_path'] = imagePath;
    data['code'] = code;
    return data;
  }
}

class Subcategory {
  String? id;
  String? name;
  String? imagePath;
  String? code;
  String? categoryCode;

  Subcategory(
      {this.id, this.name, this.imagePath, this.code, this.categoryCode});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imagePath = json['image_path'];
    code = json['code'];
    categoryCode = json['category_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_path'] = imagePath;
    data['code'] = code;
    data['category_code'] = categoryCode;
    return data;
  }
}

class SubSubcategoryModel {
  String? id;
  String? name;
  String? imagePath;
  String? code;
  String? categoryCode;

  SubSubcategoryModel(
      {this.id, this.name, this.imagePath, this.code, this.categoryCode});

  SubSubcategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imagePath = json['image_path'];
    code = json['code'];
    categoryCode = json['category_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_path'] = imagePath;
    data['code'] = code;
    data['category_code'] = categoryCode;
    return data;
  }
}
