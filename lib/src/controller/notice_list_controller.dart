import 'package:candy/src/model/notice_result.dart';
import 'package:candy/src/repository/noteice_respository.dart';
import 'package:get/get.dart';

class NoticeListController extends GetxController {
  static NoticeListController get to => Get.find();

  Rx<NoticeResult> noticeList = NoticeResult().obs;

  @override
  void onInit() {
    if (!Get.isRegistered<NoticeRepository>()) {
      Get.put(NoticeRepository());
    }
    getNoticeList();
    super.onInit();
  }

  void getNoticeList() async {
    noticeList(await NoticeRepository.to.getNoticeList());
  }

  void updateVieCount(int index) async {
    await NoticeRepository.to
        .updateViewCount(noticeList.value.dataList![index].bbsNo!);
  }
}
