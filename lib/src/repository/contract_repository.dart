import 'dart:convert';

import 'package:candy/src/model/contract_data_list.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ContractRepository extends GetConnect {
  static ContractRepository get to => Get.find();

  late Dio _dio;

  ContractRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: baseURL,
      connectTimeout: Duration(seconds: 5),
    ));
  }

  //계약리스트 가져오기
  Future<ContractDataList> getContractList(String userId, String bizId) async {
    var response = await _dio.get(
        '/contract/getContractListFlutter.do?userId=$userId&bizId=$bizId&startPage=0&endPage=99999&statusCode=Y&sortName=CONTRACT_DATE&sortOrder=DESC');

    if (response.data is String) {
      return ContractDataList.fromJson(jsonDecode(response.data));
    } else {
      return ContractDataList.fromJson(response.data);
    }
  }
}
