import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/model/contract.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractListWidget extends StatelessWidget {
  const ContractListWidget({
    Key? key,
    this.isNew = false,
    this.contract,
  }) : super(key: key);

  final bool? isNew;
  final Contract? contract;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
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
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: const Color(0xFFD9E7FF),
                ),
                height: 70,
                width: 70,
                child: Image.asset(
                  'assets/images/icon_doc_complete.png',
                  scale: 2.5,
                ),
              ),
            ),
            wBlank30,
            Expanded(
              child: Text(
                '${contract!.contractName!} - ${contract!.contractFileName!}',
                style: Get.textTheme.subtitle1,
              ),
            )
          ],
        ));
  }
}
