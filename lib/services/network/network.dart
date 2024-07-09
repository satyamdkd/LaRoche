import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:laroch/utils/widgets/dialogs/dailog.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../const/urls.dart';
import 'api_result.dart';

typedef OnSentProgress = void Function(int sent, int total, double percentage);

class API {
  final dio.Dio _dio;
  final String? token;
  final String? base2;
  final String? base2url;
  static const String _baseUrl = URLs.baseURl;

  API({this.token,this.base2,this.base2url}) : _dio = dio.Dio() {
    _dio.options.baseUrl = base2==null?_baseUrl:"https://larochenigeria.com/shop/";
    _dio.interceptors.add(PrettyDioLogger());
    if (token != null) {
      _dio.interceptors.add(
        dio.InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers['Authorization'] = 'Bearer $token';
            return handler.next(options);
          },
        ),
      );
    }
  }

  Future get<T>(String path,
      {Map<String, dynamic>? queryParameters, BuildContext? context}) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        if (context != null) {
          Future.delayed(Duration.zero, () {
            errorDialog(message: "Something went wrong!", context: context);
          });
        }
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Request failed with status code ${e.response!.statusCode}',
        );
      } else {
        throw Exception('Failed to make the request: ${e.type}');
      }
    }
  }


  Future postRaw<T>(String path,
      {Map<String, dynamic>? queryParameters, BuildContext? context}) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: queryParameters,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        if (context != null) {
          Future.delayed(Duration.zero, () {
            errorDialog(message: "Something went wrong!", context: context);
          });
        }
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Request failed with status code ${e.response!.statusCode}',
        );
      } else {
        throw Exception('Failed to make the request: ${e.type}');
      }
    }
  }
  
  Future post<T>(
    String path, {
    dynamic data,
    BuildContext? context,
  }) async {
    if (kDebugMode) {
      print(data);
    }

    try {
      final response = await _dio.post<T>(
        path,
        data: dio.FormData.fromMap(data ?? {}),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        if (context != null) {
          Future.delayed(Duration.zero, () {
            errorDialog(message: "Something went wrong!", context: context);
          });
        }
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            'Request failed with status code ${e.response!.statusCode}');
      } else {
        throw Exception('Failed to make the request: $e');
      }
    } catch (e) {
      debugPrint("$e--> From api class");

      if (context != null) {
        Future.delayed(Duration.zero, () {
          errorDialog(message: "Something went wrong!", context: context);
        });
      }
    }
  }

  Future<ApiResults> postDataWithFile({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool formData = true,
    String? token,
    OnSentProgress? onSentProgress,
  }) async {
    try {
      if (kDebugMode) {
        print(dio.FormData.fromMap(data ?? {}));
      }
      final response = await _dio.post(
        endPoint,
        queryParameters: queryParameters,
        data: formData ? dio.FormData.fromMap(data ?? {}) : data,
      );

      debugPrint(response.toString());

      return ApiSuccess(
        jsonDecode(response.data.toString()),
        response.statusCode,
      );
    } on SocketException {
      return ApiFailure('Socket Exception');
    } on FormatException {
      return ApiFailure('Format Exception');
    } on dio.DioException catch (e) {
      if (e.type == dio.DioExceptionType.badResponse) {
        return ApiFailure(e.message ?? 'Something went wrong!');
      } else if (e.type == dio.DioExceptionType.connectionTimeout) {
        return ApiFailure('Connection Timeout');
      } else if (e.type == dio.DioExceptionType.receiveTimeout) {
        return ApiFailure('Receive Timeout');
      } else {
        return ApiFailure('Unknown Exception');
      }
    }
  }
}
