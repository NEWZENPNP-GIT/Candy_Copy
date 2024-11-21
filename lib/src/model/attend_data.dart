class AttendData {
  String? bizId;
  String? userId;
  String? workDate;
  String? attendId;
  String? attendCode;
  String? dateFrom;
  String? dateTo;
  String? placeId;
  String? signType;
  String? closeType;
  String? insDate;
  String? updDate;
  double? distance;
  double? latitude;
  double? longitude;
  String? attendIds;
  String? empNo;
  String? empName;
  String? deptName;
  String? positionName;
  String? placeName;
  String? placeAddr;
  int? workMinute;
  String? workMonth;

  AttendData({
    this.bizId,
    this.userId,
    this.workDate,
    this.attendId,
    this.attendCode,
    this.dateFrom,
    this.dateTo,
    this.placeId,
    this.signType,
    this.closeType,
    this.insDate,
    this.updDate,
    this.distance,
    this.latitude,
    this.longitude,
    this.attendIds,
    this.empNo,
    this.empName,
    this.deptName,
    this.positionName,
    this.placeName,
    this.placeAddr,
    this.workMinute,
    this.workMonth,
  });

  factory AttendData.fromJson(Map<String, dynamic> json) => AttendData(
        bizId: json['bizId'],
        userId: json['userId'],
        workDate: json['workDate'],
        attendId: json['attendId'],
        attendCode: json['attendCode'],
        dateFrom: json['dateFrom'],
        dateTo: json['dateTo'],
        placeId: json['placeId'],
        signType: json['signType'],
        closeType: json['closeType'],
        insDate: json['insDate'],
        updDate: json['updDate'],
        distance: json['distance'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        attendIds: json['attendIds'],
        empNo: json['empNo'],
        empName: json['empName'],
        deptName: json['deptName'],
        positionName: json['positionName'],
        placeName: json['placeName'],
        placeAddr: json['placeAddr'],
        workMinute: json['workMinute'],
        workMonth: json['workMonth'],
      );

  Map<String, dynamic> toJson() => {
        'bizId': bizId,
        'userId': userId,
        'workDate': workDate,
        'attendId': attendId,
        'attendCode': attendCode,
        'dateFrom': dateFrom,
        'dateTo': dateTo,
        'placeId': placeId,
        'signType': signType,
        'closeType': closeType,
        'insDate': insDate,
        'updDate': updDate,
        'distance': distance,
        'latitude': latitude,
        'longitude': longitude,
        'attendIds': attendIds,
        'empNo': empNo,
        'empName': empName,
        'deptName': deptName,
        'positionName': positionName,
        'placeName': placeName,
        'placeAddr': placeAddr,
        'workMinute': workMinute,
        'workMonth': workMonth,
      };
}
