import 'dart:convert';

import 'package:candy/src/model/company_data_list.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class JoinRepository extends GetConnect {
  static JoinRepository get to => Get.find();

  late Dio _dio;

  JoinRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: baseURL,
      connectTimeout: Duration(seconds: 5),
    ));
  }

  //회원아이디 확인
  Future<int> getUserIdList(String userId) async {
    var response = await _dio.get('/user/getUserList.do?userId=$userId');

    if (response.data is String) {
      return jsonDecode(response.data)["total"] as int;
    } else {
      return response.data["total"] as int;
    }
  }

  //회사 검색
  Future<CompanyDataList> getBizNameList(String bizName) async {
    var response = await _dio
        .get('/biz/findBiz.do?bizName=$bizName&startPage=0&endPage=100');

    if (response.data is String) {
      return CompanyDataList.fromJson(jsonDecode(response.data));
    } else {
      return CompanyDataList.fromJson(response.data);
    }
  }

  //직원검색
  Future<Map<String, dynamic>> getCertEmp(
      String bizId, String userDate, String empName, String phoneNumber) async {
    var response = await _dio.post('/user/getCertEmpforFlutter.do', data: {
      'bizId': bizId,
      'userDate': userDate.replaceAll('-', ''),
      'empName': empName,
      'phoneNum': phoneNumber.replaceAll('-', ''),
    });

    if (response.data is String) {
      return jsonDecode(response.data);
    } else {
      return response.data;
    }
  }

  //인증번호발송
  Future<Map<String, dynamic>> sendCertNumber(
      String bizId, String userId) async {
    var response = await _dio.post('/user/insUserJoinCertForFlutter.do', data: {
      'bizId': bizId,
      'userId': userId,
    });

    if (response.data is String) {
      return jsonDecode(response.data);
    } else {
      return response.data;
    }
  }

  //인증번호확인
  Future<Map<String, dynamic>> checkCertNumber(
      String phoneNum, String certNo) async {
    var response = await _dio.get('/user/getUserJoinCert.do', queryParameters: {
      'phonNo': phoneNum.replaceAll('-', ''),
      'certNo': certNo,
    });

    if (response.data is String) {
      return jsonDecode(response.data);
    } else {
      return response.data;
    }
  }

  //회원가입
  Future<Map<String, dynamic>> saveMemberJoin(
      String loginId, String userId, String userPwd, String userName) async {
    var response = await _dio.post('/user/insUserforFlutter.do', data: {
      'userId': userId,
      'loginId': loginId,
      'userType': '1',
      'userName': userName,
      'userPwd': userPwd,
    });

    if (response.data is String) {
      return jsonDecode(response.data);
    } else {
      return response.data;
    }
  }
}
