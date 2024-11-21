import 'dart:convert';

import 'package:candy/src/model/attend_data_list.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeRepository extends GetConnect {
  static HomeRepository get to => Get.find();

  late Dio _dio;

  HomeRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: baseURL,
      connectTimeout: Duration(seconds: 5),
    ));
  }

  //출퇴근정보가지고오기
  Future<AttendDataList> getAttendList(String userId, String bizId) async {
    var response = await _dio.get(
        '/attend/getAttendListFlutter.do?userId=$userId&bizId=$bizId&startPage=0&endPage=99999');

    if (response.data is String) {
      return AttendDataList.fromJson(jsonDecode(response.data));
    } else {
      return AttendDataList.fromJson(response.data);
    }
  }

  //메인정보가지고고이
  Future<Map<String, dynamic>> getMainInfo(
      String userId, String bizId, String loginId) async {
    var response = await _dio.get(
        '/mobile/mainFlutter.do?userId=$userId&bizId=$bizId&loginId=$loginId');

    if (response.data is String) {
      return jsonDecode(response.data);
    } else {
      return response.data;
    }
  }

  //사용자 DIVCE 저장
  Future<bool> setUserDevice(String userId, String deviceId, String pushToken,
      String model, String osType, String osVersion) async {
    var response = await _dio.post('/user/insDeviceFlutter.do', data: {
      'userId': userId,
      'deviceId': deviceId,
      'pushToken': pushToken,
      'model': model,
      'osType': osType,
      'osVersion': osVersion,
    });
    return response.data['success'];
  }
}
