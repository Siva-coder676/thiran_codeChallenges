class TransactionData {
  int transId;
  String transDesc;
  String transStatus;
  String transDateTime;

  TransactionData({
    required this.transId,
    required this.transDesc,
    required this.transStatus,
    required this.transDateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'transId': transId,
      'transDesc': transDesc,
      'transStatus': transStatus,
      'transDateTime': transDateTime,
    };
  }
}
