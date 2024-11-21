import 'package:get/get.dart';

class Join01Controller extends GetxController {
  RxBool isAllAgreement = false.obs;
  RxBool isAgreenment01 = false.obs;
  RxBool isAgreenment02 = false.obs;
  RxBool isAgreenment03 = false.obs;
  RxBool isAgreenment04 = false.obs;

  //전체 약관 동의
  void setAllAgreemnet(bool checked) {
    isAllAgreement(checked);
    isAgreenment01(checked);
    isAgreenment02(checked);
    isAgreenment03(checked);
    isAgreenment04(checked);
  }

  //각자의 약관 동의
  void setIsAll(bool checked) {
    isAllAgreement(isAgreenment01.value &&
        isAgreenment02.value &&
        isAgreenment03.value &&
        isAgreenment04.value);
  }
}
