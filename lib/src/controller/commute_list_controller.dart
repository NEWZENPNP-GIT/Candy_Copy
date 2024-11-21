import 'package:candy/src/model/attend_data_list.dart';
import 'package:candy/src/pages/commons/common.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/repository/commute_respository.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommuteListController extends GetxController {
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();

  Rx<AttendDataList> attendList = AttendDataList().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    initData();
    super.onInit();
    getAttendList();
  }

  void initData() {
    fromDate.text = DateFormat('yyyy.MM.dd')
        .format(DateTime(DateTime.now().year, DateTime.now().month, 1));
    toDate.text = DateFormat('yyyy.MM.dd').format(DateTime.now());
  }

  //데이터 호출하기
  Future<void> getAttendList() async {
    isLoading(true);
    if (!Get.isRegistered<CommuteRepository>()) {
      Get.put<CommuteRepository>(CommuteRepository());
    }

    attendList(await CommuteRepository.to.getAttendList(
        loginInfo.userId!,
        loginInfo.bizId!,
        fromDate.text.replaceAll('.', ''),
        toDate.text.replaceAll('.', '')));

    if (attendList.value.attends != null &&
        attendList.value.attends!.isNotEmpty) {
      attendList.value.attends!
          .sort(((a, b) => b.insDate!.compareTo(a.insDate!)));
    }
    isLoading(false);
  }

  String displayDate(String? value) {
    if (value == null) return '';

    return formatDate(Common.stringToDateTime(value), [yyyy, '.', mm, '.', dd],
        locale: const KoreanDateLocale());
  }

  String displayType(String? value) {
    if (value == null) return '';
    if (value == '001') return '출근/퇴근';
    if (value == '002') return '외출/복귀';
    return '';
  }

  String displayTime(String? value) {
    if (value == null) return '';

    return formatDate(Common.stringToDateTime(value), [am, ' ', hh, ':', nn],
        locale: const KoreanDateLocale());
  }
}
