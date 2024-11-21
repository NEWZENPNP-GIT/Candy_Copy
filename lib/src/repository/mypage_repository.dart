import 'dart:convert';

import 'package:candy/src/pages/commons/constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MypageRepository extends GetConnect {
  static MypageRepository get to => Get.find();

  late Dio _dio;

  MypageRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: baseURL,
      connectTimeout: Duration(seconds: 5),
    ));
  }

  //MYPAGE 내용 가져오기
  Future<Map<String, dynamic>> getMyPage(
      String userId, String bizId, String loginId) async {
    var response = await _dio.get('/mypage/getMyPageFlutter.do',
        queryParameters: {
          'userId': userId,
          'bizId': bizId,
          'loginId': loginId
        });

    if (response.data is String) {
      return jsonDecode(response.data);
    } else {
      return response.data;
    }
  }

  Future<Map<String, dynamic>> pwdChange(
      String loginId, String prevUserPwd, String userPwd) async {
    var response = await _dio.post('/mypage/pwdChangeFlutter.do', data: {
      'userId': loginId,
      'prevUserPwd': prevUserPwd,
      'userPwd': userPwd
    });

    if (response.data is String) {
      return jsonDecode(response.data);
    } else {
      return response.data;
    }
  }
}
