class CheckOutModel {
  Data? data;
  List<AddressData>? addressData;
  Weekdays? weekdays;
  Outofdelevery? outofdelevery;
  int? responseCode;
  String? responseMessage;

  CheckOutModel(
      {this.data,
      this.addressData,
      this.weekdays,
      this.outofdelevery,
      this.responseCode,
      this.responseMessage});

  CheckOutModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['address_data'] != null && json['address_data'] != false) {
      addressData = <AddressData>[];
      json['address_data'].forEach((v) {
        addressData!.add(AddressData.fromJson(v));
      });
    }else{
      addressData = null;
    }
    weekdays = json['weekdays'] != null && json['weekdays'] != false
        ? Weekdays.fromJson(json['weekdays'])
        : null;
    outofdelevery = json['outofdelevery'] != null && json['outofdelevery'] != false
        ? Outofdelevery.fromJson(json['outofdelevery'])
        : Outofdelevery(shippingcost: "-");
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (addressData != null) {
      data['address_data'] = addressData!.map((v) => v.toJson()).toList();
    }
    if (weekdays != null) {
      data['weekdays'] = weekdays!.toJson();
    }
    if (outofdelevery != null) {
      data['outofdelevery'] = outofdelevery!.toJson();
    }
    data['responseCode'] = responseCode;
    data['responseMessage'] = responseMessage;
    return data;
  }
}

class Data {
  List<Details>? data;
  String? priceOldPrice;
  String? total;
  String? savings;
  String? weight;

  Data({this.data, this.priceOldPrice, this.total, this.savings, this.weight});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Details>[];
      json['data'].forEach((v) {
        data!.add(Details.fromJson(v));
      });
    }
    priceOldPrice = json['price_old_price'].toString();
    total = json['total'].toString();
    savings = json['savings'].toString();
    weight = json['weight'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['price_old_price'] = priceOldPrice;
    data['total'] = total;
    data['savings'] = savings;
    data['weight'] = weight;
    return data;
  }
}

class Details {
  String? id;
  String? userid;
  String? qty;
  String? price;
  String? proId;
  String? weight;
  String? promotion;
  String? itemDescription;
  String? proname;
  String? image;
  String? imageid;
  String? pricesOff;
  String? priceOldPrice;
  String? date;
  String? total;
  String? status;
  String? view;
  String?  picupstore;
  String? imageUrl;

  Details(
      {this.id,
      this.userid,
      this.qty,
      this.price,
      this.proId,
      this.weight,
      this.promotion,
      this.itemDescription,
      this.proname,
      this.image,
      this.imageid,
      this.pricesOff,
      this.priceOldPrice,
      this.date,
      this.total,
      this.status,
      this.view,
        this.picupstore,
      this.imageUrl});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    qty = json['qty'];
    price = json['price'];
    proId = json['pro_id'];
    weight = json['weight'];
    promotion = json['promotion'];
    itemDescription = json['itemDescription'];
    proname = json['proname'];
    image = json['image'];
    imageid = json['imageid'];
    pricesOff = json['prices_off'];
    priceOldPrice = json['price_old_price'];
    date = json['date'];
    total = json['total'];
    status = json['status'];
    view = json['view'];
    picupstore=json['picupstore'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['qty'] = qty;
    data['price'] = price;
    data['pro_id'] = proId;
    data['weight'] = weight;
    data['promotion'] = promotion;
    data['itemDescription'] = itemDescription;
    data['proname'] = proname;
    data['image'] = image;
    data['imageid'] = imageid;
    data['prices_off'] = pricesOff;
    data['price_old_price'] = priceOldPrice;
    data['date'] = date;
    data['total'] = total;
    data['status'] = status;
    data['view'] = view;
    data['picupstore']=picupstore;
    data['image_url'] = imageUrl;
    return data;
  }
}

class AddressData {
  String? id;
  String? userId;
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
  String? email;
  String? date;
  String? status;
  String? view;
  String? defaultView;

  AddressData(
      {this.id,
      this.userId,
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
      this.email,
      this.date,
      this.status,
      this.view,
      this.defaultView});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
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
    email = json['email'];
    date = json['date'];
    status = json['status'];
    view = json['view'];
    defaultView = json['default_view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['last_name'] = lastName;
    data['pincode'] = pincode;
    data['address'] = address;
    data['apartment'] = apartment;
    data['city'] = city;
    data['state'] = state;
    data['banches'] = banches;
    data['country'] = country;
    data['mobile_no'] = mobileNo;
    data['email'] = email;
    data['date'] = date;
    data['status'] = status;
    data['view'] = view;
    data['default_view'] = defaultView;
    return data;
  }
}

class Weekdays {
  String? weekdays;
  String? monthsdays;

  Weekdays({this.weekdays, this.monthsdays});

  Weekdays.fromJson(Map<String, dynamic> json) {
    weekdays = json['weekdays'];
    monthsdays = json['monthsdays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weekdays'] = weekdays;
    data['monthsdays'] = monthsdays;
    return data;
  }
}

class Outofdelevery {
  String? shippingcost;

  Outofdelevery({this.shippingcost});

  Outofdelevery.fromJson(Map<String, dynamic> json) {
    shippingcost = json['shippingcost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shippingcost'] = shippingcost;
    return data;
  }
}
