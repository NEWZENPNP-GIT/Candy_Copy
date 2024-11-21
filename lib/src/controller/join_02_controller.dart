import 'package:candy/src/model/company_data_list.dart';
import 'package:candy/src/repository/join_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Join02Controller extends GetxController {
  static Join02Controller get to => Get.find();

  TextEditingController txtUserId = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtRePassword = TextEditingController();
  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtBirthDay = TextEditingController();
  TextEditingController txtEmpName = TextEditingController();
  TextEditingController txtMobilePhone = TextEditingController();
  TextEditingController txtConfirmNumber = TextEditingController();

  String resultBizId = "";
  String resultUserId = "";

  RxString errorUserIdMsg = "".obs;
  RxString errorPasswordMsg = "".obs;
  RxString errorRePasswordMsg = "".obs;
  RxString errorCompanyNameMsg = "".obs;
  RxString errorBirthDayMsg = "".obs;
  RxString errorEmpNameMsg = "".obs;
  RxString errorMobilePhoneMsg = ''.obs;
  RxString errorConfirmNumberMsg = ''.obs;

  RxBool isIdCheck = false.obs;
  RxBool isCompanyNameCheck = false.obs;
  RxBool isMobilePhoneCheck = false.obs;
  RxBool isConfirmNumberCheck = false.obs;

  Rx<CompanyDataList> compnayList = CompanyDataList().obs;
  RxInt companySelectedIndex = (-1).obs;
  RxBool isCompanySearching = false.obs;
  RxBool isSaving = false.obs;

  @override
  void dispose() {
    txtUserId.dispose();
    txtPassword.dispose();
    txtRePassword.dispose();
    txtCompanyName.dispose();
    txtBirthDay.dispose();
    txtEmpName.dispose();
    txtMobilePhone.dispose();
    txtConfirmNumber.dispose();
    super.dispose();
  }

  //사용자 ID 체크
  Future<bool> isUserIdValid() async {
    if (txtUserId.text.isEmpty) {
      errorUserIdMsg("사용자 아이디를 입력해 주세요.");
      isIdCheck(false);
      return false;
    }

    if (!txtUserId.text.isEmail) {
      errorUserIdMsg("이메일 형태로 입력해 주세요.");
      isIdCheck(false);
      return false;
    }

    //중복체크
    if (await JoinRepository.to.getUserIdList(txtUserId.text) > 0) {
      errorUserIdMsg("이미 사용중인 아이디입니다.");
      isIdCheck(false);
      return false;
    }

    errorUserIdMsg("");
    isIdCheck(true);
    return true;
  }

  //비밀번호 체크
  bool isPasswordValid() {
    if (txtPassword.text.isEmpty) {
      errorPasswordMsg("비밀번호를 입력해 주세요.");
      return false;
    }

    if (txtPassword.text.isNotEmpty &&
        (txtPassword.text.length < 6 || txtPassword.text.length > 16)) {
      errorPasswordMsg("영문,숫자 혼합하여 6~15자리로 입력해 주세요.");
      return false;
    }

    errorPasswordMsg('');

    return true;
  }

  //비밀번호 확인 체크
  bool isRePasswordValid() {
    if (txtRePassword.text.isEmpty) {
      errorRePasswordMsg("비밀번호를 입력해 주세요.");
      return false;
    }

    if (txtRePassword.text != txtPassword.text) {
      errorRePasswordMsg("비밀번호와 확인이 일치하지 않습니다.");
      return false;
    }

    errorRePasswordMsg('');
    return true;
  }

  //회사명 확인
  bool isCompanyNameVaild() {
    if (txtCompanyName.text.isEmpty) {
      errorCompanyNameMsg("회사명을 입력해 주세요.");
      isCompanyNameCheck(false);
      return false;
    }
    errorCompanyNameMsg('');
    return true;
  }

  //생년월일 확인
  bool isBirthDayValid() {
    if (txtBirthDay.text.isEmpty) {
      errorBirthDayMsg("생년월일을 입력해 주세요.");
      return false;
    }

    errorBirthDayMsg('');
    return true;
  }

  //성명확인
  bool isEmpNameValid() {
    if (txtEmpName.text.isEmpty) {
      errorEmpNameMsg("성명을 입력해 주세요.");
      return false;
    }

    if (txtEmpName.text.contains('_')) {
      errorEmpNameMsg("성명에 특수문자를 입력할수 없습니다.");
      return false;
    }

    errorEmpNameMsg("");
    return true;
  }

  //휴대전화번호
  bool isMobilePhoneValid() {
    if (txtMobilePhone.text.isEmpty) {
      errorMobilePhoneMsg("휴대전화번호를 입력해 주세요.");
      return false;
    }

    if (!isMobilePhoneCheck.value) {
      errorMobilePhoneMsg("인증번호 전송을 위해 보내기 아이콘을 눌러주세요.");
      return false;
    }

    errorMobilePhoneMsg("");
    return true;
  }

  //휴대전화번호
  bool isConfirmNumberValid() {
    if (txtConfirmNumber.text.isEmpty) {
      errorConfirmNumberMsg("전송된 인증번호를 입력해주세요.");
      return false;
    }

    if (!isConfirmNumberCheck.value) {
      errorConfirmNumberMsg("인증번호를 확인해 주세요.");
      return false;
    }

    errorConfirmNumberMsg("");
    return true;
  }

  //검색버튼 클릭시(false시 팝업, true는 비 팝업)
  Future<bool> checkCompany(String searchName) async {
    if (searchName.isEmpty || searchName.length < 2) {
      errorCompanyNameMsg("회사명을 2자 이상 입력해 주세요.");
      isCompanyNameCheck(false);
      return true;
    }

    isCompanySearching(true);
    compnayList(await JoinRepository.to.getBizNameList(searchName));
    isCompanySearching(false);

    if (compnayList.value.total == 1) {
      errorCompanyNameMsg("");
      resultBizId = compnayList.value.data![0].bizId!;
      txtCompanyName.text = compnayList.value.data![0].bizName!;
      isCompanyNameCheck(true);
      return true;
    } else if (compnayList.value.total! > 1) {
      errorCompanyNameMsg("회사가 1개이상 검색되었습니다.");
      isCompanyNameCheck(false);
      return false;
    } else {
      errorCompanyNameMsg("검색된 회사가 없습니다.");
      isCompanyNameCheck(false);
      return true;
    }
  }

  Future<bool> isValid() async {
    bool returnVal = false;

    returnVal = await isUserIdValid();
    if (!returnVal) return false;

    returnVal = isPasswordValid();
    if (!returnVal) return false;

    returnVal = isRePasswordValid();
    if (!returnVal) return false;

    returnVal = isCompanyNameVaild();
    if (!returnVal) return false;

    returnVal = isBirthDayValid();
    if (!returnVal) return false;

    returnVal = isEmpNameValid();
    if (!returnVal) return false;

    returnVal = isMobilePhoneValid();
    if (!returnVal) return false;

    returnVal = isConfirmNumberValid();
    if (!returnVal) return false;

    return true;
  }

  //인증번호 발송(1. 직원조회)
  Future<bool> sendCertNumber() async {
    if (resultBizId.isEmpty) {
      errorMobilePhoneMsg('회사검색을 먼저 진행해 주세요.');
      return false;
    }

    if (txtBirthDay.text.isEmpty) {
      errorMobilePhoneMsg('생년월일을 먼저 입력해 주세요.');
      return false;
    }

    if (txtEmpName.text.isEmpty) {
      errorMobilePhoneMsg('성명을 입력해 주세요.');
      return false;
    }

    if (txtMobilePhone.text.isEmpty) {
      errorMobilePhoneMsg('휴대번호를 입력해 주세요.');
      return false;
    }

    //서버조회
    var response = await JoinRepository.to.getCertEmp(
        resultBizId, txtBirthDay.text, txtEmpName.text, txtMobilePhone.text);

    if (response['success'] as bool) {
      if (response['total'] as int == 1) {
        resultUserId = response['data'][0]['userId'];
        //인증번호전송
        sendCertNumberStep02();
        return true;
      } else if (response['total'] as int == 0) {
        if (response['join_total'] as int <= 0) {
          errorMobilePhoneMsg('등록되어 있는 근로자가 없습니다.');
          return false;
        } else {
          errorMobilePhoneMsg('이미 가입되어 있습니다.');
          return false;
        }
      } else {
        errorMobilePhoneMsg('*(중복사원) 인사팀에 문의하세요.');
      }
    } else {
      errorMobilePhoneMsg('입력하신 정보가 존재하지 않습니다.');
      return false;
    }

    return true;
  }

  //인증번호 발송(인증번호발송)
  Future<bool> sendCertNumberStep02() async {
    if (isConfirmNumberCheck.value) {
      errorMobilePhoneMsg('이미 직원인증을 진행하셨습니다.');
      return false;
    }

    var response =
        await JoinRepository.to.sendCertNumber(resultBizId, resultUserId);

    if (response['success'] as bool) {
      if (response['total'] as int > 0) {
        errorMobilePhoneMsg('인증번호를 발송하였습니다.');
        isMobilePhoneCheck(true);
        return true;
      } else {
        errorMobilePhoneMsg('직원정보를 찾을 수 없습니다.');
        return false;
      }
    }

    return true;
  }

  //인증번호확인
  Future<bool> checkCertNumber() async {
    if (isConfirmNumberCheck.value) {
      errorMobilePhoneMsg('이미 직원인증을 진행하셨습니다.');
      return false;
    }

    var response = await JoinRepository.to
        .checkCertNumber(txtMobilePhone.text, txtConfirmNumber.text);

    if (response['success'] as bool) {
      if (response['total'] as int == 1) {
        errorMobilePhoneMsg('');
        errorConfirmNumberMsg('');
        isConfirmNumberCheck(true);
        isConfirmNumberCheck(true);
        return true;
      } else {
        errorConfirmNumberMsg('인증번호를 다시 전송하여주세요');
        isMobilePhoneCheck(false);
        isConfirmNumberCheck(false);
        return false;
      }
    }

    return true;
  }

  //회사 검색 한개 선택
  void setSelectedIndex(int index) {
    if (compnayList.value.data != null && compnayList.value.data!.isNotEmpty) {
      compnayList.update(
        (val) {
          for (var e in val!.data!) {
            e.isSelected = false;
          }
        },
      );

      compnayList.update(
        (val) {
          val!.data![index].isSelected = true;
        },
      );
    }

    companySelectedIndex(index);
  }

  //회원가입
  Future<bool> saveMemberJoin() async {
    isSaving(true);
    var response = await JoinRepository.to.saveMemberJoin(
        txtUserId.text, resultUserId, txtPassword.text, txtEmpName.text);
    isSaving(false);
    if (response['success'] as bool) {
      return true;
    } else {
      return false;
    }
  }
}
