import 'package:candy/src/controller/payment_view_contoller.dart';
import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

class PaymentView extends GetView<PaymentViewController> {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getPdfView();
    return Scaffold(
      appBar: const AppBarTitle(
        title: '임금명세서',
        backgroundColor: Color(0xFF00AD9C),
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : PdfView(
                        controller: controller.pdfController,
                        onDocumentError: (value) {
                          const CommonDaialog(
                            contents: 'PDF 보기 오류가 발생했습니다.',
                          ).show();
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                  text: "확인",
                  press: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
