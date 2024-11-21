import 'package:get/get.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class PaymentViewController extends GetxController {
  RxBool isLoading = false.obs;

  late PdfController pdfController;

  String fileUrl = "";

  void getPdfView() async {
    isLoading(true);
    fileUrl = Get.arguments['FileUrl'];

    pdfController = PdfController(
        document: PdfDocument.openData(InternetFile.get(fileUrl)));

    isLoading(false);
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }
}
