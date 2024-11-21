class Contract {
  String? contractFileId;
  String? contractFileName;
  String? contractId;
  String? contractName;
  String? digitNonce;

  Contract({
    this.contractFileId,
    this.contractFileName,
    this.contractId,
    this.contractName,
    this.digitNonce,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        contractFileId: json['contractFileId'],
        contractFileName: json['contractFileName'],
        contractId: json['contractId'],
        contractName: json['contractName'],
        digitNonce: json['digitNonce'],
      );

  Map<String, dynamic> toJson() => {
        'contractFileId': contractFileId,
        'contractFileName': contractFileName,
        'contractId': contractId,
        'contractName': contractName,
        'digitNonce': digitNonce,
      };
}
