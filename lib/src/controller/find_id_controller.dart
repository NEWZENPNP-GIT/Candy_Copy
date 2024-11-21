import 'package:candy/src/repository/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindIdController extends GetxController {
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtHpNum = TextEditingController();

  RxString errUserName = ''.obs;
  RxString errHpNum = ''.obs;

  @override
  void onInit() {
    if (!Get.isRegistered<LoginRepository>()) {
      Get.put(LoginRepository());
    }
    initValue();
    super.onInit();
  }

  @override
  void dispose() {
    txtUserName.dispose();
    txtHpNum.dispose();
    super.dispose();
  }

  void initValue() {
    txtUserName.text = '';
    txtHpNum.text = '';
    errUserName('');
    errHpNum('');
  }

  bool checkValidation() {
    if (txtUserName.text.isEmpty) {
      errUserName('사용자성명을 입력해주세요');
    } else {
      errUserName('');
    }

    if (txtHpNum.text.isEmpty) {
      errHpNum('휴대폰 번호를 입력해주세요');
    } else {
      errHpNum('');
    }

    return errUserName.value.isEmpty && errHpNum.value.isEmpty;
  }

  //아이디 찾기
  Future<Map<String, dynamic>> sendInputInfo() async {
    Map<String, dynamic> result = {};

    var response =
        await LoginRepository.to.findUserId(txtUserName.text, txtHpNum.text);

    if (response['success'] as bool) {
      result['success'] = true;
      result['count'] = (response['total'] as int);
      if (result['count'] == 1) {
        result['message'] = '등록된 ID는 ${response['data'][0]['userId']} 입니다.';
      } else {
        result['data'] = response['data'];
        result['message'] = "여러회사가 등록되어 있습니다.";
      }
    } else {
      result['success'] = false;
      result['count'] = 0;
      result['message'] = '입력하신 계정이 존재하지 않습니다.';
    }
    return result;
  }
}
