import 'package:candy/src/model/payment.dart';

class PaymentDataList {
  List<Payment>? items;
  int? total;
  bool? success;

  PaymentDataList({
    this.success,
    this.items,
    this.total,
  });

  factory PaymentDataList.fromJson(Map<String, dynamic> json) =>
      PaymentDataList(
          success: json['success'],
          total: json['total'],
          items: json['data'] == null
              ? null
              : List<Payment>.from(
                  json['data'].map((data) => Payment.fromJson(data))));
}
