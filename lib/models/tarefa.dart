class Tarefa{

  Tarefa({this.id="", required this.nome, required this.realizado});

  String id;
  String nome;
  bool realizado;

  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "nome": nome,
      "realizado": realizado
    };
  }
}