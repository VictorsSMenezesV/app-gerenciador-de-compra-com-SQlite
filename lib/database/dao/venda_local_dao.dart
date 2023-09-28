import 'package:sqflite/sqflite.dart';
import 'package:vendas_ldf_new/database/connection_crud.dart';
import 'package:vendas_ldf_new/database/script.dart';
import 'package:vendas_ldf_new/entities/venda_local.dart';
import 'package:vendas_ldf_new/entities/cliente_local.dart';

class VendasLocalDAO {
  Database? _db;

  Future<List<Cliente>?> query() async {
    _db = await Connection.get();
    _db?.execute(createTable4);
    _db?.execute(insertItemLocal);
    //_db?.execute('DELETE * FROM TABLE item_local');
    //_db?.delete('item_local');
    //_db?.rawDelete('DROP TABLE item_local');
    //_db?.delete('venda_local');

    return null;
  }

  int? id;
  int? idCliLocal;
  String? comprador;
  String? telefone;
  String? email;
  int? idCondPag;
  dynamic itens;
  dynamic valorCusto;
  dynamic valorOri;
  dynamic valorFinal;
  String? dataEmissao;
  String? obsCliente;
  String? obsLogistica;
  String? obsFaturamento;
  String? status;

  Future<int> update(table, VendaLocal data) async {
    return await _db!.update('venda_local', data.toMap(),
        where: 'ID = ?', whereArgs: [data.id]);
  }

  insertRemaining(VendaLocal vendaLocal) async {
    _db = await Connection.get();
    String sql;
    sql =
        'UPDATE venda_local SET ITENS=?,VALOR_CUSTO=?,VALOR_ORIGINAL=?,VALOR_FINAL=?,DATA_EMISSAO=?,STATUS=? WHERE ID=?';

    _db?.rawUpdate(sql, [
      vendaLocal.itens,
      vendaLocal.valorCusto,
      vendaLocal.valorOriginal,
      vendaLocal.valorFinal,
      vendaLocal.dataEmissao,
      vendaLocal.status,
      vendaLocal.id
    ]);
  }

  insertRemaining2(VendaLocal vendaLocal) async {
    _db = await Connection.get();
    String sql;
    sql = 'UPDATE venda_local SET STATUS=? WHERE ID=?';

    _db?.rawUpdate(sql, [vendaLocal.status, vendaLocal.id]);
  }

  inserRemainig3(VendaLocal vendaLocal) async {
    _db = await Connection.get();
    String sql;
    sql =
        'UPDATE venda_local SET OBS_CLIENTE=?,OBS_LOGISTICA=?,OBS_FATURAMENTO=? WHERE ID=?';

    _db?.rawUpdate(sql, [
      vendaLocal.obsCliente,
      vendaLocal.obsLogistica,
      vendaLocal.obsFaturamento,
      vendaLocal.id
    ]);
  }

  Future<int?> deleteData(int id) async {
    _db = await Connection.get();
    return await _db?.delete('venda_local', where: 'ID =?', whereArgs: [id]);
  }

  Future<List<VendaLocal>> find() async {
    _db = await Connection.get();
    List<Map<String, dynamic>>? resultado =
        await _db?.query('venda_local', orderBy: 'ID DESC');
    List<VendaLocal> lista = List.generate(resultado!.length, (i) {
      var linha = resultado[i];
      return VendaLocal(
          id: linha['ID'],
          idClienteLocal: linha['ID_CLIENTE_LOCAL'],
          comprador: linha['COMPRADOR'],
          telefone: linha['TELEFONE'],
          email: linha['EMAIL'],
          idCondicaoPagamento: linha['ID_CONDICAO_PAGAMENTO'],
          itens: linha['ITENS'],
          valorCusto: linha['VALOR_CUSTO'],
          valorOriginal: linha['VALOR_ORIGINAL'],
          valorFinal: linha['VALOR_FINAL'],
          dataEmissao: linha['DATA_EMISSAO'],
          obsCliente: linha['OBS_CLIENTE'],
          obsLogistica: linha['OBS_LOGISTICA'],
          obsFaturamento: linha['OBS_FATURAMENTO'],
          status: linha['STATUS']);
    });
    return lista;
  }

  Future<int> insert(VendaLocal vendaLocal) async {
    _db = await Connection.get();

    dynamic id = await _db?.rawInsert(
        'INSERT INTO venda_local(ID_CLIENTE_LOCAL,COMPRADOR,TELEFONE,EMAIL,ID_CONDICAO_PAGAMENTO,ITENS,VALOR_CUSTO,VALOR_ORIGINAL,VALOR_FINAL,DATA_EMISSAO,OBS_CLIENTE,OBS_LOGISTICA,OBS_FATURAMENTO,STATUS) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
        [
          vendaLocal.idClienteLocal,
          vendaLocal.comprador,
          vendaLocal.telefone,
          vendaLocal.email,
          vendaLocal.idCondicaoPagamento,
          vendaLocal.itens,
          vendaLocal.valorCusto,
          vendaLocal.valorOriginal,
          vendaLocal.valorFinal,
          vendaLocal.dataEmissao,
          vendaLocal.obsCliente,
          vendaLocal.obsLogistica,
          vendaLocal.obsFaturamento,
          vendaLocal.status
        ]);
    return id;
  }
}
