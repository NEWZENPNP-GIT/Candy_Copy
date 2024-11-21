import 'package:candy/src/controller/join_02_controller.dart';
import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:candy/src/pages/commons/input_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Company extends GetView<Join02Controller> {
  const Company({
    Key? key,
    this.width = 200,
    this.height = 200,
    this.searchName,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? searchName;

  @override
  Widget build(BuildContext context) {
    TextEditingController _textSearchName = TextEditingController();
    _textSearchName.text = searchName ?? "";

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor, width: 2),
            color: Colors.white,
          ),
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/icon_company.png'),
                    wBlank05,
                    Text(
                      '회사검색',
                      style: Get.textTheme.headline2!.apply(color: kColorFaq),
                    ),
                  ],
                ),
                hBlank10,
                hGrayLine,
                hBlank10,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kColorFaq.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '재직중인 회사명을 검색하여 등록하세요, 단 회사명이 검색되지 않으면 우선 기업담당자가 캔디박스 기업회원으로 가입하셔야 합니다.',
                      style: Get.textTheme.bodyText2,
                    ),
                  ),
                ),
                InputText(
                  controller: _textSearchName,
                  borderColor: kColorE0,
                  hintFontSize: 14,
                  hintText: '회사명을 입력해 주세요',
                  isBigBox: false,
                  isSmallBox: true,
                  onChanged: (value) {},
                  icon: Icons.search,
                  iconColor: kColor2E,
                  onIconClick: () {
                    controller.checkCompany(_textSearchName.text);
                  },
                ),
                hBlank10,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 12,
                        width: 12,
                      ),
                      wBlank05,
                      SizedBox(
                        width: Get.width * 0.3,
                        child: Text(
                          '회사명',
                          style: Get.textTheme.subtitle2,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.3,
                        child: Text(
                          '사업자번호',
                          style: Get.textTheme.subtitle2,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '대표자명',
                          style: Get.textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Expanded(
                    child: controller.isCompanySearching.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _buildList(),
                  ),
                ),
                hBlank20,
                SizedBox(
                  height: 50,
                  child: DefaultButton(
                    text: '확인',
                    press: () {
                      if (controller.companySelectedIndex.value > -1) {
                        controller.resultBizId = controller
                            .compnayList
                            .value
                            .data![controller.companySelectedIndex.value]
                            .bizId!;
                        controller.txtCompanyName.text = controller
                            .compnayList
                            .value
                            .data![controller.companySelectedIndex.value]
                            .bizName!;
                        controller.errorCompanyNameMsg('');
                        controller.isCompanyNameCheck(true);
                        Get.back();
                      } else {
                        const CommonDaialog(
                          contents: '회사명을 선택해 주세요',
                        ).show();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    //controller.companySelectedIndex.value = -1;

    return Scrollbar(
      child: controller.compnayList.value.data == null
          ? Center(
              child: Text(
                '검색된 회사가 없습니다.',
                style: Get.textTheme.subtitle1,
              ),
            )
          : ListView.builder(
              itemCount: controller.compnayList.value.data == null
                  ? 0
                  : controller.compnayList.value.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      hBlank10,
                      GestureDetector(
                        onTap: () {
                          controller.setSelectedIndex(index);
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  width: 1,
                                  color: kColor2E,
                                ),
                              ),
                              height: 14,
                              width: 14,
                              child: controller.compnayList.value.data![index]
                                      .isSelected!
                                  ? Center(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: kColorFB,
                                          shape: BoxShape.circle,
                                        ),
                                        height: 8,
                                        width: 8,
                                      ),
                                    )
                                  : Container(),
                            ),
                            wBlank05,
                            SizedBox(
                              width: Get.width * 0.3,
                              child: Text(
                                controller
                                    .compnayList.value.data![index].bizName!,
                                style: Get.textTheme.bodyText2,
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.3,
                              child: Text(
                                controller
                                    .compnayList.value.data![index].businessNo!,
                                style: Get.textTheme.bodyText2,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller
                                    .compnayList.value.data![index].ownerName!,
                                style: Get.textTheme.bodyText2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
