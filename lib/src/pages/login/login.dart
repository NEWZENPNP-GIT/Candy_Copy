import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:candy/src/pages/commons/input_text.dart';
import 'package:candy/src/controller/login_controller.dart';
import 'package:candy/src/pages/login/find_id.dart';
import 'package:candy/src/pages/login/find_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //가로 모드 금지
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
        appBar: const AppBarTitle(
          title: 'CANDY',
          isShowMenu: false,
        ),
        backgroundColor: const Color(0xFFF3FBFE),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Obx(
              () => controller.isFisting.value
                  ? Container()
                  : Column(
                      children: [
                        _buildHeader(),
                        _buildBody(),
                        hBlank40,
                        _buildBottom(),
                      ],
                    ),
            ),
          ),
        ));
  }

  Widget _buildBottom() {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/join01');
      },
      child: Container(
        height: controller.bottomHeight,
        width: Get.width,
        decoration: const BoxDecoration(color: Colors.black87),
        child: Center(
          child: Text(
            '회원가입',
            style: Get.textTheme.subtitle2!.apply(color: primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 0,
                  blurRadius: 5.0,
                  offset: const Offset(0, 10), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      '로그인',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nanumGothic(
                          color: primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  hBlank15,
                  InputText(
                    controller: controller.txtId,
                    borderColor: kColorE0,
                    hintText: '아이디',
                    isBigBox: false,
                    hintFontSize: 14,
                    icon: Icons.person,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  hBlank10,
                  InputText(
                    controller: controller.txtPass,
                    borderColor: kColorE0,
                    hintText: '비밀번호',
                    isBigBox: false,
                    hintFontSize: 14,
                    isPasswordForm: true,
                    icon: Icons.lock,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        '아이디 저장',
                        style: Get.textTheme.subtitle2!
                            .apply(color: Colors.grey.withOpacity(.5)),
                      ),
                      Checkbox(
                          value: controller.isLoginIdSaved.value,
                          onChanged: (changedValue) {
                            controller.changeLoginSaved(changedValue!);
                          }),
                    ],
                  ),
                  controller.errMsg.value.isNotEmpty
                      ? Text(
                          controller.errMsg.value,
                          style: Get.textTheme.subtitle2!.apply(
                            color: kColorCA,
                          ),
                        )
                      : Container(),
                  hBlank20,
                  controller.isLoging.value
                      ? const Center(child: CircularProgressIndicator())
                      : DefaultButton(
                          text: '로그인',
                          color: primaryColor,
                          press: () {
                            controller.login().then((value) {
                              if (value.isEmpty) {
                                Get.offAllNamed('/');
                              }
                            });
                          },
                        ),
                ],
              ),
            ),
          ),
          Container(
            height: 20,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 0,
                  blurRadius: 5.0,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
          ),
          hBlank20,
          hBlank20,
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFC7E9F5),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 0,
                  blurRadius: 5.0,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    FindId().show();
                  },
                  child: Text(
                    "아이디찾기",
                    style:
                        Get.textTheme.subtitle2!.apply(color: Colors.black54),
                  ),
                ),
                const Text("|"),
                GestureDetector(
                  onTap: () {
                    FindPass().show();
                  },
                  child: Text(
                    "비밀번호찾기",
                    style:
                        Get.textTheme.subtitle2!.apply(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: Get.height * 0.25,
      width: Get.width,
      decoration: const BoxDecoration(color: primaryColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              ':)',
              style: GoogleFonts.nanumGothic(
                  color: whiteColor.withOpacity(0.5), fontSize: 50),
            ),
            Text(
              'Welcome',
              style: GoogleFonts.nanumGothic(color: whiteColor, fontSize: 40),
            ),
            // Positioned(
            //   top: 160,
            //   left: 30,
            //   right: 30,
            //   bottom: 0,
            //   child: Container(
            //     height: 30,
            //     decoration: const BoxDecoration(
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(10),
            //         topRight: Radius.circular(10),
            //       ),
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
