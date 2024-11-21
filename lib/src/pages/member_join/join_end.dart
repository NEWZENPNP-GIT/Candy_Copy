import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinEnd extends StatelessWidget {
  const JoinEnd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarTitle(
        title: '회원가입완료',
        isShowMenu: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outlined,
                size: 60,
                color: primaryColor.withOpacity(0.5),
              ),
              hBlank10,
              Text(
                '회원가입을 환영 합니다.',
                style: Get.textTheme.headline1!.apply(color: primaryColor),
              ),
              hBlank10,
              Text(
                'CANDY BOX 회원가입이',
                style: Get.textTheme.headline3,
              ),
              Text(
                '성공적으로 완료되었습니다.',
                style: Get.textTheme.headline3,
              ),
              hBlank40,
              Padding(
                padding: const EdgeInsets.only(
                  left: 80,
                  right: 80,
                ),
                child: DefaultButton(
                  text: '로그인 하기>',
                  color: primaryColor,
                  press: () {
                    Get.offAllNamed('/login');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
