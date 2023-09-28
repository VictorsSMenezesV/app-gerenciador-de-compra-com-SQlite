class ItemLocal {
  int? id;
  dynamic idVendaLocal;
  String? dataEmissao;
  int? idProduto;
  String? descricao;
  dynamic custoUnitario;
  dynamic valorOriginal;
  dynamic valorPraticado;
  int? quantidade = 1;
  dynamic desconto;
  dynamic total;

  ItemLocal(
      {this.id,
      this.idVendaLocal,
      this.dataEmissao,
      this.idProduto,
      this.descricao,
      this.custoUnitario,
      this.valorOriginal,
      this.valorPraticado,
      this.quantidade,
      this.desconto,
      this.total});

  ItemLocal.fromMap(Map<String, dynamic> data) {
    id = data['ID'];
    idVendaLocal = data['ID_VENDA_LOCAL'];
    dataEmissao = data['DATA_EMISSAO'];
    idProduto = data['ID_PRODUTO'];
    descricao = data['DESCRICAO'];
    custoUnitario = data['CUSTO_UNITARIO'];
    valorOriginal = data['VALOR_ORIGINAL'];
    valorPraticado = data['VALOR_PRATICADO'];
    quantidade = data['QUANTIDADE'];
    desconto = data['DESCONTO'];
    total = data['TOTAL'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'ID_VENDA_LOCAL': idVendaLocal,
      'DATA_EMISSAO': dataEmissao,
      'ID_PRODUTO': idProduto,
      'DESCRICAO': descricao,
      'CUSTO_UNITARIO': custoUnitario,
      'VALOR_ORIGINAL': valorOriginal,
      'VALOR_PRATICADO': valorPraticado,
      'QUANTIDADE': quantidade,
      'DESCONTO': desconto,
      'TOTAL': total,
    };
  }
}
