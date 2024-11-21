import 'package:candy/src/pages/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDaialog extends StatelessWidget {
  const CommonDaialog({
    Key? key,
    this.contents,
    this.cancelText = '취소',
    this.confirmText = '확인',
    this.confirmColor = Colors.white,
    this.confirmFuntion,
    this.iconColor = Colors.black,
    this.width = 250,
    this.height = 150,
    this.buttonCount = 1,
    this.icons = Icons.campaign,
  }) : super(key: key);

  final IconData? icons;
  final String? contents;
  final String? cancelText;
  final String? confirmText;
  final Color? confirmColor;
  final VoidCallback? confirmFuntion;
  final Color? iconColor;
  final double? width;
  final double? height;
  final int? buttonCount;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<dynamic> show() {
    return Get.dialog(Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor, width: 2),
          color: Colors.white,
        ),
        height: height,
        width: width,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          icons,
                          color: iconColor,
                        ),
                        wBlank05,
                        Expanded(
                          child: Text(
                            contents ?? "",
                            style: Get.textTheme.bodyText2,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            hBlank20,
            buttonCount == 1
                ? GestureDetector(
                    onTap: confirmFuntion ??
                        () {
                          Get.back();
                        },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        alignment: Alignment.center,
                        width: width,
                        height: 40,
                        child: Text(
                          confirmText!,
                          style: Get.textTheme.subtitle2!
                              .apply(color: confirmColor),
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor,
                            ),
                            alignment: Alignment.center,
                            width: (width! / 2.5) - 0.5,
                            height: 40,
                            child: Text(
                              cancelText!,
                              style: Get.textTheme.subtitle2!
                                  .apply(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: whiteColor,
                        width: 1,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: GestureDetector(
                            onTap: confirmFuntion,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColor,
                              ),
                              alignment: Alignment.center,
                              width: (width! / 2) - 0.5,
                              height: 40,
                              child: Text(
                                confirmText!,
                                style: Get.textTheme.subtitle2!
                                    .apply(color: confirmColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    ));
  }
}
