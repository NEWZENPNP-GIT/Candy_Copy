import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/repository/mypage_repository.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class MyPageController extends GetxController {
  RxMap<String, dynamic> myPageData = RxMap<String, dynamic>({});
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (!Get.isRegistered<MypageRepository>()) {
      Get.put(MypageRepository());
    }
    getMyPageInfo();
    super.onInit();
  }

  Future<void> getMyPageInfo() async {
    isLoading(true);
    var result = await MypageRepository.to
        .getMyPage(loginInfo.userId!, loginInfo.bizId!, loginInfo.loginId!);

    if (result['total'] as int == 1) {
      myPageData((result['data']).first);
    }
    isLoading(false);
  }

  Future<bool> canLocalAuth() async {
    return await LocalAuthentication().canCheckBiometrics;
  }
}
