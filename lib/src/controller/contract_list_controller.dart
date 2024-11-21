import 'package:candy/src/model/contract_data_list.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/repository/contract_repository.dart';
import 'package:get/get.dart';

class ContractListController extends GetxController {
  Rx<ContractDataList> contractList = ContractDataList().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    if (!Get.isRegistered<ContractRepository>()) {
      Get.put(ContractRepository());
    }

    getContractList();
    super.onInit();
  }

  Future<void> getContractList() async {
    isLoading(true);

    contractList(await ContractRepository.to
        .getContractList(loginInfo.loginId!, loginInfo.bizId!));

    isLoading(false);
  }
}
