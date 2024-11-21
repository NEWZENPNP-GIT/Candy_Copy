import 'package:candy/src/repository/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPassController extends GetxController {
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtLoginId = TextEditingController();
  TextEditingController txtHpNum = TextEditingController();

  RxString errUserName = ''.obs;
  RxString errHpNum = ''.obs;
  RxString errLoginId = ''.obs;

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
    txtLoginId.dispose();
    super.dispose();
  }

  void initValue() {
    txtUserName.text = '';
    txtHpNum.text = '';
    txtLoginId.text = '';
    errUserName('');
    errHpNum('');
    errLoginId('');
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

    if (txtLoginId.text.isEmpty) {
      errLoginId('로그인 ID를 입력해주세요');
    } else {
      errLoginId('');
    }

    if (!txtLoginId.text.isEmail) {
      errLoginId('로그인 ID를 이메일 형식으로 입력해주세요');
    } else {
      errLoginId('');
    }

    return errUserName.value.isEmpty &&
        errHpNum.value.isEmpty &&
        errLoginId.value.isEmpty;
  }

  //암호 찾기
  Future<Map<String, dynamic>> sendInputInfo() async {
    Map<String, dynamic> result = {};

    var response = await LoginRepository.to
        .findUserPwd(txtUserName.text, txtHpNum.text, txtLoginId.text);

    if (response['success'] as bool) {
      result['success'] = true;
      result['message'] = '사용자 아이디로 비밀번호 재설정 이메일을 발송하였습니다.';
    } else {
      result['success'] = false;
      result['message'] = '입력하신 계정이 존재하지 않습니다.';
    }
    return result;
  }
}
