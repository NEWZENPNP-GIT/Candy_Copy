import 'package:candy/src/model/company_data.dart';

class CompanyDataList {
  List<CompanyData>? data;
  bool? success;
  int? total;

  CompanyDataList({
    this.success,
    this.data,
    this.total,
  });

  factory CompanyDataList.fromJson(Map<String, dynamic> json) =>
      CompanyDataList(
          success: json['success'],
          total: json['total'],
          data: json['data'] == null
              ? null
              : List<CompanyData>.from(
                  json['data'].map((data) => CompanyData.fromJson(data))));
}
