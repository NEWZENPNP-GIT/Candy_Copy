import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:candy/src/controller/join_01_controller.dart';
import 'package:candy/src/pages/terms/terms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Join01 extends GetView<Join01Controller> {
  const Join01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarTitle(
        title: '회원가입',
        isShowMenu: false,
      ),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'CADNY BOX 서비스 이용약관 동의를 해주세요.',
                  style: Get.textTheme.subtitle1!.apply(color: primaryColor),
                ),
                hBlank15,
                Text(
                  '기업회원 및 법인의 개인정보를 안전하게 보호하고 있으며, 회원의 동의 없이는 개인/법인정보의 공개 또는 제 3자에게 제공되지 않습니다.',
                  style: Get.textTheme.bodyText2,
                ),
                hBlank10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      value: controller.isAllAgreement.value,
                      onChanged: (value) {
                        controller.setAllAgreemnet(value!);
                      },
                    ),
                    Text(
                      '아래의 모든 약관에 동의 합니다',
                      style:
                          Get.textTheme.subtitle2!.apply(color: Colors.black54),
                    )
                  ],
                ),
                hLine,
                hBlank10,
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildAllTerms(),
                  ),
                ),
                hBlank10,
                DefaultButton(
                  text: '임직원 회원가입',
                  color: primaryColor,
                  press: () {
                    if (!controller.isAllAgreement.value) {
                      //약관에 동의 바랍니다.
                      const CommonDaialog(
                        contents: ' 모든 약관에 동의하셔야 합니다.',
                        iconColor: kColorCA,
                        height: 120,
                      ).show();
                    } else {
                      Get.toNamed('/join02');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllTerms() {
    return Column(
      children: [
        ..._buildTerms('이용약관', controller.isAgreenment01, "01"),
        ..._buildTerms('개인정보처리방침', controller.isAgreenment02, "02"),
        ..._buildTerms('개인정보 수집 및 이용동의', controller.isAgreenment03, "03"),
        ..._buildTerms('개인정보 제3자 제공 동의', controller.isAgreenment04, "04"),
      ],
    );
  }

  List<Widget> _buildTerms(
      String titles, RxBool checkedValue, String termsString) {
    return [
      _buildSubtitle(titles),
      hBlank10,
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor),
        ),
        height: 200,
        width: Get.width - 20,
        child: SingleChildScrollView(
          child: Terms(
            termsNumber: termsString,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Checkbox(
            value: checkedValue.value,
            onChanged: (value) {
              checkedValue(value);
              controller.setIsAll(value!);
            },
          ),
          Text(
            '약관에 동의 합니다',
            style: Get.textTheme.subtitle2!.apply(color: Colors.black54),
          )
        ],
      ),
    ];
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
