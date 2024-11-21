import 'package:candy/src/model/contract.dart';

class ContractDataList {
  List<Contract>? items;
  bool? success;

  ContractDataList({this.success, this.items});

  factory ContractDataList.fromJson(Map<String, dynamic> json) =>
      ContractDataList(
          success: json['success'],
          items: json['data'] == null
              ? null
              : List<Contract>.from(
                  json['data'].map((data) => Contract.fromJson(data))));
}
