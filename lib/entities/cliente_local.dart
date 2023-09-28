class Cliente {
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

  Cliente(
      {this.id,
      this.idClienteLocal,
      this.tipo,
      this.documento,
      this.nome,
      this.logradouro,
      this.numero,
      this.bairro,
      this.municipio,
      this.uf,
      this.telefone,
      this.email,
      this.comprador});

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'ID_CLIENTE': idClienteLocal,
      'TIPO': tipo,
      'DOCUMENTO': documento,
      'NOME': nome,
      'LOGRADOURO': logradouro,
      'NUMERO': numero,
      'BAIRRO': bairro,
      'MUNICIPIO': municipio,
      'UF': uf,
      'TELEFONE': telefone,
      'EMAIL': email,
      'COMPRADOR': comprador
    };
  }

  Cliente.fromMap(Map<String, dynamic> data) {
    id = data['ID'];
    idClienteLocal = data['ID_CLIENTE'];
    tipo = data['TIPO'];
    documento = data['DOCUMENTO'];
    nome = data['NOME'];
    logradouro = data['LOGRADOURO'];
    numero = data['NUMERO'];
    bairro = data['BAIRRO'];
    municipio = data['MUNICIPIO'];
    uf = data['UF'];
    telefone = data['TELEFONE'];
    email = data['EMAIL'];
    comprador = data['COMPRADOR'];
  }

  Cliente copy(
          {int? id,
          int? idClienteLocal,
          String? tipo,
          String? documento,
          String? nome,
          String? logradouro,
          String? numero,
          String? bairro,
          String? municipio,
          String? uf,
          String? telefone,
          String? email,
          String? comprador}) =>
      Cliente(
          id: id ?? this.id,
          idClienteLocal: idClienteLocal ?? this.idClienteLocal,
          tipo: tipo ?? this.tipo,
          documento: documento ?? this.documento,
          nome: nome ?? this.nome,
          logradouro: logradouro ?? this.nome,
          numero: numero ?? this.numero,
          bairro: bairro ?? this.bairro,
          municipio: municipio ?? this.municipio,
          uf: uf ?? this.uf,
          telefone: telefone ?? this.telefone,
          email: email ?? this.email,
          comprador: comprador ?? this.comprador);
}
