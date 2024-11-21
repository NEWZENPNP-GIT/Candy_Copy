import 'package:candy/src/model/payment.dart';
import 'package:candy/src/model/payment_list_data.dart';
import 'package:candy/src/pages/commons/common.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/payment/password_check.dart';
import 'package:candy/src/repository/paystub_repository.dart';
import 'package:get/get.dart';

class PaymentListController extends GetxController {
  Rx<PaymentDataList> paymentList = PaymentDataList().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (!Get.isRegistered<PaystubRepository>()) {
      Get.put(PaystubRepository());
    }
    getPaymentList();
    super.onInit();
  }

  Future<void> getPaymentList() async {
    isLoading(true);

    paymentList(await PaystubRepository.to
        .getPayStubList(loginInfo.userId!, loginInfo.bizId!));

    List<Payment> paymentListData = [];

    //pay
    if (paymentList.value.items != null) {
      for (var payment in paymentList.value.items!) {
        if (payment.transType != null && payment.transType == "Y") {
          paymentListData.add(payment);
        }
      }
    }

    paymentList.update((val) {
      val!.items = paymentListData;
    });

    isLoading(false);
  }

  Future<String> goPdfView(String fileId) async {
    return await PaystubRepository.to
        .getPdfFileUrl(fileId, loginInfo.bizId!, loginInfo.userId!);
  }

  Future<Map<String, dynamic>> gotoView(int index) async {
    String fileUrl = await goPdfView(paymentList.value.items![index].fileId!);
    Map<String, dynamic> returnMap = {
      'success': false,
      'message': '',
      'fileUrl': ''
    };

    print(fileUrl);
    print(paymentList.value.items![index].fileId!);

    bool value = false;

    if (loginInfo.isPaystubPassword == null ||
        loginInfo.isPaystubPassword!.isEmpty ||
        loginInfo.isPaystubPassword! == 'Y') {
      if (await Common.gotoLocalAuth(false)) {
        value = true;
      } else {
        value = await PasswordCheck().show();
      }

      if (value) {
        if (fileUrl.isNotEmpty) {
          returnMap['success'] = true;
          returnMap['fileUrl'] = '$baseURL$fileUrl';
        } else {
          returnMap['success'] = false;
          returnMap['message'] = '서버에 파일이 없습니다.';
        }
      } else {
        returnMap['success'] = false;
        returnMap['message'] = '';
      }
    } else {
      returnMap['success'] = true;
      returnMap['fileUrl'] = '$baseURL$fileUrl';
    }
    print(returnMap.toString());
    return returnMap;
  }
}
