import 'dart:convert';

import 'package:candy/src/model/attend_data_list.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CommuteRepository extends GetConnect {
  static CommuteRepository get to => Get.find();

  late Dio _dio;

  CommuteRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        connectTimeout: Duration(seconds: 5),
      ),
    );
  }

  //근태리스트 가져오기
  Future<AttendDataList> getAttendList(
      String userId, String bizId, String? startDate, String? endDate) async {
    String finalUrl = '';
    finalUrl =
        '/attend/getAttendListFlutter.do?userId=$userId&bizId=$bizId&startPage=0&endPage=99999';

    if (startDate != null) {
      finalUrl += '&startDate=${startDate.replaceAll('-', '')}';
    }

    if (endDate != null) {
      finalUrl += '&endDate=${endDate.replaceAll('-', '')}';
    }

    var response = await _dio.get(finalUrl);

    if (response.data is String) {
      return AttendDataList.fromJson(jsonDecode(response.data));
    } else {
      return AttendDataList.fromJson(response.data);
    }
  }

  //출퇴근등록
  Future<Map<String, dynamic>> insAttend(
      String bizId, String userId, String attendCode,
      {double latitude = 0.0, double longitude = 0.0}) async {
    var response = await _dio.post('/attend/insAttendFlutter.do', data: {
      'bizId': bizId,
      'userId': userId,
      'attendCode': attendCode,
      'latitude': latitude,
      'longitude': longitude,
    });

    if (response.data is String) {
      return jsonDecode(response.data);
    } else {
      return response.data;
    }
  }

  Future<bool> offAttend(
      String bizId, String userId, String attendCode, String attendId,
      {double latitude = 0.0, double longitude = 0.0}) async {
    var response = await _dio.post('/attend/offAttendFlutter.do', data: {
      'bizId': bizId,
      'userId': userId,
      'attendId': attendId,
      'attendCode': attendCode,
      'latitude': latitude,
      'longitude': longitude,
    });

    if (response.data is String) {
      return jsonDecode(response.data)['success'];
    } else {
      return response.data['success'];
    }
  }
}
