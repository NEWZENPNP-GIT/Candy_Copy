import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarTitle extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTitle({
    Key? key,
    this.title,
    this.titleColor,
    this.backgroundColor,
    this.isShowMenu = true,
  }) : super(key: key);

  final String? title;
  final Color? titleColor;
  final Color? backgroundColor;
  final bool? isShowMenu;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: backgroundColor ?? primaryColor,
        elevation: 0,
        title: Text(title ?? "",
            style: Get.textTheme.headline1!
                .apply(color: titleColor ?? whiteColor)),
        centerTitle: true,
        actions: [
          isShowMenu!
              ? GestureDetector(
                  onTap: () {
                    const Menu().show();
                  },
                  child: const Icon(
                    Icons.menu,
                  ))
              : Container(),
          wBlank10,
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
