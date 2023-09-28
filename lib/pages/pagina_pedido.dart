// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vendas_ldf_new/database/dao/cliente_local_dao.dart';
import 'package:vendas_ldf_new/database/dao/venda_local_dao.dart';
import 'package:vendas_ldf_new/entities/cliente_local.dart';
import 'package:vendas_ldf_new/entities/venda_local.dart';
import 'package:vendas_ldf_new/pages/envio_dados.dart';
import 'package:vendas_ldf_new/pages/pagina_carrinho.dart';
import 'package:vendas_ldf_new/pages/perfil_pedido.dart';

import '../database/dao/item_local_dao.dart';
import '../entities/item_local.dart';

class PedidoPage extends StatefulWidget {
  final List<dynamic>? itens;
  const PedidoPage({
    Key? key,
    required this.itens,
  }) : super(key: key);

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  Future<List<VendaLocal>> _buscar() async {
    return VendasLocalDAO().find();
  }

  bye(int id) async {
    return VendasLocalDAO().deleteData(id);
  }

  Future<bool> saved() async {
    return false;
  }

  Future<List<ItemLocal>> buscar2(dynamic id) async {
    return ItemLocalDAO().card(id);
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Sair do Aplicativo'),
            content: const Text('Voçê deseja sair do aplicativo?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return false when click on "NO"
                child: const Text('Sim'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return true when click on "Yes"
                child: const Text('Não'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  Future<List<Cliente>> buscar(dynamic id) async {
    return ClienteLocalDAO().envio(id);
  }

  final formKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  final FileController = TextEditingController();
  Cliente alo = Cliente();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _buscar(),
        builder: (context, futuro) {
          if (futuro.hasData) {
            List<VendaLocal> list = futuro.data as dynamic;
            return WillPopScope(
              onWillPop: showExitPopup,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Lista de Pedidos'),
                ),
                body: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      dynamic venda = list[i];
                      return Slidable(
                        key: ValueKey(i),
                        startActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                              icon: Icons.local_grocery_store_rounded,
                              backgroundColor: Colors.blue,
                              label: 'Incluir\n Itens',
                              onPressed: (context) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => CardPage(
                                          item: venda,
                                        )));
                              }),
                          SlidableAction(
                              icon: Icons.share,
                              backgroundColor: Colors.orange,
                              label: 'Enviar\nDados',
                              onPressed: (context) async {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text('Envio de Dados'),
                                          content: Form(
                                            key: formKey,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'O nome do cliente/empresa \nnão foi inserido!!';
                                                }
                                                return null;
                                              },
                                              controller: FileController,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'Insira o nome do cliente aqui'),
                                            ),
                                          ),
                                          actions: [
                                            FlatButton(
                                                child: const Text('Prosseguir'),
                                                onPressed: () {
                                                  setState(() {
                                                    if (formKey.currentState
                                                            ?.validate() ==
                                                        true) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  EncaminharDados(
                                                                      venda:
                                                                          venda,
                                                                      nome: FileController
                                                                          .text)));
                                                    }
                                                  });
                                                }),
                                            FlatButton(
                                              child: const Text('Cancelar'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ));
                              }),
                        ]),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                                icon: Icons.article_outlined,
                                backgroundColor: Colors.green,
                                label: 'Informações',
                                onPressed: (context) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PerfilPedido(venda: venda)));
                                }),
                            SlidableAction(
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                label: 'Excluir',
                                onPressed: (context) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                                'Exclução do Pedido'),
                                            content: const Text(
                                                'Deseja excluir o pedido?'),
                                            actions: [
                                              FlatButton(
                                                  child: const Text('Sim'),
                                                  onPressed: () {
                                                    setState(() {
                                                      bye(venda.id);
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
                          leading: Text(venda.id.toString()),
                          title: Text(venda.comprador.toString()),
                          subtitle: Text(
                              r'R$: ' + venda.valorFinal.toStringAsFixed(2)),
                          trailing: Column(
                            children: [
                              Text(venda.status.toString()),
                              Text(venda.dataEmissao.toString()),
                            ],
                          ),
                          isThreeLine: true,
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
