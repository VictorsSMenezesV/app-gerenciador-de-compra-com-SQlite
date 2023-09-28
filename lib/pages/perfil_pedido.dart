// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vendas_ldf_new/database/dao/item_local_dao.dart';
import 'package:vendas_ldf_new/database/dao/venda_local_dao.dart';
import 'package:vendas_ldf_new/entities/item_local.dart';
import 'package:vendas_ldf_new/entities/venda_local.dart';
import 'package:vendas_ldf_new/main.dart';

// ignore: must_be_immutable
class PerfilPedido extends StatefulWidget {
  VendaLocal venda;

  PerfilPedido({Key? key, required this.venda}) : super(key: key);

  @override
  State<PerfilPedido> createState() => _PerfilPedidoState();
}

class _PerfilPedidoState extends State<PerfilPedido> {
  Future<List<ItemLocal>> buscar(dynamic id) async {
    return ItemLocalDAO().card(id);
  }

  bye(int id) async {
    return ItemLocalDAO().deleteData(id);
  }

  var userService = ItemLocalDAO();
  var userService2 = VendasLocalDAO();

  @override
  void initState() {
    status2 = widget.venda.status;
    super.initState();
  }

  List<String> status = ['ORCAMENTO', 'ENVIADO'];
  dynamic status2;

  dynamic valor;
  dynamic total;
  dynamic total2;
  dynamic total3;
  String aqui = '';

  @override
  Widget build(BuildContext context) {
    setState(() {
      valor = widget.venda.id;
    });
    return FutureBuilder(
        future: buscar(valor),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ItemLocal> lista = snapshot.data as dynamic;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const TableLayout()));
                      },
                      icon: const Icon(Icons.check))
                ],
                title: const Text('Informações da Compra'),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: lista.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lista[index].descricao.toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          r'R$:' +
                                              lista[index]
                                                  .valorOriginal
                                                  .toString(),
                                          style: const TextStyle(fontSize: 13)),
                                      Text(
                                          'Quantidade: ' +
                                              lista[index]
                                                  .quantidade
                                                  .toString(),
                                          style: const TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.blueGrey[200],
                    child: Column(children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                              'Codigo da venda: ' + widget.venda.id.toString()),
                          Text(
                              'Comprador: ' + widget.venda.comprador.toString())
                        ],
                      ),
                      Container(
                        height: 1,
                        width: 355,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Email: ' + widget.venda.email.toString()),
                          Text('Fone: ' + widget.venda.telefone.toString())
                        ],
                      ),
                      Container(
                        height: 1,
                        width: 355,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 5),
                      const Text('OBS Cliente:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: Text(widget.venda.obsCliente.toString())),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: 355,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 5),
                      const Text('OBS Faturamento:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child:
                                  Text(widget.venda.obsFaturamento.toString())),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: 355,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 5),
                      const Text('OBS Logistica:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child:
                                  Text(widget.venda.obsLogistica.toString())),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: 355,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Itens: ' + widget.venda.itens.toString()),
                          Text(
                              'Emissão: ' + widget.venda.dataEmissao.toString())
                        ],
                      ),
                      Container(
                        height: 1,
                        width: 355,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(r'Valor Custo/R$: ' +
                              widget.venda.valorCusto.toString() as dynamic),
                          Text(r'Valor Final/R$: ' +
                              widget.venda.valorOriginal.toString())
                        ],
                      ),
                      Container(
                        height: 1,
                        width: 355,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Status: ' + widget.venda.status.toString())
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ]),
                  )
                ],
              ),
            );
          } else {
            return const Scaffold();
          }
        });
  }
}
