// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:vendas_ldf_new/database/dao/item_local_dao.dart';
import 'package:vendas_ldf_new/database/dao/venda_local_dao.dart';
import 'package:vendas_ldf_new/entities/venda_local.dart';
import 'package:vendas_ldf_new/main.dart';
import 'package:vendas_ldf_new/pages/obs_page.dart';
import 'package:vendas_ldf_new/pages/pagina_compra.dart';
import '../entities/item_local.dart';

// ignore: must_be_immutable
class CardPage extends StatefulWidget {
  VendaLocal item;
  CardPage({Key? key, required this.item}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  Future<List<ItemLocal>> buscar(dynamic id) async {
    return ItemLocalDAO().card(id);
  }

  bye(int id) async {
    return ItemLocalDAO().deleteData(id);
  }

  var userService = ItemLocalDAO();
  var userService2 = VendasLocalDAO();

  List<String> status = ['ORCAMENTO', 'ENVIADO'];
  dynamic status2;

  @override
  void initState() {
    status2 = widget.item.status;
    super.initState();
  }

  Future<bool> saved() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    dynamic valor;
    dynamic total;
    dynamic total2;
    dynamic total3;

    setState(() {
      valor = widget.item.id;
    });
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Sair do Aplicativo'),
              content: const Text('Voçê deseja sair do aplicativo?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Sim'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Não'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return FutureBuilder(
        future: buscar(valor),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ItemLocal> lista = snapshot.data as dynamic;

            return WillPopScope(
              onWillPop: showExitPopup,
              child: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => VendasPage(
                                teste: widget.item,
                              )));
                    }),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            userService2.insertRemaining(VendaLocal(
                                itens: int.parse(total.toString()),
                                valorCusto: total3,
                                valorOriginal: total2,
                                valorFinal: total2,
                                dataEmissao:
                                    DateTime.now().toString().substring(0, 10),
                                status: 'ORÇAMENTO',
                                id: widget.item.id));
                          });
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Observação'),
                                    content: const Text(
                                        'Deseja adicionar alguma Observação?'),
                                    actions: [
                                      FlatButton(
                                          child: const Text('Sim'),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ObsPage(
                                                              valor: widget
                                                                  .item)));
                                            });
                                          }),
                                      FlatButton(
                                        child: const Text('Não'),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          const TableLayout()));
                                        },
                                      ),
                                    ],
                                  ));
                        },
                        icon: const Icon(Icons.check))
                  ],
                  title: const Text('Carrinho'),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: lista.length,
                        itemBuilder: (context, index) {
                          dynamic va = lista[index];
                          return Card(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      va.descricao.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                        r'R$:' +
                                            lista[index]
                                                .valorOriginal
                                                .toString(),
                                        style: const TextStyle(fontSize: 16)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        'Quantidade: ' +
                                            lista[index].quantidade.toString(),
                                        style: const TextStyle(fontSize: 16)),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: ElegantNumberButton(
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                                initialValue:
                                                    lista[index].quantidade ??
                                                        1,
                                                minValue: 1,
                                                maxValue: 1000,
                                                buttonSizeHeight: 50,
                                                buttonSizeWidth: 50,
                                                color: const Color.fromARGB(
                                                    159, 209, 206, 206),
                                                decimalPlaces: 0,
                                                onChanged: (value) async {
                                                  setState(() {
                                                    lista[index].quantidade =
                                                        value as dynamic;
                                                    userService.updateData(
                                                        'cliente_local',
                                                        lista[index]);
                                                  });
                                                },
                                              ),
                                            ),
                                            IconButton(
                                                color: Colors.red,
                                                iconSize: 35,
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                title: const Text(
                                                                    'Remover Item?'),
                                                                content: const Text(
                                                                    'Deseja remover o item do carrinho?'),
                                                                actions: [
                                                                  FlatButton(
                                                                      child: const Text(
                                                                          'Sim'),
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          bye(lista[index].id
                                                                              as dynamic);
                                                                        });

                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }),
                                                                  FlatButton(
                                                                    child: const Text(
                                                                        'Não'),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              ));
                                                },
                                                icon: const Icon(Icons.delete))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              '${total3 = lista.isNotEmpty ? lista.map<double>((e) => e.custoUnitario * e.quantidade).reduce((value, element) => value + element).toStringAsFixed(2) : 0}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 1),
                            ),
                            Row(
                              children: [
                                const Text('Itens:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(width: 190),
                                Text(
                                    '${total = lista.isNotEmpty ? lista.map<int>((e) => e.quantidade as dynamic).reduce((value, element) => value + element).toStringAsFixed(0) : 0}'),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Total:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 150),
                                Text(r'R$'
                                    '${total2 = lista.isNotEmpty ? lista.map<double>((e) => e.valorOriginal * e.quantidade).reduce((value, element) => value + element).toStringAsFixed(2) : 0}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold();
          }
        });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ));
}
