import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:candy/src/pages/commons/input_text.dart';
import 'package:candy/src/controller/find_pass_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class FindPass extends StatelessWidget {
  FindPass({
    Key? key,
    this.width = 300,
    this.height = 480,
  }) : super(key: key);

  final double? width;
  final double? height;

  FindPassController controller = Get.put(FindPassController());

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
                      '비밀번호 찾기',
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
                      controller: controller.txtLoginId,
                      borderColor: kColorE0,
                      hintText: '사용자아이디를 입력해 주세요',
                      isBigBox: false,
                      hintFontSize: 14,
                      icon: Icons.person,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        controller.checkValidation();
                      },
                      errorText: controller.errLoginId.isEmpty
                          ? null
                          : controller.errLoginId.value,
                    ),
                    hBlank10,
                    InputText(
                      controller: controller.txtHpNum,
                      borderColor: kColorE0,
                      hintText: '휴대폰 번호를 입력해 주세요',
                      isBigBox: false,
                      hintFontSize: 14,
                      onChanged: (val) {
                        controller.checkValidation();
                      },
                      keyboardType: TextInputType.number,
                      icon: Icons.phone_android,
                      errorText: controller.errHpNum.isEmpty
                          ? null
                          : controller.errHpNum.value,
                    ),
                    hBlank20,
                    controller.errHpNum.isNotEmpty &&
                            controller.errLoginId.isNotEmpty &&
                            controller.errUserName.isNotEmpty
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('※ 직원정보에 등록된 이메일(id)로 비밀변호 변경URL전송합니다.',
                                      style: GoogleFonts.nanumGothic(
                                          fontSize: 10, color: Colors.red)),
                                ],
                              ),
                            ),
                          ),
                    hBlank20,
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
                                    CommonDaialog(
                                      contents: value['message'],
                                    ).show();
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
            ),
          ),
        ),
      ),
    );
  }
}
