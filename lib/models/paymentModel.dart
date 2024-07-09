class PaymentModel {
  String? redirectUrl;
  String? failure;
  int? responseCode;
  String? responseMessage;

  PaymentModel(
      {this.redirectUrl,
        this.failure,
        this.responseCode,
        this.responseMessage});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    redirectUrl = json['redirect_url'];
    failure = json['failure'];
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redirect_url'] = this.redirectUrl;
    data['failure'] = this.failure;
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    return data;
  }
}
