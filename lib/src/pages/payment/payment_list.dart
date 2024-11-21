import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/controller/payment_list_contorller.dart';
import 'package:candy/src/pages/payment/payment_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentList extends GetView<PaymentListController> {
  const PaymentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarTitle(
        title: '임금명세서',
        backgroundColor: Color(0xFF00AD9C),
      ),
      body: Obx(
        () => SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _buildList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () async {
              controller.getPaymentList();
            },
            child: (controller.paymentList.value.items == null ||
                    controller.paymentList.value.items!.isEmpty)
                ? Center(
                    child: Text(
                      '생성된 임금명세서가 없습니다.',
                      style: Get.textTheme.headline1,
                    ),
                  )
                : Scrollbar(
                    child: ListView.builder(
                      itemCount: controller.paymentList.value.items!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              controller.gotoView(index).then((value) {
                                if (value['success'] as bool) {
                                  Get.toNamed('/payment_view',
                                      arguments: {'FileUrl': value['fileUrl']});
                                } else {
                                  if (value['message'].toString().isNotEmpty) {
                                    CommonDaialog(
                                      contents: value['message'],
                                    ).show();
                                  }
                                }
                              });
                            },
                            child: Column(
                              children: [
                                hBlank10,
                                PaymentListWidget(
                                  payment: controller
                                      .paymentList.value.items![index],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          );
  }
}
