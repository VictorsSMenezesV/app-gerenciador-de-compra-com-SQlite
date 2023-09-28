import 'package:sqflite/sqflite.dart';
import 'package:vendas_ldf_new/database/connection_crud.dart';
import 'package:vendas_ldf_new/entities/item_local.dart';

class ItemLocalDAO {
  Database? _db;

  Future<ItemLocal> insert(ItemLocal itemLocal) async {
    _db = await Connection.get();
    await _db!.insert('item_local', itemLocal.toMap());
    return itemLocal;
  }

  Future<List<ItemLocal>> getItem() async {
    _db = await Connection.get();
    List<Map<String, Object?>> res = await _db!.query('item_local');
    return res.map((e) => ItemLocal.fromMap(e)).toList();
  }

  Future<List<ItemLocal>> card(dynamic id) async {
    _db = await Connection.get();
    List<Map<String, Object?>>? alo = await _db
        ?.query('item_local', where: 'ID_VENDA_LOCAL =?', whereArgs: [id]);

    List<ItemLocal> lista = List.generate(alo!.length, (i) {
      var linha = alo[i];
      return ItemLocal(
          id: linha['ID'] as dynamic,
          idVendaLocal: linha['ID_VENDA_LOCAL'],
          dataEmissao: linha['DATA_EMISSAO'] as dynamic,
          idProduto: linha['ID_PRODUTO'] as dynamic,
          descricao: linha['DESCRICAO'] as dynamic,
          custoUnitario: linha['CUSTO_UNITARIO'],
          valorOriginal: linha['VALOR_ORIGINAL'],
          valorPraticado: linha['VALOR_PRATICADO'],
          quantidade: linha['QUANTIDADE'] ?? 1 as dynamic,
          desconto: linha['DESCONTO'],
          total: linha['TOTAL']);
    });
    return lista;
  }

  Future<int?> deleteData(int id) async {
    _db = await Connection.get();
    return await _db?.delete('item_local', where: 'ID =?', whereArgs: [id]);
  }

  Future<int?> updateData(table, ItemLocal data) async {
    _db = await Connection.get();
    var result = await _db?.update('item_local', data.toMap(),
        where: 'ID=?', whereArgs: [data.id]);
    return result;
  }
}
