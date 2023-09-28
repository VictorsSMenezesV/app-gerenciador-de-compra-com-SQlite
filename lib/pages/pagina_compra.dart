// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:vendas_ldf_new/database/dao/item_local_dao.dart';
import 'package:vendas_ldf_new/database/dao/venda_local_dao.dart';
import 'package:vendas_ldf_new/entities/produto_local.dart';
import 'package:vendas_ldf_new/entities/venda_local.dart';
import 'package:vendas_ldf_new/entities/cliente_local.dart';
import 'package:vendas_ldf_new/entities/item_local.dart';
import 'package:vendas_ldf_new/pages/pagina_carrinho.dart';

import '../database/dao/produto_local_dao.dart';

class VendasPage extends StatefulWidget {
  final VendaLocal teste;

  const VendasPage({Key? key, required this.teste}) : super(key: key);

  @override
  State<VendasPage> createState() => _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  @override
  // ignore: override_on_non_overriding_member
  ProdutoLocalDAO helper = ProdutoLocalDAO();
  Produto help = Produto();
  VendaLocal helpp = VendaLocal();
  ItemLocal? local;
  TextEditingController teSearch = TextEditingController();
  dynamic valorid;
  List allCourses = [];
  List items = [];

  // ignore: prefer_typing_uninitialized_variables
  var resu;
  Future<List<Cliente?>?> nova() async {
    return VendasLocalDAO().query();
  }

  @override
  void initState() {
    super.initState();
    helper = ProdutoLocalDAO();
    helper.todosProdutos().then((courses) {
      setState(() {
        allCourses = courses as dynamic;
        items = allCourses;
      });
    });
  }

  void filterSearch(String query) async {
    var dummySearchList = allCourses;
    if (query.isNotEmpty) {
      var dummyListData = [];
      for (var item in dummySearchList) {
        var produto = Produto.fromMap(item);
        if (produto.descricao!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items = [];
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allCourses;
      });
    }
  }

  Future<List<Produto>> _buscar() async {
    return ProdutoLocalDAO().find();
  }

  Future<ItemLocal> colocar(ItemLocal itemLocal) async {
    return ItemLocalDAO().insert(itemLocal);
  }

  var helpService = ItemLocal(quantidade: 1);
  dynamic aqui;
  int? valor;
  dynamic valor2;
  dynamic valor3;
  dynamic quant = 1;
  var helpService2 = ItemLocalDAO();
  final quantidadeController = TextEditingController(text: '1');

  Future<bool> saved() async {
    return false;
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _buscar(),
        builder: (context, futuro) {
          if (futuro.hasData) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          valorid = widget.teste.id;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CardPage(item: widget.teste)));
                      },
                      icon: const Icon(Icons.local_grocery_store_rounded)),
                ],
                title: const Text('Produtos '),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          filterSearch(value);
                        });
                      },
                      controller: teSearch,
                      decoration: const InputDecoration(
                          hintText: 'Pesquisar',
                          labelText: 'Pesquisar',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, i) {
                            dynamic produto = items[i];

                            return Container(
                              margin: const EdgeInsets.all(2.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            produto['DESCRICAO'].toString(),
                                            style:
                                                const TextStyle(fontSize: 20.0),
                                            maxLines: 2,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            r"   R$:" +
                                                produto['VALOR']
                                                    .toStringAsFixed(2),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 127,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                            title: const Text(
                                                                'Quantidade'),
                                                            content: TextField(
                                                              decoration:
                                                                  const InputDecoration(
                                                                      labelText:
                                                                          'Quantidade'),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller:
                                                                  quantidadeController,
                                                            ),
                                                            actions: [
                                                              FlatButton(
                                                                  child: const Text(
                                                                      'Incluir'),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      valor = int.parse(
                                                                          quantidadeController
                                                                              .text);
                                                                      quantidadeController
                                                                          .clear();
                                                                      colocar(ItemLocal(
                                                                              idVendaLocal: widget.teste.id,
                                                                              dataEmissao: DateTime.now().toString(),
                                                                              idProduto: produto['ID'],
                                                                              descricao: produto['DESCRICAO'].toString(),
                                                                              custoUnitario: produto['CUSTO'],
                                                                              valorOriginal: produto['VALOR'],
                                                                              valorPraticado: produto['VALOR_MINIMO'],
                                                                              quantidade: valor ?? 1,
                                                                              desconto: produto['VALOR'] - produto['VALOR_MINIMO'],
                                                                              total: resu = (local?.quantidade ?? 1 * produto['VALOR'])))
                                                                          .then((value) async {})
                                                                          .onError((error, stackTrace) {});
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  }),
                                                              FlatButton(
                                                                child: const Text(
                                                                    'Cancelar'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          ));
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: const Center(
                                                  child: Text(
                                                'Adicionar',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                            );
                          }),
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
}
