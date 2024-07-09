class WishListModel {
  List<Data>? data;
  int? responseCode;
  String? responseMessage;

  WishListModel({this.data, this.responseCode, this.responseMessage});

  WishListModel.fromJson(Map<String, dynamic> json) {
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
  String? proid;
  String? userId;
  String? pdatetime;
  String? view;
  String? oldPrice;
  String? name;
  String? itemcode;
  String? qty;
  String? weight;
  String? warehouse;
  String? price;
  String? promotion;
  String? itemDescription;
  String? shortDescription;
  String? altName;
  String? shortAltName;
  String? brandID;
  String? seasonID;
  String? idle;
  String? baseUnit;
  String? scale;
  String? size;
  String? year;
  String? divisionID;
  String? color;
  String? barCode;
  String? createdOn;
  String? updatedOn;
  String? model;
  String? itemType;
  String? mandatoryserial;
  String? useserial;
  String? familyID;
  String? subFamilyID;
  String? subSubFamilyID;
  String? typeID;
  String? subTypeID;
  String? subSubTypeID;
  String? uDF1;
  String? uDF2;
  String? uDF3;
  String? uDF4;
  String? uDF5;
  String? uDF6;

  String? cronjob;
  String? status;
  String? picupstore;
  String? promotiPro;

  String? grossweight;
  String? imagePath;
  String? imagename;

  Data(
      {this.id,
      this.proid,
      this.userId,
      this.pdatetime,
      this.view,
      this.oldPrice,
      this.name,
      this.itemcode,
      this.qty,
      this.weight,
      this.warehouse,
      this.price,
      this.promotion,
      this.itemDescription,
      this.shortDescription,
      this.altName,
      this.shortAltName,
      this.brandID,
      this.seasonID,
      this.idle,
      this.baseUnit,
      this.scale,
      this.size,
      this.year,
      this.divisionID,
      this.color,
      this.barCode,
      this.createdOn,
      this.updatedOn,
      this.model,
      this.itemType,
      this.mandatoryserial,
      this.useserial,
      this.familyID,
      this.subFamilyID,
      this.subSubFamilyID,
      this.typeID,
      this.subTypeID,
      this.subSubTypeID,
      this.uDF1,
      this.uDF2,
      this.uDF3,
      this.uDF4,
      this.uDF5,
      this.uDF6,
      this.cronjob,
      this.status,
      this.picupstore,
      this.promotiPro,
      this.grossweight,
      this.imagePath,
      this.imagename});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    proid = json['proid'];
    userId = json['user_id'];
    pdatetime = json['pdatetime'];
    view = json['view'];
    oldPrice = json['old_price'];
    name = json['name'];
    itemcode = json['itemcode'];
    qty = json['qty'];
    weight = json['weight'];
    warehouse = json['warehouse'];
    price = json['price'];
    promotion = json['promotion'];
    itemDescription = json['ItemDescription'];
    shortDescription = json['ShortDescription'];
    altName = json['AltName'];
    shortAltName = json['ShortAltName'];
    brandID = json['BrandID'];
    seasonID = json['SeasonID'];
    idle = json['Idle'];
    baseUnit = json['BaseUnit'];
    scale = json['Scale'];
    size = json['Size'];
    year = json['Year'];
    divisionID = json['DivisionID'];
    color = json['color'];
    barCode = json['BarCode'];
    createdOn = json['CreatedOn'];
    updatedOn = json['UpdatedOn'];
    model = json['Model'];
    itemType = json['ItemType'];
    mandatoryserial = json['mandatoryserial'];
    useserial = json['useserial'];
    familyID = json['FamilyID'];
    subFamilyID = json['SubFamilyID'];
    subSubFamilyID = json['SubSubFamilyID'];
    typeID = json['TypeID'];
    subTypeID = json['SubTypeID'];
    subSubTypeID = json['SubSubTypeID'];
    uDF1 = json['UDF1'];
    uDF2 = json['UDF2'];
    uDF3 = json['UDF3'];
    uDF4 = json['UDF4'];
    uDF5 = json['UDF5'];
    uDF6 = json['UDF6'];

    cronjob = json['cronjob'];
    status = json['status'];
    picupstore = json['picupstore'];
    promotiPro = json['promoti_pro'];

    grossweight = json['grossweight'];
    imagePath = json['image_path'];
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['proid'] = proid;
    data['user_id'] = userId;
    data['pdatetime'] = pdatetime;
    data['view'] = view;
    data['old_price'] = oldPrice;
    data['name'] = name;
    data['itemcode'] = itemcode;
    data['qty'] = qty;
    data['weight'] = weight;
    data['warehouse'] = warehouse;
    data['price'] = price;
    data['promotion'] = promotion;
    data['ItemDescription'] = itemDescription;
    data['ShortDescription'] = shortDescription;
    data['AltName'] = altName;
    data['ShortAltName'] = shortAltName;
    data['BrandID'] = brandID;
    data['SeasonID'] = seasonID;
    data['Idle'] = idle;
    data['BaseUnit'] = baseUnit;
    data['Scale'] = scale;
    data['Size'] = size;
    data['Year'] = year;
    data['DivisionID'] = divisionID;
    data['color'] = color;
    data['BarCode'] = barCode;
    data['CreatedOn'] = createdOn;
    data['UpdatedOn'] = updatedOn;
    data['Model'] = model;
    data['ItemType'] = itemType;
    data['mandatoryserial'] = mandatoryserial;
    data['useserial'] = useserial;
    data['FamilyID'] = familyID;
    data['SubFamilyID'] = subFamilyID;
    data['SubSubFamilyID'] = subSubFamilyID;
    data['TypeID'] = typeID;
    data['SubTypeID'] = subTypeID;
    data['SubSubTypeID'] = subSubTypeID;
    data['UDF1'] = uDF1;
    data['UDF2'] = uDF2;
    data['UDF3'] = uDF3;
    data['UDF4'] = uDF4;
    data['UDF5'] = uDF5;
    data['UDF6'] = uDF6;

    data['cronjob'] = cronjob;
    data['status'] = status;
    data['picupstore'] = picupstore;
    data['promoti_pro'] = promotiPro;

    data['grossweight'] = grossweight;
    data['image_path'] = imagePath;
    data['imagename'] = imagename;
    return data;
  }
}
