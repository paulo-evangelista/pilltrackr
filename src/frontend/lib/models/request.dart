import 'package:flutter/foundation.dart';

class Request {
  final String id;
  final String productCode;
  final bool isUrgent;
  final String description;
  final String status;
  

  Request({
    required this.id,
    required this.productCode,
    required this.isUrgent,
    required this.description,
    required this.status,
  });

  // Método para converter um JSON em uma instância de Request
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'] as String,
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


