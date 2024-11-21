import 'dart:io';

import 'package:candy/src/pages/commons/constants.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Common {
  //급여 명세서 월분 글씨 보여주기
  static String showDateYearMonthPaymonth(String? value) {
    if (value == null) {
      return '';
    }

    if (value.length == 6) {
      return value.substring(0, 4) + '년 ' + value.substring(4, 6) + '월분';
    }

    return '';
  }

  static String showStringToFormat(String? value) {
    if (value == null) {
      return '';
    }

    if (value.length == 8) {
      return value.substring(0, 4) +
          '-' +
          value.substring(4, 6) +
          '-' +
          value.substring(6, 8);
    }

    return '';
  }

  static DateTime stringToDateTime(String dateTimeString) {
    String date = dateTimeString;
    String dateWithT = '';
    if (dateTimeString.length > 8) {
      dateWithT = date.substring(0, 8) + 'T' + date.substring(8);
    } else {
      dateWithT = date.substring(0, 8) + 'T' + '000000';
    }
    return DateTime.parse(dateWithT);
  }

  static void logout() {}

  static bool isPasswordCheck = false;

  static Future<bool> setLocalAuth() async {
    bool returnBoolValue = false;
    bool isCanBio = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalAuthentication auth = LocalAuthentication();

    try {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      isCanBio = await auth.canCheckBiometrics;
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

      if (returnBoolValue) {
        prefs.setString("bizId", loginInfo.bizId ?? '');
        prefs.setString("bizName", loginInfo.bizName ?? '');
        prefs.setString("loginId", loginInfo.loginId ?? '');
        prefs.setString("userId", loginInfo.userId ?? '');
        prefs.setString("userName", loginInfo.userName ?? '');
        prefs.setBool("isAuth", true);
      }
      // ignore: unused_catch_clause
    } on PlatformException catch (e) {
      prefs.setBool("isAuth", false);
    }

    return returnBoolValue;
  }

  static Future<bool> gotoLocalAuth(bool setLoginInfo) async {
    bool returnBoolValue = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LocalAuthentication auth = LocalAuthentication();

    if (prefs.getBool('isAuth') ?? false) {
      try {
        bool isCanBio = await auth.canCheckBiometrics;
        bool isDeviceSupported = await auth.isDeviceSupported();

        // List<BiometricType> availableBiometrics =
        //     await LocalAuthentication().getAvailableBiometrics();

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

        if (returnBoolValue) {
          if (setLoginInfo) {
            loginInfo.bizId = prefs.getString("bizId");
            loginInfo.bizName = prefs.getString("bizName");
            loginInfo.loginId = prefs.getString("loginId");
            loginInfo.userId = prefs.getString("userId");
            loginInfo.userName = prefs.getString("userName");
          }
        }
        // ignore: unused_catch_clause
      } on PlatformException catch (e) {
        prefs.setBool("isAuth", false);
      }
    }
    return returnBoolValue;
  }

  static Future<bool> isCanFirstLocalAuth() async {
    bool returnBoolValue = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if ((prefs.getBool('isAuth') ?? false) &&
        (prefs.getBool('isFirst') ?? true)) {
      try {
        List<BiometricType> availableBiometrics =
            await LocalAuthentication().getAvailableBiometrics();

        if ((Platform.isIOS || Platform.isAndroid) &&
            (availableBiometrics.contains(BiometricType.face) ||
                availableBiometrics.contains(BiometricType.fingerprint))) {
          returnBoolValue = true;
        }
        // ignore: unused_catch_clause
      } on PlatformException catch (e) {
        prefs.setBool("isAuth", false);
      }
    }

    prefs.setBool("isFirst", false);
    return returnBoolValue;
  }
}
