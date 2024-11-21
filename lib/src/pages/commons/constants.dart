//공백세팅
import 'package:candy/src/model/login_info.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

//URL 개발
const baseURL = 'https://ieumsign.newzenpnp.co.kr/';
//URL 로컬
//const baseURL = 'http://192.168.0.8:8080/';
//const baseURL = 'http://localhost:8080/';
// 운영
// const baseURL = 'https://ieumsign.co.kr/';

const hBlank50 = SizedBox(height: 50);
const hBlank40 = SizedBox(height: 40);
const hBlank30 = SizedBox(height: 30);
const hBlank20 = SizedBox(height: 20);
const hBlank15 = SizedBox(height: 15);
const hBlank10 = SizedBox(height: 10);
const hBlank05 = SizedBox(height: 5);

const wBlank50 = SizedBox(width: 50);
const wBlank30 = SizedBox(width: 30);
const wBlank20 = SizedBox(width: 20);
const wBlank15 = SizedBox(width: 15);
const wBlank10 = SizedBox(width: 10);
const wBlank05 = SizedBox(width: 5);

//Color
const primaryColor = Color(0xFF2097DA);
const whiteColor = Colors.white;
const kColor48 = Color(0xff484561);
const kColorFB = Color(0xffFB7E0B);
const kColorE0 = Color(0xffE0DED7);
const kColor97 = Color(0xff979797);
const kColor73 = Color(0xff737373);
const kColorCA = Color(0xffCA0026);
const kColorEB = Color(0xffEBE3D5);
const kColor2E = Color(0xff2E2B4B);
const kErrorColor = Colors.red;
const kColorPayment = Color(0xFF1EBFAE);
const kColorNewPayment = Color(0xFFFF98A6);
const kColorContract = Color(0xFF4949B5);
const kColorFaq = Color(0xFF4BBEFF);

const kColorCommute = Color(0xFF0C8297);

final hLine = Container(height: 1, color: primaryColor);
final hWhiteLine = Container(height: 1, color: whiteColor);
final hGrayLine = Container(height: 1, color: Colors.grey.withOpacity(0.3));

//로그인관련 ID
LoginInfo loginInfo = LoginInfo();

final dateFormatter =
    MaskTextInputFormatter(mask: '####.##.##', filter: {"#": RegExp(r'[0-9]')});

final digit8 =
    MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')});

final digit11 = MaskTextInputFormatter(
    mask: '###########', filter: {"#": RegExp(r'[0-9]')});

final digit10 =
    MaskTextInputFormatter(mask: '##########', filter: {"#": RegExp(r'[0-9]')});
