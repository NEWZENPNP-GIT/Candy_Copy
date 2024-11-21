import 'package:candy/src/model/login_info.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/repository/login_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContractPasswordCheckController extends GetxController {
  TextEditingController txtPassword = TextEditingController();
  RxString errorMsg = ''.obs;

  @override
  void onInit() {
    if (!Get.isRegistered<LoginRepository>()) {
      Get.put(LoginRepository());
    }
    initValue();
    super.onInit();
  }

  void initValue() {
    txtPassword.text = '';
    errorMsg('');
  }

  bool checkValidation() {
    if (txtPassword.text.isEmpty) {
      errorMsg('암호를 입력해 주세요');
    } else {
      errorMsg('');
    }

    return errorMsg.value.isEmpty;
  }

  //패스워드 확인
  Future<bool> sendInputInfo() async {
    LoginInfo passwordInfo =
        await LoginRepository.to.getLogin(loginInfo.loginId!, txtPassword.text);

    return passwordInfo.success!;
  }
}
