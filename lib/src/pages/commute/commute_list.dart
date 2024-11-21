import 'package:candy/src/controller/commute_list_controller.dart';
import 'package:candy/src/model/attend_data.dart';
import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/common.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommuteList extends GetView<CommuteListController> {
  const CommuteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarTitle(
        title: '출/퇴근관리',
        backgroundColor: kColorCommute,
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Container(
                height: 130,
                color: kColorCommute,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    wBlank10,
                    Text(
                      '조회기간',
                      style: Get.textTheme.subtitle1!.apply(
                        color: whiteColor,
                      ),
                    ),
                    wBlank10,
                    Expanded(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InputText(
                                controller: controller.fromDate,
                                borderColor: kColorE0,
                                hintFontSize: 14,
                                hintText: DateFormat('yyyy.MM.dd').format(
                                    DateTime(DateTime.now().year,
                                        DateTime.now().month, 1)),
                                isBigBox: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [dateFormatter],
                                onChanged: (value) {},
                              ),
                              Positioned(
                                top: 10,
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today_rounded,
                                    color: kColor48,
                                  ),
                                  onPressed: () {
                                    showDatePicker(
                                            context: Get.context!,
                                            initialDate: controller
                                                    .fromDate.text.isNotEmpty
                                                ? Common.stringToDateTime(
                                                    controller.fromDate.text
                                                        .replaceAll('.', ''))
                                                : DateTime.now(),
                                            firstDate:
                                                DateTime(DateTime.now().year),
                                            lastDate: DateTime(
                                                DateTime.now().year + 2))
                                        .then((value) {
                                      if (value != null) {
                                        controller.fromDate.text =
                                            DateFormat('yyyy.MM.dd')
                                                .format(value);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              InputText(
                                controller: controller.toDate,
                                borderColor: kColorE0,
                                hintFontSize: 14,
                                hintText: DateFormat('yyyy.MM.dd')
                                    .format(DateTime.now()),
                                isBigBox: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [dateFormatter],
                                onChanged: (value) {},
                              ),
                              Positioned(
                                top: 10,
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today_rounded,
                                    color: kColor48,
                                  ),
                                  onPressed: () {
                                    showDatePicker(
                                            context: Get.context!,
                                            initialDate: controller
                                                    .toDate.text.isNotEmpty
                                                ? Common.stringToDateTime(
                                                    controller.toDate.text
                                                        .replaceAll('.', ''))
                                                : DateTime.now(),
                                            firstDate:
                                                DateTime(DateTime.now().year),
                                            lastDate: DateTime(
                                                DateTime.now().year + 2))
                                        .then((value) {
                                      if (value != null) {
                                        controller.toDate.text =
                                            DateFormat('yyyy.MM.dd')
                                                .format(value);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.getAttendList();
                      },
                      icon: const Icon(
                        Icons.search,
                        color: whiteColor,
                      ),
                    )
                  ],
                ),
              ),
              hBlank10,
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.24,
                      child: Center(
                        child: Text(
                          '일자',
                          style: Get.textTheme.subtitle1!.apply(
                            color: kColorCommute,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.24,
                      child: Center(
                        child: Text(
                          '구분',
                          style: Get.textTheme.subtitle1!.apply(
                            color: kColorCommute,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.24,
                      child: Center(
                        child: Text(
                          '출근.외출',
                          style: Get.textTheme.subtitle1!.apply(
                            color: kColorCommute,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '퇴근.복귀',
                          style: Get.textTheme.subtitle1!.apply(
                            color: kColorCommute,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              hBlank10,
              hLine,
              hBlank10,
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getAttendList();
                  },
                  child: _buildDetailView(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailView() {
    return controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : (controller.attendList.value.attends == null ||
                controller.attendList.value.attends!.isEmpty)
            ? Center(
                child: Text(
                  '검색결과가 없습니다.',
                  style: Get.textTheme.headline2,
                ),
              )
            : Scrollbar(
                child: ListView.builder(
                    itemCount: controller.attendList.value.attends == null
                        ? 0
                        : controller.attendList.value.attends!.length,
                    itemBuilder: (context, index) {
                      return _buildView(
                          controller.attendList.value.attends![index]);
                    }));
  }

  Widget _buildView(AttendData attendData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: Get.width * 0.25,
            child: Center(
              child: Text(
                controller.displayDate(attendData.workDate),
                style: Get.textTheme.bodyText1,
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.25,
            child: Center(
              child: Text(
                controller.displayType(attendData.attendCode),
                style: Get.textTheme.bodyText1,
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.25,
            child: Text(
              controller.displayTime(attendData.dateFrom),
              style: Get.textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: Text(
              controller.displayTime(attendData.dateTo),
              style: Get.textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
