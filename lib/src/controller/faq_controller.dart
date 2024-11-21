import 'package:get/get.dart';

class FaqController extends GetxController {

  List<Map<String, String>> boardList = [];

  @override
  void onInit() {
    setBoardList();
    getFaqList();
    super.onInit();
  }

  void setBoardList() {
    boardList.add({'id': '002', 'Name': '전자계약'});
    boardList.add({'id': '004', 'Name': '급여명세'});
    boardList.add({'id': '004', 'Name': '캔디모바일'});
  }

  Future<void> getFaqList() async {
    
  }
}
