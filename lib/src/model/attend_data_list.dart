import 'package:candy/src/model/attend_data.dart';

class AttendDataList {
  List<AttendData>? attends;
  bool? success;
  int? total;

  AttendDataList({
    this.success,
    this.attends,
    this.total,
  });

  factory AttendDataList.fromJson(Map<String, dynamic> json) => AttendDataList(
      success: json['success'],
      total: json['total'],
      attends: json['attends'] == null
          ? null
          : List<AttendData>.from(
              json['attends'].map((data) => AttendData.fromJson(data))));
}
