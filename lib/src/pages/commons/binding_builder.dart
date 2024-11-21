import 'package:candy/src/repository/join_repository.dart';
import 'package:get/get.dart';

class BindingBuilder implements Bindings {
  @override
  void dependencies() {
    Get.put(JoinRepository());
  }
}
