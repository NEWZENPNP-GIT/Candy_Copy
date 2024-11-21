import 'dart:async';

import 'package:candy/src/model/attend_data.dart';
import 'package:candy/src/model/attend_data_list.dart';
import 'package:candy/src/pages/commons/common.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/repository/commute_respository.dart';
import 'package:date_format/date_format.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CommuteController extends GetxController {
  Rx<DateTime> dateTimeNow = DateTime.now().obs;
  Rx<AttendDataList> attendList = AttendDataList().obs;
  RxBool isLoading = false.obs;
  Rx<AttendData> attendData = AttendData().obs;
  RxList attendDataHistory = [].obs;

  RxString dateFrom = ''.obs;
  RxString dateTo = ''.obs;

  @override
  void onInit() {
    //시간 단위처리
    Timer.periodic(const Duration(minutes: 1), (v) {
      dateTimeNow(DateTime.now()); // or BinaryTime see next step
    });
    super.onInit();
  }

  //데이터 호출하기
  Future<void> getAttendList() async {
    isLoading(true);
    if (!Get.isRegistered<CommuteRepository>()) {
      Get.put<CommuteRepository>(CommuteRepository());
    }

    attendList(await CommuteRepository.to
        .getAttendList(loginInfo.userId!, loginInfo.bizId!, null, null));

    if (attendList.value.attends != null &&
        attendList.value.attends!.isNotEmpty) {
      attendList.value.attends!
          .sort(((a, b) => b.insDate!.compareTo(a.insDate!)));
    }

    //출/퇴근, 외출 복귀 형태를 -> 하나씩 처리
    attendDataHistory.clear();
    if (attendList.value.attends != null &&
        attendList.value.attends!.isNotEmpty) {
      for (var item in attendList.value.attends!) {
        if (item.attendCode == '001' && item.dateFrom!.isNotEmpty) {
          attendDataHistory
              .add({"title": "출근", "time": displayTime(item.dateFrom!)});
        }

        if (item.attendCode != '001' && item.dateFrom!.isNotEmpty) {
          attendDataHistory
              .add({"title": "외출", "time": displayTime(item.dateFrom!)});
        }

        if (item.attendCode == '001' &&
            item.dateTo != null &&
            item.dateTo!.isNotEmpty) {
          attendDataHistory
              .add({"title": "퇴근", "time": displayTime(item.dateTo!)});
        }

        if (item.attendCode != '001' &&
            item.dateTo != null &&
            item.dateTo!.isNotEmpty) {
          attendDataHistory
              .add({"title": "복귀", "time": displayTime(item.dateTo!)});
        }
      }

      if (attendDataHistory.length > 0) {
        attendDataHistory.sort(((a, b) => b["time"]!.compareTo(a["time"]!)));
      }
    }

    if (attendList.value.attends != null &&
        attendList.value.attends!.isNotEmpty) {
      for (var item in attendList.value.attends!) {
        //출퇴근 관련만 넣는다.
        if (item.attendCode == '001') {
          attendData(item);
        }
      }

      if (attendData.value.dateFrom != null &&
          attendData.value.dateFrom!.isNotEmpty) {
        dateFrom(displayTime(attendData.value.dateFrom!));
      } else {
        dateFrom('');
      }

      if (attendData.value.dateTo != null &&
          attendData.value.dateTo!.isNotEmpty) {
        dateTo(displayTime(attendData.value.dateTo!));
      } else {
        dateTo('');
      }
    } else {
      dateFrom('');
      dateTo('');
    }

    isLoading(false);
  }

  Future<String> insAttend(bool isGps, String attendCode) async {
    isLoading(true);

    Map<String, dynamic> resutValue = {};

    if (!Get.isRegistered<CommuteRepository>()) {
      Get.put<CommuteRepository>(CommuteRepository());
    }

    if (isGps) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await getCurrentPosition();
      resutValue = await CommuteRepository.to.insAttend(
          loginInfo.bizId!, loginInfo.userId!, attendCode,
          latitude: position.latitude, longitude: position.longitude);
    } else {
      resutValue = await CommuteRepository.to
          .insAttend(loginInfo.bizId!, loginInfo.userId!, attendCode);
    }

    isLoading(false);

    getAttendList();

    return resutValue['message'] ?? '';
  }

  Future<bool> offAttend(bool isGps, String attendCode) async {
    isLoading(true);
    String attendId = '';

    if (!Get.isRegistered<CommuteRepository>()) {
      Get.put<CommuteRepository>(CommuteRepository());
    }

    bool returnData = false;

    //현재 AttendID 값 찾기
    //출퇴근이면
    if (attendCode == '001') {
      if (attendList.value.attends != null &&
          attendList.value.attends!.isNotEmpty) {
        for (var item in attendList.value.attends!) {
          //출퇴근 관련만 넣는다.
          if (item.attendCode == '001') {
            attendId = item.attendId!;
          }
        }
      }
    }

    //복귀이면
    if (attendCode == '002') {
      if (attendList.value.attends != null &&
          attendList.value.attends!.isNotEmpty) {
        for (var item in attendList.value.attends!) {
          //복귀(복귀 대상이면)키를 찾는다.
          if (item.attendCode == '002' &&
              (item.dateTo == null || item.dateTo!.isEmpty)) {
            attendId = item.attendId!;
          }
        }
      }
    }

    if (isGps) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await getCurrentPosition();
      returnData = await CommuteRepository.to.offAttend(
          loginInfo.bizId!, loginInfo.userId!, attendCode, attendId,
          latitude: position.latitude, longitude: position.longitude);
    } else {
      returnData = await CommuteRepository.to
          .offAttend(loginInfo.bizId!, loginInfo.userId!, attendCode, attendId);
    }

    isLoading(false);

    getAttendList();

    return returnData;
  }

  Future<bool> isGetCurrentPositoin() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    return serviceEnabled;
  }

  Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  String displayTime(String value) {
    return formatDate(Common.stringToDateTime(value), [am, ' ', hh, ':', nn],
        locale: const KoreanDateLocale());
  }
}
