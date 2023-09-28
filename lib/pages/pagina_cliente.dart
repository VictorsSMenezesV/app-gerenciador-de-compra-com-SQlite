// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vendas_ldf_new/database/dao/cliente_local_dao.dart';
import 'package:vendas_ldf_new/database/dao/venda_local_dao.dart';
import 'package:vendas_ldf_new/entities/cliente_local.dart';

import 'package:vendas_ldf_new/entities/venda_local.dart';
import 'package:vendas_ldf_new/main.dart';
import 'package:vendas_ldf_new/pages/cadastro_cliente.dart';
import 'package:vendas_ldf_new/pages/perfil_cliente.dart';
import 'package:vendas_ldf_new/pages/edicao_cliente.dart';

class ClientePage extends StatefulWidget {
  final Cliente? clie;
  final VendaLocal? veenda;

  const ClientePage({Key? key, this.clie, this.veenda}) : super(key: key);

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
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

  VendaLocal vend = VendaLocal();

  Cliente? helper;
  Future<List<Cliente>> _buscar2() async {
    return ClienteLocalDAO().findCli();
  }

  bye(int id) async {
    return ClienteLocalDAO().deleteData(id);
  }

  elo(id, Cliente cliente) async {
    return ClienteLocalDAO().updateData(id, cliente);
  }

  Future<List<Cliente?>?> nova() async {
    return VendasLocalDAO().query();
  }

  Future<bool> saved() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _buscar2(),
        builder: (context, futuro) {
          if (futuro.hasData) {
            List<Cliente> list = futuro.data as dynamic;
            return WillPopScope(
              onWillPop: saved,
              child: Scaffold(
                floatingActionButton: FloatingActionButton.large(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const CadastroPage()));
                    }),
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Lista de Clientes'),
                ),
                body: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      dynamic cliente = list[i];
                      return Slidable(
                        key: ValueKey(i),
                        startActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                              icon: Icons.account_circle,
                              backgroundColor: Colors.green,
                              label: 'Perfil',
                              onPressed: (context) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                          veenda: vend,
                                          cliente: cliente,
                                        )));
                              }),
                          SlidableAction(
                              backgroundColor: Colors.orange,
                              label: 'Iniciar\nPedido',
                              onPressed: (context) {
                                incluir() async {
                                  var res = VendasLocalDAO().insert(VendaLocal(
                                      idClienteLocal: cliente.id,
                                      comprador: cliente.comprador,
                                      telefone: cliente.telefone,
                                      email: cliente.email,
                                      idCondicaoPagamento: null,
                                      itens: null,
                                      valorCusto: null,
                                      valorOriginal: null,
                                      valorFinal: 0.00,
                                      dataEmissao: null,
                                      obsCliente: null,
                                      obsLogistica: null,
                                      obsFaturamento: null));
                                  return res;
                                }

                                incluir();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TableLayout(
                                          itens: cliente,
                                        )));
                              })
                        ]),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                                icon: Icons.edit,
                                backgroundColor: Colors.blue,
                                label: 'Editar',
                                onPressed: (context) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditPage(cliente: cliente)));
                                }),
                            SlidableAction(
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                label: 'Excluir',
                                onPressed: (context) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title:
                                                const Text('Excluir Cliente'),
                                            content: const Text(
                                                'Deseja excluir o cliente?'),
                                            actions: [
                                              FlatButton(
                                                  child: const Text('Sim'),
                                                  onPressed: () {
                                                    setState(() {
                                                      bye(cliente.id);
                                                    });
                                                    Navigator.of(context).pop();
                                                  }),
                                              FlatButton(
                                                child: const Text('Não'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ));
                                }),
                          ],
                        ),
                        child: ListTile(
                          title: Text(cliente.nome.toString()),
                          subtitle: Text(cliente.telefone.toString()),
                          onTap: () {},
                        ),
                      );
                    }),
              ),
            );
          } else {
            return const Scaffold();
          }
        });
  }
}
