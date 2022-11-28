import 'package:dio/dio.dart';
import 'package:elbahreen/constants/end_points.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Accept':'application/json',
      'Content-Type': 'application/json;multipart/form-data',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> body,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
    };
    return await dio!.post(url, data: body);
  }
}
