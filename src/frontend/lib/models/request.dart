class Request {
  final String id;
  final String title;
  final String status;

  final String medicamento;
  final bool imediato;
  final String descricao;
  
  Request({
   required this.id,
   required this.medicamento,
   required this.imediato,
   required this.descricao,
  });
  
  //Rever integração da request-fc para compreender o uso do codigo abaixo
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
    };
  }
}


