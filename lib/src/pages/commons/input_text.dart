import 'package:candy/src/pages/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InputText extends StatelessWidget {
  const InputText({
    Key? key,
    this.labelText,
    this.hintText,
    this.isPasswordForm = false,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.borderColor,
    this.hintFontSize,
    this.controller,
    this.isEditalb,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.labelTextStyle,
    this.isDense,
    this.isRequied = false,
    this.isBigBox = true,
    this.isAutofocus = false,
    this.initalValue,
    this.textAlign,
    this.focusNode,
    this.onTab,
    this.icon,
    this.isSmallBox = false,
    this.onIconClick,
    this.iconColor,
    this.errorText,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final bool? isPasswordForm;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Function()? onIconClick;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final double? hintFontSize;
  final TextEditingController? controller;
  final bool? isEditalb;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextStyle? labelTextStyle;
  final bool? isDense;
  final bool? isRequied;
  final bool? isBigBox;
  final bool? isAutofocus;
  final String? initalValue;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final Function()? onTab;
  final IconData? icon;
  final bool? isSmallBox;
  final Color? iconColor;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText == null
            ? Container()
            : Row(
                children: [
                  Text(
                    labelText ?? "",
                    style: labelTextStyle ??
                        Get.textTheme.headline4!.apply(color: primaryColor),
                  ),
                  wBlank05,
                  isRequied!
                      ? Text(
                          "*",
                          style:
                              Get.textTheme.headline4!.apply(color: Colors.red),
                        )
                      : Container()
                ],
              ),
        hBlank10,
        Stack(
          children: [
            TextFormField(
              onTap: onTab,
              focusNode: focusNode,
              textAlign: textAlign ?? TextAlign.start,
              initialValue: initalValue,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              controller: controller,
              obscureText: isPasswordForm!,
              onSaved: onSaved,
              onChanged: onChanged,
              validator: validator,
              readOnly: isEditalb == null ? false : !isEditalb!,
              style: Get.textTheme.bodyText1,
              keyboardType: keyboardType,
              autofocus: isAutofocus ?? false,
              decoration: InputDecoration(
                border: outlineInputBorder(borderColor ?? kColor2E),
                enabledBorder: outlineInputBorder(borderColor ?? kColor2E),
                focusedBorder: outlineInputBorder(borderColor ?? kColor2E),
                errorBorder: outlineInputBorder(
                    (errorText == null || errorText!.isEmpty)
                        ? kColorE0
                        : kColorCA),
                disabledBorder: InputBorder.none,
                contentPadding: isBigBox!
                    ? const EdgeInsets.only(
                        left: 16, top: 16, bottom: 16, right: 16)
                    : isSmallBox!
                        ? const EdgeInsets.only(
                            left: 16, top: 4, bottom: 4, right: 16)
                        : const EdgeInsets.only(
                            left: 16, top: 8, bottom: 8, right: 16),
                isDense: isDense,
                filled: true,
                fillColor: isEditalb == null
                    ? Colors.white
                    : isEditalb!
                        ? Colors.white
                        : kColorE0,
                hintStyle: TextStyle(
                    color: Colors.grey[400], fontSize: hintFontSize ?? 16),
                hintText: hintText,
                errorText: errorText,
                errorMaxLines: 2,
              ),
            ),
            icon == null
                ? Container()
                : Positioned(
                    right: 10,
                    top: 8,
                    child: GestureDetector(
                      onTap: onIconClick,
                      child: Icon(
                        icon,
                        color: iconColor ?? Colors.grey.withOpacity(0.5),
                        size: 30,
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  OutlineInputBorder outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1),
      borderRadius: BorderRadius.circular(5),
    );
  }
}
