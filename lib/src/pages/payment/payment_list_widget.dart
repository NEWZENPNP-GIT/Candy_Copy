import 'package:candy/src/pages/commons/common.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/model/payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentListWidget extends StatelessWidget {
  const PaymentListWidget({
    Key? key,
    this.isNew = false,
    this.payment,
  }) : super(key: key);

  final bool? isNew;
  final Payment? payment;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kColorE0, width: 1),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 0,
              blurRadius: 5.0,
              offset: const Offset(5, 5), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hBlank20,
                  Text(
                    Common.showDateYearMonthPaymonth(payment!.payMonth),
                    style: Get.textTheme.headline2!.apply(
                        color:
                            payment!.isNew! ? kColorNewPayment : kColorPayment),
                  ),
                  hBlank05,
                  Text(
                    '임금명세서',
                    style: Get.textTheme.headline3,
                  ),
                  hBlank10,
                  Container(
                      height: 1, width: Get.width / 2, color: Colors.black87),
                  hBlank10,
                  Text(
                    Common.showStringToFormat(payment!.payDate),
                    style: Get.textTheme.bodyText2!
                        .apply(color: Colors.grey.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: payment!.isNew!
                    ? Image.asset('assets/images/icon_pay_new.png')
                    : Image.asset('assets/images/icon_pay_default.png'),
              ),
            )
          ],
        ));
  }
}
