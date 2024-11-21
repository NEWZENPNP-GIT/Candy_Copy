import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //가로 모드 금지
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      appBar: const AppBarTitle(
        title: 'CANDY',
      ),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.isLoading.value
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      controller.getInitData();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.toNamed('/myPage');
                                },
                                icon: const Icon(
                                  Icons.account_circle,
                                  size: 28,
                                  color: primaryColor,
                                ),
                              ),
                              wBlank10,
                              Text(
                                '${controller.userName}님 환영합니다.',
                                style: Get.textTheme.headline2!
                                    .apply(color: Colors.black54),
                              )
                            ],
                          ),
                          hBlank05,
                          Text(
                            '※ 상단 아이콘을 눌러 지문, Face ID를 추가할 수 있습니다.',
                            style: Get.textTheme.subtitle1!.apply(
                                color: Color.fromARGB(255, 203, 98, 224)),
                          ),
                          hBlank15,
                          _buildContent(
                              const Color(0xFF1EBDC3),
                              'assets/images/btn_leftmenu_pay.png',
                              '임금명세서',
                              '최근 임금지급일',
                              '${controller.payStubDay.value}', () {
                            Get.toNamed('/paymentList');
                          }),
                          hBlank10,
                          _buildContent(
                              const Color(0xFF0080AF),
                              'assets/images/btn_leftmenu_commute.png',
                              '출/퇴근인증',
                              '최근출근: ${controller.lastInTime.value}',
                              '최근퇴근: ${controller.lastOutTime.value}', () {
                            Get.toNamed('/commute');
                          }),
                          hBlank10,
                          _buildContent(
                              const Color(0xFF526ECB),
                              'assets/images/btn_leftmenu_contract.png',
                              '전자근로계약',
                              '계약일자: ${controller.contractDate.value}',
                              '계약구분: ${controller.contractTypeName.value}', () {
                            Get.toNamed('/contractList');
                          })
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Color backGroundColor, String imageUrl, String title,
      String subTitle01, String subTitle02, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width,
        height: Get.height / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              colors: [backGroundColor.withOpacity(0.7), backGroundColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10.0,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hBlank05,
                  Text(
                    title,
                    style: Get.textTheme.headline2!.apply(
                      color: whiteColor,
                    ),
                  ),
                  hBlank05,
                  Text(
                    subTitle01,
                    style: Get.textTheme.subtitle2!.apply(color: whiteColor),
                  ),
                  hBlank05,
                  Text(
                    subTitle02,
                    style: Get.textTheme.subtitle2!.apply(color: whiteColor),
                  ),
                ],
              ),
              Image.asset(imageUrl)
            ],
          ),
        ),
      ),
    );
  }
}
