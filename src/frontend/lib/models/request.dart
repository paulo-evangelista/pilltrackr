class Request {
  final String id;
  final String title;
  final String status;

  Request({required this.id, required this.title, required this.status});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
    };
  }
}
