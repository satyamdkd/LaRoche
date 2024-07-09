class RegisterResponse {
  int? userId;
  int? responseCode;
  String? responseMessage;

  RegisterResponse({this.userId, this.responseCode, this.responseMessage});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['responseCode'] = responseCode;
    data['responseMessage'] = responseMessage;
    return data;
  }
}
