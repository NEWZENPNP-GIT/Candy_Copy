// ignore_for_file: must_be_immutable

import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:candy/src/pages/commons/find_id_list_dialog.dart';
import 'package:candy/src/pages/commons/input_text.dart';
import 'package:candy/src/controller/find_id_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FindId extends StatelessWidget {
  FindId({
    Key? key,
    this.width = 300,
    this.height = 320,
  }) : super(key: key);

  final double? width;
  final double? height;

  FindIdController controller = Get.put(FindIdController());

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<dynamic> show() {
    controller.initValue();
    return Get.dialog(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: height,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(
                  () => Column(
                    children: [
                      Text(
                        '아이디 찾기',
                        style: GoogleFonts.nanumGothic(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      hBlank15,
                      InputText(
                        controller: controller.txtUserName,
                        borderColor: kColorE0,
                        hintText: '사용자성명을 입력해 주세요',
                        isBigBox: false,
                        hintFontSize: 14,
                        icon: Icons.person_pin_sharp,
                        onChanged: (val) {
                          controller.checkValidation();
                        },
                        errorText: controller.errUserName.isEmpty
                            ? null
                            : controller.errUserName.value,
                      ),
                      hBlank10,
                      InputText(
                        controller: controller.txtHpNum,
                        borderColor: kColorE0,
                        hintText: '휴대폰 번호를 입력해 주세요',
                        isBigBox: false,
                        hintFontSize: 14,
                        icon: Icons.phone_android,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          controller.checkValidation();
                        },
                        errorText: controller.errHpNum.isEmpty
                            ? null
                            : controller.errHpNum.value,
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.3,
                              child: DefaultButton(
                                text: '취소',
                                color: Colors.grey,
                                press: () {
                                  Get.back();
                                },
                              ),
                            ),
                            wBlank10,
                            Expanded(
                              child: DefaultButton(
                                text: '확인',
                                color: primaryColor,
                                press: () {
                                  if (controller.checkValidation()) {
                                    controller.sendInputInfo().then((value) {
                                      Get.back();
                                      if (value['count'] == 1) {
                                        CommonDaialog(
                                          contents: value['message'],
                                        ).show();
                                      } else {
                                        FindIdListDialog(
                                                userList: value['data'])
                                            .show();
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
