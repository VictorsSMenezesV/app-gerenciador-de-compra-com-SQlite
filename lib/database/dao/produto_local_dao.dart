import 'package:sqflite/sqflite.dart';
import 'package:vendas_ldf_new/entities/produto_local.dart';

import '../connection_crud.dart';

class ProdutoLocalDAO {
  Database? _db;

  Future<List<Produto>> find() async {
    _db = await Connection.get();
    List<Map<String, dynamic>>? resultado = await _db?.query('produto_local');
    List<Produto> lista = List.generate(resultado!.length, (i) {
      var linha = resultado[i];
      return Produto(
          id: linha['ID'] as dynamic,
          descricao: linha['DESCRICAO'],
          custo: linha['CUSTO'],
          valor: linha['VALOR'],
          valorMinimo: linha['VALOR_MINIMO'],
          quantidadeAtual: linha['QUANTIDADE_ATUAL']);
    });
    return lista;
  }

  remove(int? id) async {
    _db = await Connection.get();
    var sql = 'DELETE FROM produto_local WHERE ID=?';
    _db?.rawDelete(sql, [id]);
  }

  save(Produto produto) async {
    _db = await Connection.get();
    String sql;
    sql =
        'INSERT INTO produto_local(ID,DESCRICAO,CUSTO,VALOR,VALOR_MINIMO,QUANTIDADE_ATUAL)VALUES(?,?,?,?,?,?)';
    _db?.rawInsert(sql, [
      produto.id,
      produto.descricao,
      produto.custo,
      produto.valor,
      produto.valorMinimo,
      produto.quantidadeAtual
    ]);
  }

  removeall() async {
    _db = await Connection.get();
    return _db?.delete('produto_local');
  }

  Future<List?> todosProdutos() async {
    _db = await Connection.get();
    return _db?.query('produto_local');
  }
}
