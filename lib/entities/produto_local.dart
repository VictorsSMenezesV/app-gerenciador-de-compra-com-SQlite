class Produto {
  int? id;
  String? descricao;
  dynamic custo;
  dynamic valor;
  dynamic valorMinimo;
  dynamic quantidadeAtual;

  Produto(
      {this.id,
      this.descricao,
      this.custo,
      this.valor,
      this.valorMinimo,
      this.quantidadeAtual});

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'DESCRICAO': descricao,
      'CUSTO': custo,
      'VALOR': valor,
      'VALOR_MINIMO': valorMinimo,
      'QUANTIDADE_ATUAL': quantidadeAtual
    };
  }

  Produto.fromMap(Map<String, dynamic> data) {
    id = data['ID'];
    descricao = data['DESCRICAO'];
    custo = data['CUSTO'];
    valor = data['VALOR'];
    valorMinimo = data['VALOR_MINIMO'];
    quantidadeAtual = data['QUANTIDADE_ATUAL'];
  }

  @override
  String toString() {
    return 'Produto{ID: $id, DESCRICAO: $descricao, CUSTO:$custo, VALOR: $valor, VALOR_MINIMO: $valorMinimo, QUANTIDADE_ATUAL: $quantidadeAtual}';
  }

  Produto.e(dynamic obj) {
    id = obj['ID'];
    descricao = obj['DESCRICAO'];
    custo = obj['CUSTO'];
    valor = obj['VALOR'];
    valorMinimo = obj['VALOR_MINIMO'];
    quantidadeAtual = obj['QUANTIDADE_ATUAL'];
  }
}
