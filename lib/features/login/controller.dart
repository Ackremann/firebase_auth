import 'package:dio/dio.dart';
import 'package:firebase_auth/core/app_storage/app_storage.dart';
import 'package:firebase_auth/core/dio_helper/dio_helper.dart';
import 'package:flutter/material.dart';

class LogInController {
  late String email;
  late String password;
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  Future<String?> SignIn() async {
    if (!formKey.currentState!.validate()) {
      return null;
    }
    formKey.currentState!.save();
    final body = {
      'email': email,
      'password': password,
      "returnSecureToken": true
    };
    try {
      final respone = await DioHelper.post(
        'signInWithPassword',
        data: body,
      );
      if (respone.statusCode == 200 && respone.data['registered']) {
        await AppStorage.cachUserData(
          email: respone.data['email'],
          apiToken: respone.data['idToken'],
          uid: respone.data['localId'],
        );
        return 'ok';
      } else {
        return respone.data['error']['message'];
      }
    } on DioError catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
