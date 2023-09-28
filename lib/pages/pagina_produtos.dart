// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vendas_ldf_new/database/dao/venda_local_dao.dart';
import 'package:vendas_ldf_new/entities/produto_local.dart';
import 'package:vendas_ldf_new/entities/cliente_local.dart';
import 'package:vendas_ldf_new/main.dart';
import 'package:vendas_ldf_new/pages/loading_page.dart';
import '../database/dao/produto_local_dao.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({Key? key}) : super(key: key);

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  @override
  // ignore: override_on_non_overriding_member
  ProdutoLocalDAO? helper;
  late List<List<dynamic>> employeeData;
  TextEditingController teSearch = TextEditingController();
  List<List<dynamic>> data = [];
  List allCourses = [];
  List items = [];
  late List<List<dynamic>> employeeData2;
  var userService2 = ProdutoLocalDAO();

  Future<List<Cliente?>?> nova() async {
    return VendasLocalDAO().query();
  }

  @override
  void initState() {
    super.initState();
    employeeData2 = List<List<dynamic>>.empty(growable: true);
    helper = ProdutoLocalDAO();
    employeeData = List<List<dynamic>>.empty(growable: true);
    helper?.todosProdutos().then((courses) {
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

  Future<bool> saved() async {
    return false;
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;

      final input = File(file.path as dynamic).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();

      setState(() {
        data = fields;
      });

      for (var row in data) {
        ProdutoLocalDAO().save(Produto(
            id: int.parse(row[0].toString()) as dynamic,
            descricao: row[1],
            custo: row[2],
            valor: row[3],
            valorMinimo: row[4],
            quantidadeAtual: row[5]));
      }
    }
  }

  void load() async {
    var newdata = await pickFile();
    setState(() {
      data = newdata;
    });
    // primeiro: linha - segundo: coluna
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
    }
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _buscar(),
        builder: (context, futuro) {
          if (futuro.hasData) {
            return WillPopScope(
              onWillPop: showExitPopup,
              child: Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title:
                                        const Text('Atualização de Produtos '),
                                    content: SizedBox(
                                      width: 200,
                                      height: 150,
                                      child: Column(children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              userService2.removeall();

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const TableLayout()));
                                            },
                                            child: const Text(
                                              'Apagar Produtos',
                                              style: TextStyle(fontSize: 20),
                                            )),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              /*    setState(() {
                                                userService2.removeall();
                                              });*/
                                              await pickFile();

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const LoadingPage()));
                                              const CircularProgressIndicator();
                                            },
                                            child: const Text(
                                                'Atualizar Produtos',
                                                style: TextStyle(fontSize: 20)))
                                      ]),
                                    ),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'))
                                    ],
                                  ));
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                  centerTitle: true,
                  title: const Text('Produtos'),
                ),
                body: Column(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, i) {
                            dynamic produto = items[i];
                            return ListTile(
                              title: Text(produto['DESCRICAO'].toString()),
                              subtitle: Text(produto['VALOR'].toString()),
                              trailing: Text(
                                  'QTD: ${produto['QUANTIDADE_ATUAL'].toString()}'),
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
