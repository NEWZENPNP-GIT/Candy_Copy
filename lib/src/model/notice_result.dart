import 'package:candy/src/model/notice.dart';

class NoticeResult {
  bool? success;
  int? total;
  List<Notice>? dataList;

  NoticeResult({this.success, this.total, this.dataList});

  NoticeResult.fromJson(Map<String, dynamic> json) {
    dataList = [];
    success = json['success'];
    total = json['total'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        dataList!.add(Notice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['total'] = total;
    if (dataList != null) {
      data['data'] = dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
