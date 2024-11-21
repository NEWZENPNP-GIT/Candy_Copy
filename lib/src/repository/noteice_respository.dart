import 'dart:convert';

import 'package:candy/src/model/notice_result.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NoticeRepository extends GetConnect {
  static NoticeRepository get to => Get.find();

  late Dio _dio;

  NoticeRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: baseURL,
      connectTimeout: Duration(seconds: 5),
    ));
  }

  //공지사항 가져오기
  Future<NoticeResult> getNoticeList() async {
    var response = await _dio.get(
      '/mobile/getNoticeListCandy.do',
    );

    if (response.data is String) {
      return NoticeResult.fromJson(jsonDecode(response.data));
    } else {
      return NoticeResult.fromJson(response.data);
    }
  }

  Future<bool> updateViewCount(String bbsNo) async {
    var response =
        await _dio.post('/mobile/updateNoticeCandy.do', data: {'bbsNo': bbsNo});

    if (response.data is String) {
      return jsonDecode(response.data)['success'] as bool;
    } else {
      return response.data['success'] as bool;
    }
  }
}
