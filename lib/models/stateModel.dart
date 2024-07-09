class StateModel {
  Data? data;
  int? responseCode;
  String? responseMessage;

  StateModel({this.data, this.responseCode, this.responseMessage});

  StateModel.fromJson(Map<String, dynamic> json) {
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
  List<State>? state;

  Data({this.state});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      state = <State>[];
      json['data'].forEach((v) {
        state!.add(State.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (state != null) {
      data['data'] = state!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class State {
  String? id;
  String? name;
  String? countryId;
  String? shipingtype;
  String? status;
  String? view;

  State(
      {this.id,
      this.name,
      this.countryId,
      this.shipingtype,
      this.status,
      this.view});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    shipingtype = json['shipingtype'];
    status = json['status'];
    view = json['view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = countryId;
    data['shipingtype'] = shipingtype;
    data['status'] = status;
    data['view'] = view;
    return data;
  }
}
