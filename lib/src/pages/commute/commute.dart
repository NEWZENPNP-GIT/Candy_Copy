import 'package:candy/src/controller/commute_controller.dart';
import 'package:candy/src/controller/home_controller.dart';
import 'package:candy/src/model/attend_data.dart';
import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Commute extends GetView<CommuteController> {
  const Commute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getAttendList();
    return WillPopScope(
      onWillPop: () async {
        HomeController.to.getInitData();
        return true;
      },
      child: Scaffold(
        appBar: const AppBarTitle(
          title: '출/퇴근관리',
          backgroundColor: kColorCommute,
        ),
        body: Obx(
          () => SafeArea(
            child: controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage("assets/images/bg_mobile_commute.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              hBlank50,
                              Container(
                                height: 180,
                                width: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),
                                  border:
                                      Border.all(color: whiteColor, width: 2),
                                ),
                                child: Column(
                                  children: [
                                    hBlank40,
                                    Text(
                                      formatDate(controller.dateTimeNow.value,
                                          [mm, '.', dd, ' ', D],
                                          locale: const KoreanDateLocale()),
                                      style: Get.textTheme.headline3!.apply(
                                        color: whiteColor,
                                      ),
                                    ),
                                    hBlank10,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          formatDate(
                                              controller.dateTimeNow.value,
                                              [am],
                                              locale: const KoreanDateLocale()),
                                          style: Get.textTheme.headline3!.apply(
                                            color: whiteColor,
                                          ),
                                        ),
                                        Text(
                                          formatDate(
                                              controller.dateTimeNow.value,
                                              [h, ':', nn],
                                              locale: const KoreanDateLocale()),
                                          style: Get.textTheme.headline6!.apply(
                                            color: whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    hBlank20,
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/commuteList');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: whiteColor,
                                        ),
                                        alignment: Alignment.center,
                                        height: 25,
                                        width: 120,
                                        child: Text(
                                          '출/퇴근 기록 관리 +',
                                          style: Get.textTheme.subtitle2!
                                              .apply(color: kColorCommute),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              hBlank20,
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.dateFrom.value.isEmpty) {
                                        //GPS사용가능여부
                                        controller
                                            .isGetCurrentPositoin()
                                            .then((value) {
                                          if (!value) {
                                            const CommonDaialog(
                                              buttonCount: 2,
                                              contents:
                                                  'GPS사용이 불가능하지만 출근체크하시겠습니까?',
                                            ).show().then((value) {
                                              if (value) {
                                                //출근체크
                                                controller
                                                    .insAttend(false, '001')
                                                    .then((value) {
                                                  if (value.isNotEmpty) {
                                                    CommonDaialog(
                                                      contents: value,
                                                    ).show();
                                                  }
                                                });
                                              }
                                            });
                                          } else {
                                            //츨근체크
                                            controller
                                                .insAttend(true, '001')
                                                .then((value) {
                                              if (value.isNotEmpty) {
                                                CommonDaialog(
                                                  contents: value,
                                                ).show();
                                              }
                                            });
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              controller.dateFrom.value.isEmpty
                                                  ? whiteColor
                                                  : Colors.yellow),
                                      height: 100,
                                      width: Get.width / 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          controller.dateFrom.value.isEmpty
                                              ? Container()
                                              : Image.asset(
                                                  'assets/images/icon_commute_check.png',
                                                  scale: 5,
                                                ),
                                          hBlank05,
                                          Text(
                                            controller.dateFrom.value.isEmpty
                                                ? '출근등록'
                                                : '출근확인',
                                            style: Get.textTheme.headline3!
                                                .apply(color: kColorCommute),
                                          ),
                                          hBlank05,
                                          Text(
                                            controller.dateFrom.value,
                                            style: Get.textTheme.subtitle2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  wBlank05,
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (controller.dateTo.value.isEmpty) {
                                          //GPS사용가능여부
                                          controller
                                              .isGetCurrentPositoin()
                                              .then((value) {
                                            if (!value) {
                                              const CommonDaialog(
                                                buttonCount: 2,
                                                contents:
                                                    'GPS사용이 불가능하지만 퇴근체크하시겠습니까?',
                                              ).show().then((value) {
                                                if (value) {
                                                  //퇴근체크
                                                  controller.offAttend(
                                                      true, '001');
                                                }
                                              });
                                            } else {
                                              //츨근체크
                                              controller.offAttend(true, '001');
                                            }
                                          });
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                controller.dateTo.value.isEmpty
                                                    ? whiteColor
                                                    : Colors.yellow),
                                        height: 100,
                                        width: Get.width / 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            controller.dateTo.value.isEmpty
                                                ? Container()
                                                : Image.asset(
                                                    'assets/images/icon_commute_check.png',
                                                    scale: 5,
                                                  ),
                                            hBlank05,
                                            Text(
                                              controller.dateTo.value.isEmpty
                                                  ? '퇴근등록'
                                                  : '퇴근확인',
                                              style: Get.textTheme.headline3!
                                                  .apply(color: kColorCommute),
                                            ),
                                            hBlank05,
                                            Text(
                                              controller.dateTo.value,
                                              style: Get.textTheme.subtitle2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              hBlank10,
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller
                                          .insAttend(false, '002')
                                          .then((value) {
                                        if (value.isNotEmpty) {
                                          CommonDaialog(
                                            contents: value,
                                          ).show();
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: kColorCommute),
                                      height: 50,
                                      width: Get.width / 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '외출',
                                            style: Get.textTheme.subtitle1!
                                                .apply(color: whiteColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  wBlank05,
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.offAttend(false, '002');
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color(0xFFC4F5EF)),
                                        height: 50,
                                        width: Get.width / 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '복귀',
                                              style: Get.textTheme.headline3!
                                                  .apply(color: kColorCommute),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              hBlank10,
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: whiteColor),
                                width: Get.width,
                                height: Get.height / 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      hBlank10,
                                      Text(
                                        '현재 출/퇴근 기록',
                                        style: Get.textTheme.subtitle1!.apply(
                                          color: kColorCommute,
                                        ),
                                      ),
                                      hBlank10,
                                      hLine,
                                      Expanded(
                                        child: Scrollbar(
                                          //리스트
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: ListView.builder(
                                                itemCount: controller
                                                    .attendDataHistory.length,
                                                itemBuilder: (context, index) {
                                                  return _buildListView(
                                                      controller
                                                              .attendDataHistory[
                                                          index]);
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(Map<String, String> attend) {
    return Column(
      children: [
        hBlank10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              attend["title"] ?? "",
              style: Get.textTheme.headline3,
            ),
            Text(
              attend["time"] ?? "",
              style: Get.textTheme.headline3,
            )
          ],
        ),
      ],
    );
  }
}
