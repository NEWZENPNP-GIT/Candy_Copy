import 'dart:io';

import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/repository/login_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  double headerHeight = Get.height * 0.25;
  double bottomHeight = 50;
  double bodyHeight = Get.height - (Get.height * 0.25) - 50;

  TextEditingController txtId = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  RxString errMsg = ''.obs;

  RxBool isLoging = false.obs;
  RxBool isFisting = false.obs;

  RxBool isLoginIdSaved = false.obs;

  @override
  void onInit() {
    //로그인 시 저장소 확인
    if (!Get.isRegistered<LoginRepository>()) {
      Get.put(LoginRepository());
    }

    super.onInit();

    isLocalAuth();
  }

  @override
  void dispose() {
    txtId.dispose();
    txtPass.dispose();
    super.dispose();
  }

  Future<String> login() async {
    if (!Get.isRegistered<LoginRepository>()) {
      Get.put(LoginRepository());
    }

    if (txtId.text.isEmpty) {
      errMsg('로그인 ID를 입력해 주세요');
      return errMsg.value;
    }

    if (!txtId.text.isEmail) {
      errMsg('로그인 ID를 이메일 형식으로 입력해 주세요');
      return errMsg.value;
    }

    if (txtPass.text.isEmpty) {
      errMsg('암호를 입력해 주세요');
      return errMsg.value;
    }

    isLoging(true);
    try {
      loginInfo = await LoginRepository.to.getLogin(txtId.text, txtPass.text);

      //로그인 성공 시 아이디 저장
      if (loginInfo.loginId?.isNotEmpty ?? false) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (isLoginIdSaved.value) {
          prefs.setBool('isLoginIdSaved', isLoginIdSaved.value);
          prefs.setString("savedloginId", txtId.text);
        } else {
          prefs.setBool('isLoginIdSaved', isLoginIdSaved.value);
          prefs.setString("savedloginId", "");
        }
      }
    } catch (e) {
      isLoging(false);
      errMsg('서버와의 연결이 원할하지 않습니다.');
      return errMsg.value;
    }

    isLoging(false);

    if (loginInfo.success!) {
      errMsg('');
    } else {
      errMsg(loginInfo.message!);
    }

    //로그인이후

    return errMsg.value;
  }

  Future<void> localLogin() async {
    isLoging(true);
    try {
      loginInfo = await LoginRepository.to.getLogin(txtId.text, txtPass.text);
    } catch (e) {
      isLoging(false);
      errMsg('서버와의 연결이 원할하지 않습니다.');
    }

    isLoging(false);

    //로그인 처리 이후 홈페이지로
  }

  Future<void> isLocalAuth() async {
    isFisting(true);
    //지문인식일 경우 지문인식처리
    //bool bReturn = await Common.gotoLocalAuth(true);

    bool returnBoolValue = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalAuthentication auth = LocalAuthentication();

    if (prefs.getBool('isAuth') ?? false) {
      try {
        bool isCanBio = await auth.canCheckBiometrics;
        bool isDeviceSupported = await auth.isDeviceSupported();

        // if ((Platform.isIOS || Platform.isAndroid) &&
        //     (availableBiometrics.contains(BiometricType.face) ||
        //         availableBiometrics.contains(BiometricType.fingerprint))) {
        //   returnBoolValue = await LocalAuthentication().authenticate(
        //       localizedReason: '로그인을 위해 휴대폰 인증 도구로 인증하세요.',
        //       options: AuthenticationOptions(biometricOnly: true));
        // }

        if ((Platform.isIOS || Platform.isAndroid) &&
            isCanBio &&
            isDeviceSupported) {
          returnBoolValue = await auth.authenticate(
              localizedReason: '로그인을 위해 휴대폰 인증 도구로 인증하세요.',
              options: AuthenticationOptions(biometricOnly: true));
        }
        // List<BiometricType> availableBiometrics =
        //     await LocalAuthentication().getAvailableBiometrics();

        // if ((Platform.isIOS || Platform.isAndroid) &&
        //     (availableBiometrics.contains(BiometricType.face) ||
        //         availableBiometrics.contains(BiometricType.fingerprint))) {
        //   returnBoolValue = await LocalAuthentication().authenticate(
        //       localizedReason: '로그인을 위해 휴대폰 인증 도구로 인증하세요.',
        //       options: AuthenticationOptions(biometricOnly: true));
        // }

        if (returnBoolValue) {
          loginInfo.bizId = prefs.getString("bizId");
          loginInfo.bizName = prefs.getString("bizName");
          loginInfo.loginId = prefs.getString("loginId");
          loginInfo.userId = prefs.getString("userId");
          loginInfo.userName = prefs.getString("userName");
        }
        // ignore: unused_catch_clause
      } on PlatformException catch (e) {
        isFisting(false);
        prefs.setBool("isAuth", false);
      }
    }

    if (prefs.getBool('isLoginIdSaved') ?? false) {
      isLoginIdSaved(prefs.getBool('isLoginIdSaved') ?? false);
      txtId.text = prefs.getString("savedloginId") ?? "";
    }
    isFisting(false);
    //return ;

    if (returnBoolValue) Get.offAllNamed('/');
  }

  void changeLoginSaved(bool changedValue) {
    isLoginIdSaved(changedValue);
  }
}
