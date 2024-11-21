import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:candy/src/pages/commons/input_text.dart';
import 'package:candy/src/controller/join_02_controller.dart';
import 'package:candy/src/pages/member_join/company.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Join02 extends GetView<Join02Controller> {
  const Join02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarTitle(
        title: '회원가입',
        isShowMenu: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => _buildContents(),
                  ),
                ),
              ),
              hBlank10,
              Obx(
                () => controller.isSaving.value
                    ? const CircularProgressIndicator()
                    : DefaultButton(
                        text: '회원가입',
                        color: primaryColor,
                        press: () {
                          controller.isValid().then((value) {
                            if (value) {
                              controller.saveMemberJoin().then((value) {
                                if (value) {
                                  //회원가입완료페이지이동
                                  Get.offAllNamed('/join_end');
                                } else {
                                  Fluttertoast.showToast(
                                      msg: '가입이 실패했습니다.',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.TOP);
                                  controller.isSaving(false);
                                }
                              });
                            }
                          });
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContents() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(5)),
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('※ *로 표기된 항목은 필수 입력 사항입니다.',
                style:
                    GoogleFonts.nanumGothic(fontSize: 10, color: Colors.red)),
          ),
        ),
        hBlank10,
        _buildSubtitle('사용자 계정 정보'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '*',
                  style: Get.textTheme.subtitle2!.apply(color: kColorCA),
                ),
                Text(
                  '아이디',
                  style: Get.textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.65,
              child: InputText(
                controller: controller.txtUserId,
                borderColor: kColorE0,
                hintFontSize: 14,
                hintText: '이메일 형태로 입력해주세요',
                isBigBox: false,
                isSmallBox: true,
                onChanged: (value) {
                  controller.errorUserIdMsg('');
                  controller.isIdCheck(false);
                },
                icon: Icons.check,
                iconColor: controller.isIdCheck.value ? kColor2E : kColorCA,
                keyboardType: TextInputType.emailAddress,
                errorText: controller.errorUserIdMsg.isEmpty
                    ? null
                    : controller.errorUserIdMsg.value,
                onIconClick: () {
                  controller.isUserIdValid().then((value) {
                    if (!value) {
                      Fluttertoast.showToast(
                          msg: controller.errorUserIdMsg.value,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP);
                    }
                  });
                },
              ),
            ),
          ],
        ),
        controller.isIdCheck.value
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('사용가능한 아이디입니다.'),
              )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '*',
                  style: Get.textTheme.subtitle2!.apply(color: kColorCA),
                ),
                Text(
                  '비밀번호',
                  style: Get.textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.65,
              child: InputText(
                controller: controller.txtPassword,
                borderColor: kColorE0,
                hintFontSize: 14,
                hintText: '비밀번호를 입력해 주세요',
                isBigBox: false,
                isSmallBox: true,
                isPasswordForm: true,
                onChanged: (value) {
                  controller.isPasswordValid();
                },
                errorText: controller.errorPasswordMsg.isEmpty
                    ? null
                    : controller.errorPasswordMsg.value,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '*',
                  style: Get.textTheme.subtitle2!.apply(color: kColorCA),
                ),
                Text(
                  '비밀번호확인',
                  style: Get.textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.65,
              child: InputText(
                controller: controller.txtRePassword,
                borderColor: kColorE0,
                hintFontSize: 14,
                hintText: '비밀번호확인을 입력해 주세요',
                isBigBox: false,
                isSmallBox: true,
                isPasswordForm: true,
                onChanged: (value) {
                  controller.isRePasswordValid();
                },
                errorText: controller.errorRePasswordMsg.isEmpty
                    ? null
                    : controller.errorRePasswordMsg.value,
              ),
            ),
          ],
        ),
        hBlank20,
        _buildSubtitle('직원 정보'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '*',
                  style: Get.textTheme.subtitle2!.apply(color: kColorCA),
                ),
                Text(
                  '회사명',
                  style: Get.textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.65,
              child: InputText(
                controller: controller.txtCompanyName,
                borderColor: kColorE0,
                hintFontSize: 14,
                hintText: '회사명을 입력해 주세요',
                isBigBox: false,
                isSmallBox: true,
                onChanged: (value) {
                  controller.isCompanyNameVaild();
                  controller.isCompanyNameCheck(false);
                },
                icon: Icons.search,
                iconColor:
                    controller.isCompanyNameCheck.value ? kColor2E : kColorCA,
                onIconClick: () {
                  controller
                      .checkCompany(controller.txtCompanyName.text)
                      .then((value) {
                    //검색해서 count가 2보다 크면 검색으로 선택
                    //회사명 검색
                    if (value == false) {
                      Get.dialog(Company(
                          width: Get.width - 40,
                          height: Get.height * 3 / 4,
                          searchName: controller.txtCompanyName.text));
                    }
                  });
                },
                errorText: controller.errorCompanyNameMsg.isEmpty
                    ? null
                    : controller.errorCompanyNameMsg.value,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '*',
                  style: Get.textTheme.subtitle2!.apply(color: kColorCA),
                ),
                Text(
                  '생년월일',
                  style: Get.textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.65,
              child: InputText(
                controller: controller.txtBirthDay,
                borderColor: kColorE0,
                hintFontSize: 14,
                hintText: '예)19740408',
                isBigBox: false,
                isSmallBox: true,
                keyboardType: TextInputType.number,
                inputFormatters: [digit8],
                onChanged: (value) {
                  controller.isBirthDayValid();
                },
                errorText: controller.errorBirthDayMsg.isEmpty
                    ? null
                    : controller.errorBirthDayMsg.value,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '*',
                  style: Get.textTheme.subtitle2!.apply(color: kColorCA),
                ),
                Text(
                  '성명',
                  style: Get.textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.65,
              child: InputText(
                controller: controller.txtEmpName,
                borderColor: kColorE0,
                hintFontSize: 14,
                hintText: '성명을 입력해 주세요',
                isBigBox: false,
                isSmallBox: true,
                onChanged: (value) {
                  controller.isEmpNameValid();
                },
                errorText: controller.errorEmpNameMsg.isEmpty
                    ? null
                    : controller.errorEmpNameMsg.value,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '*',
                  style: Get.textTheme.subtitle2!.apply(color: kColorCA),
                ),
                Text(
                  '휴대폰번호',
                  style: Get.textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.65,
              child: InputText(
                controller: controller.txtMobilePhone,
                borderColor: kColorE0,
                hintFontSize: 14,
                hintText: '휴대전화번호를 입력해 주세요',
                isBigBox: false,
                isSmallBox: true,
                keyboardType: TextInputType.number,
                inputFormatters: [digit11],
                onChanged: (value) {
                  controller.isMobilePhoneValid();
                },
                errorText: controller.errorMobilePhoneMsg.isEmpty
                    ? null
                    : controller.errorMobilePhoneMsg.value,
                icon: Icons.send,
                iconColor:
                    controller.isMobilePhoneCheck.value ? kColor2E : kColorCA,
                onIconClick: () {
                  controller.sendCertNumber().then((value) {
                    controller.isMobilePhoneCheck(value);
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '*',
                  style: Get.textTheme.subtitle2!.apply(color: kColorCA),
                ),
                Text(
                  '인증번호',
                  style: Get.textTheme.subtitle2,
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.65,
              child: InputText(
                controller: controller.txtConfirmNumber,
                borderColor: kColorE0,
                hintFontSize: 14,
                hintText: '인증번호를 입력해 주세요',
                isBigBox: false,
                isSmallBox: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.isConfirmNumberValid();
                },
                errorText: controller.errorConfirmNumberMsg.isEmpty
                    ? null
                    : controller.errorConfirmNumberMsg.value,
                icon: Icons.check,
                iconColor:
                    controller.isConfirmNumberCheck.value ? kColor2E : kColorCA,
                onIconClick: () {
                  //인증번호를 확인한다.
                  controller.checkCertNumber().then((value) {
                    if (value) {
                      // Fluttertoast.showToast(
                      //     msg: '인증되었습니다.',
                      //     toastLength: Toast.LENGTH_LONG,
                      //     gravity: ToastGravity.TOP);
                    }
                  });
                },
              ),
            ),
          ],
        ),
        controller.isConfirmNumberCheck.value
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('인증되었습니다.'),
              )
            : Container(),
        hBlank20,
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(5)),
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '※ 회사에 등록되어 있는 인사정보를 기준으로 가입이 진행되오니 가입절차 진행이 원할하지 않는 경우 회사 담당자에게 문의하시기 바랍니다.',
                    style: GoogleFonts.nanumGothic(
                        fontSize: 10, color: Colors.red)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.brightness_5_outlined,
          size: 14,
          color: primaryColor,
        ),
        Text(
          title,
          style: Get.textTheme.subtitle2!.apply(color: primaryColor),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
