import 'dart:convert';

import 'package:candy/src/model/payment_list_data.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PaystubRepository extends GetConnect {
  static PaystubRepository get to => Get.find();

  late Dio _dio;

  PaystubRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: baseURL,
      connectTimeout: Duration(seconds: 5),
    ));
  }

  //급여리스트 가져오기
  Future<PaymentDataList> getPayStubList(String userId, String bizId) async {
    var response = await _dio.get(
        '/paystub/getPayStubListFlutter.do?userId=$userId&bizId=$bizId&startPage=0&endPage=99999&sortName=PAY_DATE&sortOrder=DESC');

    if (response.data is String) {
      return PaymentDataList.fromJson(jsonDecode(response.data));
    } else {
      return PaymentDataList.fromJson(response.data);
    }
  }

  Future<String> getPdfFileUrl(
      String fileId, String bizId, String userId) async {
    var response =
        await _dio.get('/mobile/getPayStubPDFView.do', queryParameters: {
      'fileId': fileId,
      'bizId': bizId,
      'userId': userId,
      'type': 'pdf',
    });

    String urls = '';
    bool bResponse = false;
    Map<String, dynamic> returnValues;

    if (response.data is String) {
      returnValues = jsonDecode(response.data);
    } else {
      returnValues = response.data;
    }

    bResponse = returnValues['success'] as bool;

    if (bResponse) {
      urls = returnValues['data']['pdfFile'];
    }

    return urls;
  }
}
