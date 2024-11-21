import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/common.dart';
import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/controller/contract_list_controller.dart';
import 'package:candy/src/pages/contract/contract_list_widget.dart';
import 'package:candy/src/pages/payment/password_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractList extends GetView<ContractListController> {
  const ContractList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarTitle(
        title: '전자근로계약',
        backgroundColor: kColorContract,
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
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
              controller.getContractList();
            },
            child: (controller.contractList.value.items == null ||
                    controller.contractList.value.items!.isEmpty)
                ? Center(
                    child: Text(
                      '생성된 전자계약서가 없습니다.',
                      style: Get.textTheme.headline1,
                    ),
                  )
                : Scrollbar(
                    child: ListView.builder(
                      itemCount: controller.contractList.value.items == null
                          ? 0
                          : controller.contractList.value.items!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (controller.contractList.value.items![index]
                                          .digitNonce ==
                                      null ||
                                  controller.contractList.value.items![index]
                                      .digitNonce!.isEmpty) {
                                const CommonDaialog(
                                  contents: '유효하지 않은 데이터 입니다.',
                                ).show();
                              } else {
                                //지문인식 성공시
                                Common.gotoLocalAuth(false).then(
                                  (value) {
                                    if (value) {
                                      Get.toNamed('/contract_view', arguments: {
                                        'FileUrl':
                                            '$baseURL/contract/downContractPdf.do?id=${controller.contractList.value.items![index].digitNonce!}&type=pdf'
                                      });
                                    } else {
                                      //지문인식 안되면
                                      PasswordCheck().show().then((value) {
                                        if (value) {
                                          Get.toNamed('/contract_view',
                                              arguments: {
                                                'FileUrl':
                                                    '$baseURL/contract/downContractPdf.do?id=${controller.contractList.value.items![index].digitNonce!}&type=pdf'
                                              });
                                        }
                                      });
                                    }
                                  },
                                );
                              }
                            },
                            child: Column(
                              children: [
                                hBlank10,
                                ContractListWidget(
                                  contract: controller
                                      .contractList.value.items![index],
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
