class NetworkResponse<T> {
  T? data;
  int? code;
  bool? success;
  String? message;
  NetworkResponse({required this.success, required this.code, required this.data, required this.message});

  factory NetworkResponse.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) {
    return NetworkResponse<T>(
      code: json["code"],
      message: json["message"],
      success: json["success"],
      data: json["data"] == null ? null : fromJsonT(json["data"]),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T? data) toJsonT) => {
        "code": code,
        "message": message,
        "success": success,
        "data": toJsonT(data),
      };
}
