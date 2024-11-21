import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/common_dialog.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/pages/commons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class ContractView extends StatefulWidget {
  const ContractView({Key? key}) : super(key: key);

  @override
  State<ContractView> createState() => _ContractViewState();
}

class _ContractViewState extends State<ContractView> {
  bool isFail = false;
  bool isLoading = false;
  bool isFirst = true;

  late final PdfController pdfController;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  void loadPdf() {
    String fileUrl = Get.arguments['FileUrl'];
    setState(() {
      isLoading = true;
    });
    pdfController = PdfController(
      document: PdfDocument.openData(InternetFile.get(fileUrl)),
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarTitle(
        title: '전자근로계약',
        backgroundColor: kColorContract,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: PdfView(
                      controller: pdfController,
                      onDocumentError: (value) {
                        Get.back();
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
    );
  }
}
