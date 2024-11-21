class CompanyData {
  String? bizId;
  String? bizName;
  String? businessNo;
  String? ownerName;
  bool? isSelected;

  CompanyData({
    this.bizId,
    this.bizName,
    this.businessNo,
    this.ownerName,
    this.isSelected = false,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
        bizId: json['bizId'],
        bizName: json['bizName'],
        businessNo: json['businessNo'],
        ownerName: json['ownerName'],
      );

  Map<String, dynamic> toJson() => {
        'bizId': bizId,
        'bizName': bizName,
        'businessNo': businessNo,
        'ownerName': ownerName,
      };
}
