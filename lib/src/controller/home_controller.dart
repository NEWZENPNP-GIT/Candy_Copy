import 'dart:io';

import 'package:candy/src/model/attend_data_list.dart';
import 'package:candy/src/pages/commons/common.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:candy/src/repository/home_repository.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  late String userName;
  late String userId;
  late String bizId;
  late String loginId;

  RxBool isLoading = false.obs;

  RxString lastInTime = ''.obs;
  RxString lastOutTime = ''.obs;
  RxString contractDate = ''.obs;
  RxString contractTypeName = ''.obs;
  RxString payStubDay = ''.obs;

  final Rxn<RemoteMessage> message = Rxn<RemoteMessage>();

  @override
  void onInit() {
    if (!Get.isRegistered<HomeRepository>()) {
      Get.put(HomeRepository());
    }
    setInitValue();
    getInitData();
    //푸쉬 초기화
    pushInitialize();
    super.onInit();
  }

  void setInitValue() {
    userName = loginInfo.userName ?? "";
    userId = loginInfo.userId ?? "";
    bizId = loginInfo.bizId ?? "";
    loginId = loginInfo.loginId ?? "";
  }

  //홈 화면 데이터 가지고 오기
  Future getInitData() async {
    isLoading(true);
    try {
      lastInTime('');
      lastOutTime('');
      contractDate('');
      contractTypeName('');
      payStubDay('');

      AttendDataList attendList =
          await HomeRepository.to.getAttendList(userId, bizId);

      if (attendList.attends != null && attendList.attends!.isNotEmpty) {
        if (attendList.attends![0].dateFrom != null &&
            attendList.attends![0].dateFrom!.length > 8) {
          DateTime inDateTime =
              Common.stringToDateTime(attendList.attends![0].dateFrom!);
          lastInTime(DateFormat('yy.MM.dd HH:mm').format(inDateTime));
        }

        if (attendList.attends![0].dateTo != null &&
            attendList.attends![0].dateTo!.length > 8) {
          DateTime outDateTime =
              Common.stringToDateTime(attendList.attends![0].dateTo!);
          lastOutTime(DateFormat('yy.MM.dd HH:mm').format(outDateTime));
        }
      }

      //메인정보가지고오기
      var mainResponse =
          await HomeRepository.to.getMainInfo(userId, bizId, loginId);

      //계약정보 세팅
      if (mainResponse['success'] as bool) {
        var contractInfo = mainResponse['계약정보'];
        if (contractInfo != null) {
          contractTypeName(contractInfo['contractTypeName']);

          if (contractInfo['contractDate'] != null) {
            DateTime contractDateDate =
                Common.stringToDateTime(contractInfo['contractDate']);
            contractDate(DateFormat('yy.MM.dd').format(contractDateDate));
          }
        }

        //임금명세서 정보 세팅
        var payStubInfo = mainResponse['급여정보'];
        if (payStubInfo != null) {
          if (payStubInfo['payDate'] != null) {
            DateTime payStubDateDate =
                Common.stringToDateTime(payStubInfo['payDate']);
            payStubDay(DateFormat('yy.MM.dd').format(payStubDateDate));
          }
        }
      }

      //암호입력대상정보가지고오기
      if (mainResponse['암호입력대상정보'] as bool) {
        loginInfo.isPaystubPassword = 'Y';
      } else {
        loginInfo.isPaystubPassword = 'N';
      }
    } catch (e) {
      isLoading(false);
    }

    isLoading(false);
  }

  Future<bool> pushInitialize() async {
    //Firebase 초기화
    await Firebase.initializeApp();

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    // Android용 새 Notification Channel
    const AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      'high_candy_channel', // 임의의 id
      '캔디', // 설정에 보일 채널명
      description: '캔디 관련 중요한 알림 메시지', // 설정에 보일 채널 설명
      importance: Importance.max,
    );

    // Notification Channel을 디바이스에 생성
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    // FlutterLocalNotificationsPlugin 초기화. 이 부분은 notification icon 부분에서 다시 다룬다.
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings()),
      onDidReceiveNotificationResponse: (details) {},
    );
    //onSelectNotification: (String? payload) async {});

    FirebaseMessaging.onMessage.listen((event) {
      message.value = event;
      RemoteNotification? notification = event.notification;
      AndroidNotification? android = event.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          0,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidNotificationChannel
                  .id, // AndroidNotificationChannel()에서 생성한 ID
              androidNotificationChannel.name,
              channelDescription: androidNotificationChannel.description,
              icon: android.smallIcon,
            ),
          ),
        );
      }
    });

    // 사용자가 푸시 알림을 허용했는지 확인 (optional)
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final isFCMEnabled = prefs.getBool('FCM_ENABLED') ?? true;
    final bool isSavedToken = prefs.getBool('FCM_SAVED') ?? false;
    final String savedLoginId = prefs.getString('FCM_SAVED_LoginId') ?? "";

    if (isFCMEnabled) {
      if (!isSavedToken || (loginInfo.loginId! != savedLoginId)) {
        // firebase token 발급
        String? firebaseToken = await FirebaseMessaging.instance.getToken();

        // 서버로 firebase token 갱신
        if (firebaseToken != null) {
          //토큰전송
          String deviceId = await getDeviceUniqueId();
          //기기정보
          var deviceInfo = await _getDeviceInfo();
          var resultValue = await HomeRepository.to.setUserDevice(
            loginInfo.loginId!,
            deviceId,
            firebaseToken,
            deviceInfo['device'].toString(),
            Platform.isAndroid ? 'Android' : 'IOS',
            deviceInfo['osVersion'].toString(),
          );

          prefs.setString('FCM_SAVED_LoginId', loginInfo.loginId!);
          prefs.setBool('FCM_SAVED', resultValue);
        }
      }
    }
    return true;
  }

  Future<String> getDeviceUniqueId() async {
    var deviceIdentifier = 'unknown';
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.id!;
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor!;
    } else if (Platform.isLinux) {
      var linuxInfo = await deviceInfo.linuxInfo;
      deviceIdentifier = linuxInfo.machineId!;
    } else if (kIsWeb) {
      var webInfo = await deviceInfo.webBrowserInfo;
      deviceIdentifier = webInfo.vendor! +
          webInfo.userAgent! +
          webInfo.hardwareConcurrency.toString();
    }

    return deviceIdentifier;
  }

  //device정보 가지고 오기
  Future<Map<String, dynamic>> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidDeviceInfo(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } catch (error) {
      deviceData = {"Error": "Failed to get platform version."};
    }

    return deviceData;
  }

  Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo info) {
    var release = info.version.release;
    var sdkInt = info.version.sdkInt;
    var manufacturer = info.manufacturer;
    var model = info.model;

    return {
      "osVersion": "Android $release (SDK $sdkInt)",
      "device": "$manufacturer $model"
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo info) {
    var systemName = info.systemName;
    var version = info.systemVersion;
    var machine = info.utsname.machine;

    return {"osVersion": "$systemName $version", "device": "$machine"};
  }
}
