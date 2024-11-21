import 'package:candy/src/pages/commons/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindIdListDialog extends StatelessWidget {
  const FindIdListDialog({
    Key? key,
    this.userList,
  }) : super(key: key);

  final List? userList;
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
        height: 200,
        width: Get.width - 80,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '회사명',
                    style: Get.textTheme.subtitle1,
                  ),
                  Text(
                    '아이디',
                    style: Get.textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: userList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16, top: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                '${userList![index]['bizName']}',
                                style: Get.textTheme.bodyText1,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${userList![index]['userId']}',
                                style: Get.textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
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
                  height: 40,
                  child: Text(
                    "확인",
                    style: Get.textTheme.subtitle2!.apply(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
