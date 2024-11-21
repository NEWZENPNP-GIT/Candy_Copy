import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/repository/mypage_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassController extends GetxController {
  TextEditingController txtNowPassword = TextEditingController();
  TextEditingController txtChangePassword = TextEditingController();
  TextEditingController txtChangeRePassword = TextEditingController();

  RxString errNowPassword = ''.obs;
  RxString errChangePassword = ''.obs;
  RxString errChangeRePassword = ''.obs;

  @override
  void onInit() {
    if (!Get.isRegistered<MypageRepository>()) {
      Get.put(MypageRepository());
    }
    initValue();
    super.onInit();
  }

  @override
  void dispose() {
    txtNowPassword.dispose();
    txtChangePassword.dispose();
    txtChangeRePassword.dispose();
    super.dispose();
  }

  void initValue() {
    txtNowPassword.text = '';
    txtChangePassword.text = '';
    txtChangeRePassword.text = '';
    errNowPassword('');
    errChangePassword('');
    errChangeRePassword('');
  }

  bool checkValidation() {
    if (txtNowPassword.text.isEmpty) {
      errNowPassword('이전 비밀번호를 입력해 주세요');
    } else {
      errNowPassword('');
    }

    if (txtChangePassword.text.isEmpty) {
      errChangePassword('변경 비밀번호를 입력해 주세요');
    } else {
      errChangePassword('');
    }

    if (txtChangePassword.text.isNotEmpty &&
        (txtChangePassword.text.length < 6 ||
            txtChangePassword.text.length > 16)) {
      errChangePassword("비밀번호를 (6~15)자리이내로 입력해 주세요");
    }

    if (txtChangePassword.text.isNotEmpty &&
        txtNowPassword.text.isNotEmpty &&
        txtChangePassword.text == txtNowPassword.text) {
      errChangePassword("이전 비밀번호와 새 비밀번호가 같습니다.");
    }

    if (txtChangeRePassword.text.isEmpty) {
      errChangeRePassword('비밀번호 확인을 입력해 주세요');
    } else {
      errChangeRePassword('');
    }

    if (txtChangePassword.text != txtChangeRePassword.text) {
      errChangeRePassword('입력된 암호가 일치 하지 않습니다.');
    } else {
      errChangeRePassword('');
    }

    return errNowPassword.value.isEmpty &&
        errChangePassword.value.isEmpty &&
        errChangeRePassword.value.isEmpty;
  }

  //암호 찾기
  Future<Map<String, dynamic>> sendInputInfo() async {
    Map<String, dynamic> result = {};

    var response = await MypageRepository.to.pwdChange(
        loginInfo.loginId!, txtNowPassword.text, txtChangePassword.text);

    result['success'] = response['success'];
    result['message'] = response['message'];

    return result;
  }
}
