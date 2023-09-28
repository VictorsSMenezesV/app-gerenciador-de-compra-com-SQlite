import 'package:sqflite/sqflite.dart';
import 'package:vendas_ldf_new/database/connection_crud.dart';
import 'package:vendas_ldf_new/entities/cliente_local.dart';

class ClienteLocalDAO {
  Database? _db;

  save2(Cliente cliente) async {
    _db = await Connection.get();
    // ignore: unused_local_variable
    int? sql;
    if (cliente.id == null) {
      sql = await _db?.rawInsert(
          'INSERT INTO cliente_local(ID,TIPO,DOCUMENTO,NOME,LOGRADOURO,NUMERO,BAIRRO,MUNICIPIO,UF,TELEFONE,EMAIL,COMPRADOR) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)',
          [
            cliente.id,
            cliente.tipo,
            cliente.documento,
            cliente.nome,
            cliente.logradouro,
            cliente.numero,
            cliente.bairro,
            cliente.municipio,
            cliente.uf,
            cliente.telefone,
            cliente.email,
            cliente.comprador
          ]);
    } else {
      sql = await _db?.update('cliente_local', cliente.toMap(),
          where: 'ID=?', whereArgs: [cliente.id]);
    }
  }

  int? id;
  int? idClienteLocal;
  String? tipo;
  String? documento;
  String? nome;
  String? logradouro;
  String? numero;
  String? bairro;
  String? municipio;
  String? uf;
  String? telefone;
  String? email;
  String? comprador;

  Future<List<Cliente>> envio(dynamic id) async {
    _db = await Connection.get();
    List<Map<String, Object?>>? alo =
        await _db?.query('cliente_local', where: 'ID =?', whereArgs: [id]);

    List<Cliente> lista = List.generate(alo!.length, (i) {
      var linha = alo[i];
      return Cliente(
        id: linha['ID'] as dynamic,
        idClienteLocal: linha['ID_CLIENTE_LOCAL'] as dynamic,
        tipo: linha['TIPO'] as dynamic,
        documento: linha['DOCUMENTO'] as dynamic,
        nome: linha['NOME'] as dynamic,
        logradouro: linha['LOGRADOURO'] as dynamic,
        numero: linha['NUMERO'] as dynamic,
        bairro: linha['BAIRRO'] as dynamic,
        municipio: linha['MUNICIPIO'] as dynamic,
        uf: linha['UF'] as dynamic,
        telefone: linha['TELEFONE'] as dynamic,
        email: linha['EMAIL'] as dynamic,
        comprador: linha['COMPRADOR'] as dynamic,
      );
    });
    return lista;
  }

  Future<Cliente> update(Cliente cliente) async {
    _db = await Connection.get();
    await _db?.rawUpdate(
        'UPDATE cliente_local SET TIPO=?,DOCUMENTO=?,NOME=?,LOGRADOURO=?,NUMERO=?,BAIRRO=?,MUNICIPIO=?,UF=?,TELEFONE=?,EMAIL=?,COMPRADOR=?',
        [
          cliente.tipo,
          cliente.documento,
          cliente.nome,
          cliente.logradouro,
          cliente.numero,
          cliente.bairro,
          cliente.municipio,
          cliente.uf,
          cliente.telefone,
          cliente.email,
          cliente.comprador
        ]);
    return cliente;
  }

  Future<int?> delete(int idCli) async {
    _db = await Connection.get();
    final result =
        await _db?.rawDelete('DELETE FROM cliente_local WHERE ID = ?', [idCli]);
    return result;
  }

  Future<List<Cliente>> findCli() async {
    _db = await Connection.get();
    List<Map<String, dynamic>>? resultado =
        await _db?.query('cliente_local', orderBy: 'ID DESC');
    List<Cliente> lista = List.generate(resultado!.length, (i) {
      var linha = resultado[i];
      return Cliente(
          id: linha['ID'],
          idClienteLocal: linha['ID_CLIENTE'],
          tipo: linha['TIPO'],
          documento: linha['DOCUMENTO'],
          nome: linha['NOME'],
          logradouro: linha['LOGRADOURO'],
          numero: linha['NUMERO'],
          bairro: linha['BAIRRO'],
          municipio: linha['MUNICIPIO'],
          uf: linha['UF'],
          telefone: linha['TELEFONE'],
          email: linha['EMAIL'],
          comprador: linha['COMPRADOR']);
    });
    return lista;
  }

  Future<int?> deleteData(int id) async {
    _db = await Connection.get();
    return await _db?.delete('cliente_local', where: 'ID =?', whereArgs: [id]);
  }

  Future<int?> updateData(table, Cliente data) async {
    _db = await Connection.get();
    var result = await _db?.update('cliente_local', data.toMap(),
        where: 'ID=?', whereArgs: [data.id]);
    return result;
  }
}
