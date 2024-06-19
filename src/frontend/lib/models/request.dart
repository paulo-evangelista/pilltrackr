import 'package:flutter/foundation.dart';

class Request {
  final int id;
  final String productName;
  final String productCode;
  final bool isUrgent;
  final String description;
  final String status;
  

  Request({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.isUrgent,
    required this.description,
    required this.status,
  });

  // // Método para converter um JSON em uma instância de Request
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['ID'] as int,
      productName: json['Name'] as String,
      productCode: json['productCode'] as String,
      isUrgent: json['isUrgent'] as bool,
      description: json['description'] as String,
      status: json['status'] as String,
    );
  }

  // Método para converter uma instância de Request em um JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productCode': productCode,
      'isUrgent': isUrgent,
      'description': description,
      'status': status,
    };
  }
}
