import 'package:dio/dio.dart';

class DioHelper {
  static const String _API_KEY = 'AIzaSyDRjwxBQ_PR_pjTDqQTocNnFBHhZrCT6uA';
  static const String _BASE_URL =
      'https://identitytoolkit.googleapis.com/v1/accounts:';

  static Dio _dio = Dio()..options.validateStatus = (v) => v! < 500;

  static Future<Response<dynamic>> post(String path, {dynamic data}) async =>
      await _dio.post(_BASE_URL + path + '?key=' + _API_KEY, data: data);
}
