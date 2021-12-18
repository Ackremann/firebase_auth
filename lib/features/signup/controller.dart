import 'package:dio/dio.dart';
import 'package:firebase_auth/core/app_storage/app_storage.dart';
import 'package:firebase_auth/core/dio_helper/dio_helper.dart';
import 'package:flutter/cupertino.dart';

class SignupController {
  bool loasding = false;
  late String email;
  late String password;
  final formKey = GlobalKey<FormState>();

  Future<String?> SignUp() async {
    if (!formKey.currentState!.validate()) return null;
    formKey.currentState!.save();
    final body = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };
    try {
      final response = await DioHelper.post('signUp', data: body);
      if (response.statusCode == 200) {
        await AppStorage.cachUserData(
          email: response.data['email'],
          apiToken: response.data['idToken'],
          uid: response.data['localId'],
        );
        return 'ok';
      } else {
        return response.data['error']['message'];
      }
    } on DioError catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
