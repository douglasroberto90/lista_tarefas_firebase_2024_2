import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tarefa.dart';

class Repositorio {

  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<List<Tarefa>> recuperarTudo() async {
    List<Tarefa> tarefas = [];
    await db.collection('tarefas').get().then((colecao){
      for (var documento in colecao.docs){
        tarefas.add(Tarefa(
            nome: documento["nome"].toString(),
            realizado: documento["realizado"],
            id: documento.id));
      }
    });
    return tarefas;
  }

  static Future<Tarefa> adicionarTarefa(Tarefa tarefa) async {
    if (tarefa.id==""){
      String id = await db.collection('tarefas')
          .add(tarefa.toMap()).then((documento) {
            return documento.id;});
      tarefa.id = id;
    }
    else{
      await db.collection('tarefas')
          .doc(tarefa.id).set(tarefa.toMap());
    }
    return tarefa;
  }

  static Future<void> atualizarTarefa(Tarefa tarefa) async {
      await db.collection('tarefas').doc(tarefa.id).set(tarefa.toMap());
    //await db.collection('tarefas').doc(tarefa.id).update({"realizado":tarefa.realizado});
  }

  static Future<void> deletarTarefa(Tarefa tarefa) async {
    await db.collection('tarefas').doc(tarefa.id).delete();
  }
}
