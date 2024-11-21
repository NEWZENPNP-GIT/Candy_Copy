import 'package:candy/src/pages/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key, this.text, this.press, this.color, this.buttonTextStyle})
      : super(key: key);

  final String? text;
  final GestureTapCallback? press;
  final Color? color;
  final TextStyle? buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color ?? primaryColor,
        padding: const EdgeInsets.all(16),
      ),
      onPressed: press,
      child: Center(
        child: Text(
          text ?? "",
          style: buttonTextStyle ??
              Get.textTheme.subtitle1!.apply(color: whiteColor),
        ),
      ),
    );
  }
}
