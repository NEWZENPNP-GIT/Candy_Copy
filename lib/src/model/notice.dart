class Notice {
  String? bbsId;
  String? bbsNo;
  String? contents;
  String? insDate;
  String? subject;
  Notice({this.bbsId, this.bbsNo, this.contents, this.insDate, this.subject});

  Notice.fromJson(Map<String, dynamic> json) {
    bbsId = json['bbsId'];
    bbsNo = json['bbsNo'];
    contents = json['contents'];
    insDate = json['insDate'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bbsId'] = bbsId;
    data['bbsNo'] = bbsNo;
    data['contents'] = contents;
    data['insDate'] = insDate;
    data['subject'] = subject;
    return data;
  }
}
