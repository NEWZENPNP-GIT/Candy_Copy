import 'dart:convert';

import 'package:candy/src/model/login_info.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginRepository extends GetConnect {
  static LoginRepository get to => Get.find();

  late Dio _dio;

  LoginRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: baseURL,
      connectTimeout: Duration(seconds: 5),
    ));
  }

  //로그인
  Future<LoginInfo> getLogin(String loginId, String userPwd) async {
    var response = await _dio.post('/loginFlutter.do', data: {
      'userId': loginId,
      'userPwd': userPwd,
    });

    if (response.data is String) {
      return LoginInfo.fromJson(jsonDecode(response.data));
    } else {
      return LoginInfo.fromJson(response.data);
    }
  }

  //아이디 찾기
  Future<Map<String, dynamic>> findUserId(
      String userName, String phoneNum) async {
    var response = await _dio.get('/user/findUserId.do', queryParameters: {
      'userName': userName,
      'phoneNum': phoneNum.replaceAll('-', ''),
    });

    if (response.data is String) {
      return jsonDecode(response.data);
    } else {
      return response.data;
    }
  }

  //암호 찾기
  Future<Map<String, dynamic>> findUserPwd(
      String userName, String phoneNum, String userId) async {
    var response = await _dio.get('/user/findUserPwd.do', queryParameters: {
      'userName': userName,
      'userId': userId,
      'phoneNum': phoneNum.replaceAll('-', ''),
    });

    if (response.data is String) {
      return jsonDecode(response.data);
    } else {
      return response.data;
    }
  }
}
