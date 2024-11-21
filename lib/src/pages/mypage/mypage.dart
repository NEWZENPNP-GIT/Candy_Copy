import 'package:candy/src/controller/mypage_controller.dart';
import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/common.dart';
import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/mypage/change_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends GetView<MyPageController> {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarTitle(
        title: '마이 페이지',
        backgroundColor: kColorFaq,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF3F3F3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildMemberinfo(),
                hBlank20,
                Expanded(child: _buildLoginMethod()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginMethod() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), color: whiteColor),
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '로그인 수단 추가하기',
              style: Get.textTheme.headline3,
            ),
            hBlank20,
            hGrayLine,
            hBlank10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.canLocalAuth().then((value) {
                      if (value) {
                        Common.setLocalAuth().then((value2) {
                          if (value2) {
                            const CommonDaialog(
                              contents: '등록되었습니다.',
                            ).show();
                          } else {
                            const CommonDaialog(
                              contents: '등록이 실패되었습니다. 다시 시도 부탁드립니다.',
                            ).show();
                          }
                        });
                      } else {
                        const CommonDaialog(
                          contents: '지문인식이 지원되지 않은 폰입니다.',
                        ).show();
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/icon_myPage_finger.png',
                        scale: 2.0,
                      ),
                      hBlank15,
                      Text(
                        '지문인식',
                        style: Get.textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.canLocalAuth().then((value) {
                      if (value) {
                        Common.setLocalAuth().then((value) {
                          if (value) {
                            const CommonDaialog(
                              contents: '등록되었습니다.',
                            ).show();
                          } else {
                            const CommonDaialog(
                              contents: '등록이 실패되었습니다. 다시 시도 부탁드립니다.',
                            ).show();
                          }
                        });
                      } else {
                        const CommonDaialog(
                          contents: 'FACE ID가 지원되지 않은 폰입니다.',
                        ).show();
                      }
                    });
                  },
                  child: Column(children: [
                    Image.asset(
                      'assets/images/icon_myPage_faceid.png',
                      scale: 2.0,
                    ),
                    hBlank15,
                    Text(
                      'Face ID',
                      style: Get.textTheme.subtitle2,
                    ),
                  ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMemberinfo() {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), color: whiteColor),
              width: Get.width,
              height: 330,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '회원정보',
                      style: Get.textTheme.headline3,
                    ),
                    hBlank20,
                    hGrayLine,
                    hBlank10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          controller.myPageData['empName'],
                          style: Get.textTheme.headline3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ID',
                              style: Get.textTheme.subtitle2!
                                  .apply(color: kColorFaq),
                            ),
                            wBlank05,
                            Text(
                              controller.myPageData['loginId'],
                              style: Get.textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    hBlank20,
                    hGrayLine,
                    hBlank20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width / 2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '회사명',
                                    style: Get.textTheme.subtitle2!
                                        .apply(color: kColorFaq),
                                  ),
                                  wBlank20,
                                  Text(controller.myPageData['bizName'],
                                      style: Get.textTheme.bodyText2),
                                ],
                              ),
                              hBlank15,
                              Row(
                                children: [
                                  Text(
                                    '부서',
                                    style: Get.textTheme.subtitle2!
                                        .apply(color: kColorFaq),
                                  ),
                                  wBlank20,
                                  Text(controller.myPageData['deptName'],
                                      style: Get.textTheme.bodyText2),
                                ],
                              ),
                              hBlank15,
                              Row(
                                children: [
                                  Text(
                                    '이메일',
                                    style: Get.textTheme.subtitle2!
                                        .apply(color: kColorFaq),
                                  ),
                                  wBlank20,
                                  Text(controller.myPageData['EMail'],
                                      style: Get.textTheme.bodyText2),
                                ],
                              ),
                              hBlank15,
                              Row(
                                children: [
                                  Text(
                                    '휴대폰',
                                    style: Get.textTheme.subtitle2!
                                        .apply(color: kColorFaq),
                                  ),
                                  wBlank20,
                                  Text(controller.myPageData['phoneNum'],
                                      style: Get.textTheme.bodyText2),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '사번',
                                    style: Get.textTheme.subtitle2!
                                        .apply(color: kColorFaq),
                                  ),
                                  wBlank20,
                                  Text(controller.myPageData['empNo'],
                                      style: Get.textTheme.bodyText2),
                                ],
                              ),
                              hBlank15,
                              Row(
                                children: [
                                  Text(
                                    '직책',
                                    style: Get.textTheme.subtitle2!
                                        .apply(color: kColorFaq),
                                  ),
                                  wBlank20,
                                  Text(controller.myPageData['positionName'],
                                      style: Get.textTheme.bodyText2),
                                ],
                              ),
                              hBlank15,
                              Row(
                                children: [
                                  Text(
                                    '',
                                    style: Get.textTheme.subtitle2!
                                        .apply(color: kColorFaq),
                                  ),
                                  wBlank20,
                                  Text('', style: Get.textTheme.bodyText2),
                                ],
                              ),
                              hBlank15,
                              Row(
                                children: [
                                  Text(
                                    '',
                                    style: Get.textTheme.subtitle2!
                                        .apply(color: kColorFaq),
                                  ),
                                  wBlank20,
                                  Text('', style: Get.textTheme.bodyText2),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    hBlank20,
                    Expanded(
                      child: Container(
                          alignment: Alignment.topRight,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: kColorFaq),
                            ),
                            child: Text(
                              '비밀번호 변경',
                              style: Get.textTheme.subtitle2!
                                  .apply(color: kColorFaq),
                            ),
                            onPressed: () {
                              ChangePassword().show();
                            },
                          )),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
