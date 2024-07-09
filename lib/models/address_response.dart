class AddressResponse {
  Data? data;
  int? responseCode;
  String? responseMessage;

  AddressResponse({this.data, this.responseCode, this.responseMessage});

  AddressResponse.fromJson(Map<String, dynamic> json) {
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
  List<AddressData>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(AddressData.fromJson(v));
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
