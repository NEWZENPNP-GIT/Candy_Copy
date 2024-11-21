import 'package:candy/src/controller/notice_list_controller.dart';
import 'package:candy/src/model/notice.dart';
import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/common.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NoticeList extends GetView<NoticeListController> {
  const NoticeList({Key? key}) : super(key: key);

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
                child: _buildList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scrollbar(
        child: ListView.builder(
          itemCount: controller.noticeList.value.dataList == null
              ? 0
              : controller.noticeList.value.dataList!.length,
          itemBuilder: (context, index) {
            Notice _notice = controller.noticeList.value.dataList![index];
            return Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.updateVieCount(index);
                      Get.toNamed('/notice_detail', arguments: index);
                    },
                    child: SizedBox(
                      width: Get.width * 0.9,
                      child: Text(
                        "${_notice.subject}",
                        style: Get.textTheme.headline3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  hBlank10,
                  _notice.insDate == null
                      ? Container()
                      : Text(
                          DateFormat('yyyy-MM-dd').format(
                              Common.stringToDateTime(_notice.insDate!)),
                          style:
                              Get.textTheme.subtitle2!.apply(color: kColor48),
                        ),
                  hBlank15,
                  hGrayLine,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
