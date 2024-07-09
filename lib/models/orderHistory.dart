class OrderHistoryModel {
  Data? data;
  int? responseCode;
  String? responseMessage;

  OrderHistoryModel({this.data, this.responseCode, this.responseMessage});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}

class Data {
  List<Orderlist>? orderlist;

  Data({this.orderlist});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orderlist'] != null) {
      orderlist = <Orderlist>[];
      json['orderlist'].forEach((v) {
        orderlist!.add(new Orderlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderlist != null) {
      data['orderlist'] = this.orderlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orderlist {
  int? id;
  int? userid;
  String? orderdate;
  String? cartvalue;
  String? ordertime;
  String? finalpayment;
  int? shippingCharges;
  String? gst;
  String? shipping;
  String? coupondiscount;
  String? couponamount;
  String? couponcode;
  String? couponid;
  String? deliveryaddress;
  String? ordertype;
  String? orderstatus;
  String? paymentstatus;
  Null? payuId;
  String? orderid;
  int? view;
  String? name;
  String? lastName;
  String? pincode;
  String? address;
  String? apartment;
  String? city;
  String? state;
  String? banches;
  String? country;
  String? mobileNo;
  Null? standardDelivery;
  String? ipAddress;
  String? email;
  Null? orderNote;
  Null? transactionStatus;
  Null? orderCurrentStatusDate;
  Null? sOIdVD;
  Null? log;
  int? assignStatus;
  Null? trackingNumber;
  List<Details>? details;

  Orderlist(
      {this.id,
        this.userid,
        this.orderdate,
        this.cartvalue,
        this.ordertime,
        this.finalpayment,
        this.shippingCharges,
        this.gst,
        this.shipping,
        this.coupondiscount,
        this.couponamount,
        this.couponcode,
        this.couponid,
        this.deliveryaddress,
        this.ordertype,
        this.orderstatus,
        this.paymentstatus,
        this.payuId,
        this.orderid,
        this.view,
        this.name,
        this.lastName,
        this.pincode,
        this.address,
        this.apartment,
        this.city,
        this.state,
        this.banches,
        this.country,
        this.mobileNo,
        this.standardDelivery,
        this.ipAddress,
        this.email,
        this.orderNote,
        this.transactionStatus,
        this.orderCurrentStatusDate,
        this.sOIdVD,
        this.log,
        this.assignStatus,
        this.trackingNumber,
        this.details});

  Orderlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    orderdate = json['orderdate'];
    cartvalue = json['cartvalue'];
    ordertime = json['ordertime'];
    finalpayment = json['finalpayment'];
    shippingCharges = json['shipping_charges'];
    gst = json['gst'];
    shipping = json['shipping'];
    coupondiscount = json['coupondiscount'];
    couponamount = json['couponamount'];
    couponcode = json['couponcode'];
    couponid = json['couponid'];
    deliveryaddress = json['deliveryaddress'];
    ordertype = json['ordertype'];
    orderstatus = json['orderstatus'];
    paymentstatus = json['paymentstatus'];
    payuId = json['payu_id'];
    orderid = json['orderid'];
    view = json['view'];
    name = json['name'];
    lastName = json['last_name'];
    pincode = json['pincode'];
    address = json['address'];
    apartment = json['apartment'];
    city = json['city'];
    state = json['state'];
    banches = json['banches'];
    country = json['country'];
    mobileNo = json['mobile_no'];
    standardDelivery = json['standard_delivery'];
    ipAddress = json['ip_address'];
    email = json['email'];
    orderNote = json['order_note'];
    transactionStatus = json['transaction_status'];
    orderCurrentStatusDate = json['order_current_status_date'];
    sOIdVD = json['SOId_VD'];
    log = json['log'];
    assignStatus = json['assign_status'];
    trackingNumber = json['tracking_number'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['orderdate'] = this.orderdate;
    data['cartvalue'] = this.cartvalue;
    data['ordertime'] = this.ordertime;
    data['finalpayment'] = this.finalpayment;
    data['shipping_charges'] = this.shippingCharges;
    data['gst'] = this.gst;
    data['shipping'] = this.shipping;
    data['coupondiscount'] = this.coupondiscount;
    data['couponamount'] = this.couponamount;
    data['couponcode'] = this.couponcode;
    data['couponid'] = this.couponid;
    data['deliveryaddress'] = this.deliveryaddress;
    data['ordertype'] = this.ordertype;
    data['orderstatus'] = this.orderstatus;
    data['paymentstatus'] = this.paymentstatus;
    data['payu_id'] = this.payuId;
    data['orderid'] = this.orderid;
    data['view'] = this.view;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['pincode'] = this.pincode;
    data['address'] = this.address;
    data['apartment'] = this.apartment;
    data['city'] = this.city;
    data['state'] = this.state;
    data['banches'] = this.banches;
    data['country'] = this.country;
    data['mobile_no'] = this.mobileNo;
    data['standard_delivery'] = this.standardDelivery;
    data['ip_address'] = this.ipAddress;
    data['email'] = this.email;
    data['order_note'] = this.orderNote;
    data['transaction_status'] = this.transactionStatus;
    data['order_current_status_date'] = this.orderCurrentStatusDate;
    data['SOId_VD'] = this.sOIdVD;
    data['log'] = this.log;
    data['assign_status'] = this.assignStatus;
    data['tracking_number'] = this.trackingNumber;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? id;
  int? pid;
  int? qty;
  String? price;
  Null? gst;
  int? laroOrdersId;
  String? productCode;
  String? paymentBy;
  String? total;
  Product? product;

  Details(
      {this.id,
        this.pid,
        this.qty,
        this.price,
        this.gst,
        this.laroOrdersId,
        this.productCode,
        this.paymentBy,
        this.total,
        this.product});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    qty = json['qty'];
    price = json['price'];
    gst = json['gst'];
    laroOrdersId = json['laro_orders_id'];
    productCode = json['product_code'];
    paymentBy = json['payment_by'];
    total = json['total'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['gst'] = this.gst;
    data['laro_orders_id'] = this.laroOrdersId;
    data['product_code'] = this.productCode;
    data['payment_by'] = this.paymentBy;
    data['total'] = this.total;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
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
  String? slug;
  String? pdate;
  String? updatedDate;
  int? cronjob;
  int? status;
  int? view;
  String? procode;
  String? picupstore;
  int? promotiPro;
  Null? metatitle;
  Null? metadescription;
  String? grossweight;

  Product(
      {this.id,
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
        this.slug,
        this.pdate,
        this.updatedDate,
        this.cronjob,
        this.status,
        this.view,
        this.procode,
        this.picupstore,
        this.promotiPro,
        this.metatitle,
        this.metadescription,
        this.grossweight});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    slug = json['slug'];
    pdate = json['pdate'];
    updatedDate = json['updated_date'];
    cronjob = json['cronjob'];
    status = json['status'];
    view = json['view'];
    procode = json['procode'];
    picupstore = json['picupstore'];
    promotiPro = json['promoti_pro'];
    metatitle = json['metatitle'];
    metadescription = json['metadescription'];
    grossweight = json['grossweight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['itemcode'] = this.itemcode;
    data['qty'] = this.qty;
    data['weight'] = this.weight;
    data['warehouse'] = this.warehouse;
    data['price'] = this.price;
    data['promotion'] = this.promotion;
    data['ItemDescription'] = this.itemDescription;
    data['ShortDescription'] = this.shortDescription;
    data['AltName'] = this.altName;
    data['ShortAltName'] = this.shortAltName;
    data['BrandID'] = this.brandID;
    data['SeasonID'] = this.seasonID;
    data['Idle'] = this.idle;
    data['BaseUnit'] = this.baseUnit;
    data['Scale'] = this.scale;
    data['Size'] = this.size;
    data['Year'] = this.year;
    data['DivisionID'] = this.divisionID;
    data['color'] = this.color;
    data['BarCode'] = this.barCode;
    data['CreatedOn'] = this.createdOn;
    data['UpdatedOn'] = this.updatedOn;
    data['Model'] = this.model;
    data['ItemType'] = this.itemType;
    data['mandatoryserial'] = this.mandatoryserial;
    data['useserial'] = this.useserial;
    data['FamilyID'] = this.familyID;
    data['SubFamilyID'] = this.subFamilyID;
    data['SubSubFamilyID'] = this.subSubFamilyID;
    data['TypeID'] = this.typeID;
    data['SubTypeID'] = this.subTypeID;
    data['SubSubTypeID'] = this.subSubTypeID;
    data['UDF1'] = this.uDF1;
    data['UDF2'] = this.uDF2;
    data['UDF3'] = this.uDF3;
    data['UDF4'] = this.uDF4;
    data['UDF5'] = this.uDF5;
    data['UDF6'] = this.uDF6;
    data['slug'] = this.slug;
    data['pdate'] = this.pdate;
    data['updated_date'] = this.updatedDate;
    data['cronjob'] = this.cronjob;
    data['status'] = this.status;
    data['view'] = this.view;
    data['procode'] = this.procode;
    data['picupstore'] = this.picupstore;
    data['promoti_pro'] = this.promotiPro;
    data['metatitle'] = this.metatitle;
    data['metadescription'] = this.metadescription;
    data['grossweight'] = this.grossweight;
    return data;
  }
}
