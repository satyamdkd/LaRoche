abstract class ApiResults {}

class ApiSuccess extends ApiResults {
  ApiSuccess(this.data, this.statusCode);
  dynamic data;
  int? statusCode;
}

class ApiFailure extends ApiResults {
  ApiFailure(this.message);
  String message;
}