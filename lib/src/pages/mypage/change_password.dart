import 'package:candy/src/controller/change_password_controller.dart';
import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:candy/src/pages/commons/input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ChangePassword extends StatelessWidget {
  ChangePassword({
    Key? key,
    this.width = 300,
    this.height = 480,
  }) : super(key: key);

  final double? width;
  final double? height;

  ChangePassController controller = Get.put(ChangePassController());

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
                      '비밀번호변경',
                      style: GoogleFonts.nanumGothic(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    hBlank15,
                    InputText(
                      controller: controller.txtNowPassword,
                      borderColor: kColorE0,
                      hintText: '이전비밀번호를 입력해 주세요',
                      isBigBox: false,
                      hintFontSize: 14,
                      isPasswordForm: true,
                      icon: Icons.password_outlined,
                      onChanged: (val) {
                        controller.checkValidation();
                      },
                      errorText: controller.errNowPassword.isEmpty
                          ? null
                          : controller.errNowPassword.value,
                    ),
                    hBlank10,
                    InputText(
                      controller: controller.txtChangePassword,
                      borderColor: kColorE0,
                      hintText: '새 비밀번호를 입력해 주세요',
                      isBigBox: false,
                      hintFontSize: 14,
                      isPasswordForm: true,
                      icon: Icons.password_rounded,
                      onChanged: (val) {
                        controller.checkValidation();
                      },
                      errorText: controller.errChangePassword.isEmpty
                          ? null
                          : controller.errChangePassword.value,
                    ),
                    hBlank10,
                    InputText(
                      controller: controller.txtChangeRePassword,
                      borderColor: kColorE0,
                      hintText: '비밀번호 확인을 입력해 주세요',
                      isBigBox: false,
                      hintFontSize: 14,
                      isPasswordForm: true,
                      icon: Icons.password_rounded,
                      onChanged: (val) {
                        controller.checkValidation();
                      },
                      errorText: controller.errChangeRePassword.isEmpty
                          ? null
                          : controller.errChangeRePassword.value,
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
