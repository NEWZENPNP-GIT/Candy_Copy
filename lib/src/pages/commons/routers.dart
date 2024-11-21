import 'package:candy/src/controller/commute_controller.dart';
import 'package:candy/src/controller/commute_list_controller.dart';
import 'package:candy/src/controller/contract_list_controller.dart';
import 'package:candy/src/controller/contract_password_check_controller.dart';
import 'package:candy/src/controller/faq_controller.dart';
import 'package:candy/src/controller/home_controller.dart';
import 'package:candy/src/controller/join_01_controller.dart';
import 'package:candy/src/controller/join_02_controller.dart';
import 'package:candy/src/controller/login_controller.dart';
import 'package:candy/src/controller/mypage_controller.dart';
import 'package:candy/src/controller/notice_list_controller.dart';
import 'package:candy/src/controller/password_check_controller.dart';
import 'package:candy/src/controller/payment_list_contorller.dart';
import 'package:candy/src/controller/payment_view_contoller.dart';
import 'package:candy/src/pages/commute/commute.dart';
import 'package:candy/src/pages/commute/commute_list.dart';
import 'package:candy/src/pages/contract/contract_list.dart';
import 'package:candy/src/pages/contract/contract_password_check.dart';
import 'package:candy/src/pages/contract/contract_view.dart';
import 'package:candy/src/pages/home/home.dart';
import 'package:candy/src/pages/login/login.dart';
import 'package:candy/src/pages/member_join/join_01.dart';
import 'package:candy/src/pages/member_join/join_02.dart';
import 'package:candy/src/pages/member_join/join_end.dart';
import 'package:candy/src/pages/mypage/mypage.dart';
import 'package:candy/src/pages/notice/faq.dart';
import 'package:candy/src/pages/notice/notice_detail.dart';
import 'package:candy/src/pages/notice/notice_list.dart';
import 'package:candy/src/pages/payment/password_check.dart';
import 'package:candy/src/pages/payment/payment_list.dart';
import 'package:candy/src/pages/payment/payment_view.dart';
import 'package:get/get.dart';

class Routes {
  static final routes = [
    GetPage(
        name: '/',
        page: () => const Home(),
        binding: BindingsBuilder(() {
          Get.put<HomeController>(HomeController());
        })),
    GetPage(
        name: '/login',
        page: () => const Login(),
        binding: BindingsBuilder(() {
          Get.put<LoginController>(LoginController());
        })),
    GetPage(
        name: '/join01',
        page: () => const Join01(),
        binding: BindingsBuilder(() {
          Get.put<Join01Controller>(Join01Controller());
        })),
    GetPage(
        name: '/join02',
        page: () => const Join02(),
        binding: BindingsBuilder(() {
          Get.put<Join02Controller>(Join02Controller());
        })),
    GetPage(
      name: '/join_end',
      page: () => const JoinEnd(),
      // binding: BindingsBuilder(() {
      //   Get.put<Join02Controller>(Join02Controller());
      // },)
    ),
    GetPage(
        name: '/paymentList',
        page: () => const PaymentList(),
        binding: BindingsBuilder(() {
          Get.put<PaymentListController>(PaymentListController());
        })),
    GetPage(
        name: '/contract_password_check',
        page: () => ContractPasswordCheck(),
        binding: BindingsBuilder(() {
          Get.put<ContractPasswordCheckController>(
              ContractPasswordCheckController());
        })),
    GetPage(
        name: '/password_check',
        page: () => PasswordCheck(),
        binding: BindingsBuilder(() {
          Get.put<PasswordCheckController>(PasswordCheckController());
        })),
    GetPage(
      name: '/contract_view',
      page: () => const ContractView(),
    ),
    GetPage(
      name: '/payment_view',
      page: () => const PaymentView(),
      binding: BindingsBuilder(() {
        Get.put<PaymentViewController>(PaymentViewController());
      }),
    ),
    GetPage(
        name: '/commute',
        page: () => const Commute(),
        binding: BindingsBuilder(() {
          Get.put<CommuteController>(CommuteController());
        })),
    GetPage(
        name: '/commuteList',
        page: () => const CommuteList(),
        binding: BindingsBuilder(() {
          Get.put<CommuteListController>(CommuteListController());
        })),
    GetPage(
        name: '/contractList',
        page: () => const ContractList(),
        binding: BindingsBuilder(() {
          Get.put<ContractListController>(ContractListController());
        })),
    GetPage(
        name: '/noticeList',
        page: () => const NoticeList(),
        binding: BindingsBuilder(() {
          Get.put<NoticeListController>(NoticeListController());
        })),
    GetPage(
      name: '/notice_detail',
      page: () => const NoticeDetail(),
      binding: BindingsBuilder(() {
        Get.put<NoticeListController>(NoticeListController());
      }),
    ),
    GetPage(
        name: '/myPage',
        page: () => const MyPage(),
        binding: BindingsBuilder(() {
          Get.put<MyPageController>(MyPageController());
        })),
    GetPage(
        name: '/faq',
        page: () => const Faq(),
        binding: BindingsBuilder(() {
          Get.put<FaqController>(FaqController());
        })),
  ];
}
