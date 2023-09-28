import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vendas_ldf_new/database/dao/venda_local_dao.dart';
import 'package:vendas_ldf_new/entities/produto_local.dart';
import 'package:vendas_ldf_new/pages/pagina_produtos.dart';
import 'package:vendas_ldf_new/entities/cliente_local.dart';
import 'package:vendas_ldf_new/pages/pagina_pedido.dart';
import 'package:vendas_ldf_new/pages/pagina_cliente.dart';

import 'database/dao/produto_local_dao.dart';

void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: TableLayout(itens: null));
  }
}

class TableLayout extends StatefulWidget {
  final dynamic itens;
  const TableLayout({
    Key? key,
    this.itens,
  }) : super(key: key);

  @override
  _TableLayoutState createState() => _TableLayoutState();
}

class _TableLayoutState extends State<TableLayout> {
  List<List<dynamic>> data = [];

  loadAsset() async {
    final myData = await rootBundle.loadString("assets/produto_local.csv");
    List<List<dynamic>> csvTable =
        const CsvToListConverter(eol: '\n', fieldDelimiter: ',')
            .convert(myData);

    return csvTable;
  }

  void load() async {
    var newdata = await loadAsset();
    setState(() {
      data = newdata;
    });
    print(data[3][1]); // primeiro: linha - segundo: coluna
  }

  void teste() {
    for (var row in data) {
      ProdutoLocalDAO().save(Produto(
          id: int.parse(row[0].toString()),
          descricao: row[1],
          custo: row[2],
          valor: row[3],
          valorMinimo: row[4],
          quantidadeAtual: row[5]));
      print('inserido');
    }
  }

  int currentIndex = 1;
  final screens = [
    const ClientePage(),
    const PedidoPage(
      itens: [],
    ),
    const ProdutosPage()
  ];

  Future<List<Cliente?>?> nova() async {
    return VendasLocalDAO().query();
  }

  @override
  Widget build(BuildContext context) {
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

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WillPopScope(
          onWillPop: showExitPopup,
          child: Scaffold(
              appBar: AppBar(actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        loadAsset();
                        load();
                        teste();
                      });
                    },
                    icon: const Icon(Icons.add))
              ]),
              body: screens[currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.orange,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white54,
                type: BottomNavigationBarType.fixed,
                iconSize: 40,
                showUnselectedLabels: false,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_box),
                    label: 'Clientes',
                    // backgroundColor: Colors.blue,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Pedidos',
                    // backgroundColor: Colors.green,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.pageview_outlined),
                    label: 'Produtos',
                    //backgroundColor: Colors.orange,
                  ),
                ],
              )),
        ));
  }
}
