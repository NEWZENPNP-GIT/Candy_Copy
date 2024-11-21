import 'package:candy/src/pages/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Get.width / 3.5,
        //bottom: Get.height / 2.3,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/btn_leftmenu_home.png',
                    scale: 3,
                  ),
                  Text(
                    '전체보기',
                    style: Get.textTheme.headline1!.apply(color: whiteColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
              hBlank10,
              Text(
                '서비스관리',
                style: Get.textTheme.headline2!.apply(
                  color: primaryColor,
                ),
              ),
              hBlank20,
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.toNamed('/paymentList');
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/btn_leftmenu_pay.png',
                      scale: 3,
                    ),
                    wBlank10,
                    Text(
                      '임금명세서',
                      style: Get.textTheme.subtitle1!.apply(color: whiteColor),
                    )
                  ],
                ),
              ),
              hBlank15,
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.toNamed('/commute');
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/btn_leftmenu_commute.png',
                      scale: 3,
                    ),
                    wBlank10,
                    Text(
                      '출/퇴근인증',
                      style: Get.textTheme.subtitle1!.apply(color: whiteColor),
                    )
                  ],
                ),
              ),

              hBlank15,
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.toNamed('/contractList');
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/btn_leftmenu_contract.png',
                      scale: 3,
                    ),
                    wBlank10,
                    Text(
                      '전자근로계약',
                      style: Get.textTheme.subtitle1!.apply(color: whiteColor),
                    )
                  ],
                ),
              ),
              hBlank30,
              Text(
                '게시판',
                style: Get.textTheme.headline2!.apply(
                  color: primaryColor,
                ),
              ),
              hBlank20,
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.toNamed('/noticeList');
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/btn_leftmenu_questionboard.png',
                      scale: 3,
                    ),
                    wBlank10,
                    Text(
                      '공지사항',
                      style: Get.textTheme.subtitle1!.apply(color: whiteColor),
                    )
                  ],
                ),
              ),
              // hBlank20,
              // GestureDetector(
              //   onTap: () {
              //     Get.back();
              //     Get.toNamed('/faq');
              //   },
              //   child: Row(
              //     children: [
              //       Image.asset(
              //         'assets/images/btn_leftmenu_qna.png',
              //         scale: 3,
              //       ),
              //       wBlank10,
              //       Text(
              //         'FAQ(자주하는질문)',
              //         style: Get.textTheme.subtitle1!.apply(color: whiteColor),
              //       )
              //     ],
              //   ),
              // ),
              hBlank20,
              hWhiteLine,
              hBlank20,
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.toNamed('/myPage');
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/btn_leftmenu_mypage.png',
                          scale: 3,
                        ),
                        wBlank10,
                        Text(
                          '마이페이지',
                          style:
                              Get.textTheme.subtitle1!.apply(color: whiteColor),
                        ),
                      ],
                    ),
                  ),
                  wBlank30,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.offAllNamed('/login');
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/btn_leftmenu_logout.png',
                            scale: 3,
                          ),
                          wBlank10,
                          Expanded(
                            child: Text(
                              '로그아웃',
                              style: Get.textTheme.subtitle1!
                                  .apply(color: whiteColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> show() {
    return Get.dialog(const Menu());
  }
}
