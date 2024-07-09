class CartItems {
  Data? data;
  int? responseCode;
  String? responseMessage;

  CartItems({this.data, this.responseCode, this.responseMessage});

  CartItems.fromJson(Map<String, dynamic> json) {
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
  List<CartItem>? cartItem;
  int? priceOldPrice;
  int? total;
  int? savings;

  Data({this.cartItem, this.priceOldPrice, this.total, this.savings});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      cartItem = <CartItem>[];
      json['data'].forEach((v) {
        cartItem!.add(CartItem.fromJson(v));
      });
    }
    priceOldPrice = json['price_old_price'];
    total = json['total'];
    savings = json['savings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartItem != null) {
      data['data'] = cartItem!.map((v) => v.toJson()).toList();
    }
    data['price_old_price'] = priceOldPrice;
    data['total'] = total;
    data['savings'] = savings;
    return data;
  }
}

class CartItem {
  String? id;
  String? userid;
  String? qty;
  String? price;
  String? proId;
  String? proname;
  String? image;
  String? imageid;
  String? pricesOff;
  String? priceOldPrice;
  String? date;
  String? total;
  String? status;
  String? view;

  CartItem(
      {this.id,
      this.userid,
      this.qty,
      this.price,
      this.proId,
      this.proname,
      this.image,
      this.imageid,
      this.pricesOff,
      this.priceOldPrice,
      this.date,
      this.total,
      this.status,
      this.view});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    qty = json['qty'];
    price = json['price'];
    proId = json['pro_id'];
    proname = json['proname'];
    image = json['image_url'];
    imageid = json['imageid'];
    pricesOff = json['prices_off'];
    priceOldPrice = json['price_old_price'];
    date = json['date'];
    total = json['total'];
    status = json['status'];
    view = json['view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userid'] = userid;
    data['qty'] = qty;
    data['price'] = price;
    data['pro_id'] = proId;
    data['proname'] = proname;
    data['image_url'] = image;
    data['imageid'] = imageid;
    data['prices_off'] = pricesOff;
    data['price_old_price'] = priceOldPrice;
    data['date'] = date;
    data['total'] = total;
    data['status'] = status;
    data['view'] = view;
    return data;
  }
}
