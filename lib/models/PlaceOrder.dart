class PlaceOrder {
  int? orderId;
  String? userId;
  String? order_ids;
  int? responseCode;
  String? responseMessage;

  PlaceOrder(
      {this.orderId, this.userId, this.responseCode, this.responseMessage});

  PlaceOrder.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    order_ids=json['order_ids'];
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['order_ids']=this.order_ids;
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}
