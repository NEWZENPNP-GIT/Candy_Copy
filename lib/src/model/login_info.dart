class LoginInfo {
  String? bizId;
  String? userId;
  String? loginId;
  String? bizName;
  String? userName;
  String? isPaystubPassword;
  bool? success;
  String? message;
  String? phoneNum;

  LoginInfo({
    this.bizId,
    this.userId,
    this.loginId,
    this.bizName,
    this.userName,
    this.phoneNum,
    this.isPaystubPassword,
    this.success,
    this.message,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) => LoginInfo(
        bizId: json['bizId'],
        userId: json['userId'],
        loginId: json['loginId'],
        bizName: json['bizName'],
        userName: json['userName'],
        isPaystubPassword: json['isPaystubPassword'],
        success: json['success'],
        message: json['message'],
        phoneNum: json['phoneNum'],
      );

  Map<String, dynamic> toJson() => {
        'bizId': bizId,
        'userId': userId,
        'loginId': loginId,
        'bizName': bizName,
        'userName': userName,
        'isPaystubPassword': isPaystubPassword,
        'success': success,
        'message': message,
        'phoneNum': phoneNum,
      };
}
