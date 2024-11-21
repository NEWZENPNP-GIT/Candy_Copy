import 'package:intl/intl.dart';

class Payment {
  String? payMonth;
  String? payDate;
  String? fileId;
  String? insDate;
  String? payDatePrint;
  String? payFormType;
  String? payType;
  String? payTypeName;
  String? payMonthPrint;
  String? transType;
  bool? isNew;

  Payment({
    this.payMonth,
    this.payDate,
    this.fileId,
    this.insDate,
    this.payDatePrint,
    this.payFormType,
    this.payType,
    this.payTypeName,
    this.payMonthPrint,
    this.transType,
    this.isNew,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        payDate: json['payDate'],
        payMonth: json['payMonth'],
        fileId: json['fileId'],
        insDate: json['insDate'],
        payDatePrint: json['payDatePrint'],
        payFormType: json['payFormType'],
        payType: json['payType'],
        payTypeName: json['payTypeName'],
        payMonthPrint: json['payMonthPrint'],
        transType: json['transType'],
        isNew:
            (json['payMonth'] == DateFormat('yyyyMM').format(DateTime.now())),
      );

  Map<String, dynamic> toJson() => {
        'payDate': payDate,
        'payMonth': payMonth,
        'fileId': fileId,
        'insDate': insDate,
        'payDatePrint': payDatePrint,
        'payFormType': payFormType,
        'payType': payType,
        'payTypeName': payTypeName,
        'payMonthPrint': payMonthPrint,
        'isNew': isNew,
        'transType': transType
      };
}
