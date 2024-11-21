import 'package:candy/src/controller/notice_list_controller.dart';
import 'package:candy/src/model/notice.dart';
import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class NoticeDetail extends GetView<NoticeListController> {
  const NoticeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarTitle(
        title: '공지사항',
        backgroundColor: kColorCommute,
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              hBlank10,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildDetail(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                child: DefaultButton(
                    text: "확인",
                    press: () {
                      Get.back();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail() {
    Notice _notice = controller.noticeList.value.dataList![Get.arguments];

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          height: 60,
          child: Text(
            _notice.subject!,
            style: Get.textTheme.headline3,
          ),
        ),
        hGrayLine,
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              child: Html(
                data: _notice.contents,
              ),
            ),
          ),
        )
      ],
    );
  }
}
