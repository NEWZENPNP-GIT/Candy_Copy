import 'package:candy/src/controller/contract_password_check_controller.dart';
import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/common.dart';
import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:candy/src/pages/commons/input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ContractPasswordCheck extends GetView<ContractPasswordCheckController> {
  ContractPasswordCheck({
    Key? key,
    this.width = 300,
    this.height = 230,
  }) : super(key: key);

  final double? width;
  final double? height;
  late String? digitNonce;

  @override
  Widget build(BuildContext context) {
    controller.initValue();
    digitNonce = Get.arguments["digitNonce"];
    return Scaffold(
      appBar: const AppBarTitle(
        title: '암호확인',
        backgroundColor: kColorContract,
      ),
      backgroundColor: Colors.white,
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
                    '암호 입력',
                    style: GoogleFonts.nanumGothic(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  hBlank15,
                  InputText(
                    controller: controller.txtPassword,
                    borderColor: kColorE0,
                    hintText: '암호를 입력해 주세요',
                    isBigBox: false,
                    hintFontSize: 14,
                    icon: Icons.password,
                    isPasswordForm: true,
                    onChanged: (val) {
                      controller.checkValidation();
                    },
                    errorText: controller.errorMsg.isEmpty
                        ? null
                        : controller.errorMsg.value,
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
                              Common.isPasswordCheck = false;
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
                                  Common.isPasswordCheck = value;
                                  if (value) {
                                    Get.back();

                                    Get.toNamed('/contract_view', arguments: {
                                      'FileUrl':
                                          '$baseURL/contract/downContractPdf.do?id=$digitNonce&type=pdf'
                                    });
                                  } else {
                                    const CommonDaialog(
                                      contents: '입력된 암호가 일치 하지 않습니다.',
                                    ).show();
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
          ),
        ),
      ),
    );
  }
}
