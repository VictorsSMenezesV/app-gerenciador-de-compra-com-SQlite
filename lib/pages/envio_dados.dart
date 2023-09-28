import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as aqui;
import 'package:vendas_ldf_new/database/dao/cliente_local_dao.dart';
import 'package:vendas_ldf_new/database/dao/item_local_dao.dart';
import 'package:vendas_ldf_new/entities/cliente_local.dart';
import 'package:vendas_ldf_new/entities/item_local.dart';
import 'package:vendas_ldf_new/main.dart';
import '../database/dao/venda_local_dao.dart';
import '../entities/venda_local.dart';

class EncaminharDados extends StatefulWidget {
  final VendaLocal venda;
  final String nome;
  const EncaminharDados({Key? key, required this.venda, required this.nome})
      : super(key: key);

  @override
  State<EncaminharDados> createState() => _EncaminharDadosState();
}

class _EncaminharDadosState extends State<EncaminharDados> {
  Future<List<Cliente>> buscar(dynamic id) async {
    return ClienteLocalDAO().envio(id);
  }

  Future<List<ItemLocal>> buscar2(dynamic id) async {
    return ItemLocalDAO().card(id);
  }

  Future<List<ItemLocal>> rara() async {
    Future<List<ItemLocal>> res = buscar2(widget.venda.id);
    return res;
  }

  var userService = VendasLocalDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                userService.insertRemaining2(
                    VendaLocal(status: 'ENVIADO', id: widget.venda.id));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const TableLayout()));
              },
              icon: const Icon(Icons.arrow_forward))
        ],
        title: const Text('Envio de Dados'),
      ),
      body: FutureBuilder(
          future: Future.wait(
              [buscar(widget.venda.idClienteLocal), buscar2(widget.venda.id)]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            snapshot.data?[0] as dynamic;
            snapshot.data?[1] as dynamic;
            if (snapshot.hasData) {
              List<Cliente> lista = snapshot.data?[0];
              dynamic lista2 = snapshot.data?[1];

              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 200),
                        ElevatedButton(
                          onPressed: () {
                            getCsv() async {
                              List<List<dynamic>> rows = <List<dynamic>>[];
                              for (int i = 0; i < lista2.length; i++) {
                                List<dynamic> row = [];
                                row.add(lista2[i].descricao);
                                row.add(lista2[i].valorOriginal.toString());
                                row.add(lista2[i].quantidade.toString());
                                rows.add(row);
                              }
                              final String path =
                                  (await getApplicationSupportDirectory()).path;
                              final String fileName =
                                  '$path/${widget.nome}_Itens.xlsx';
                              final File file = File(fileName);

                              String csv =
                                  const ListToCsvConverter().convert(rows);
                              file.writeAsString(csv);
                            }

                            Future<void> createExcel() async {
                              final aqui.Workbook workbook = aqui.Workbook();
                              final aqui.Worksheet sheet =
                                  workbook.worksheets[0];

                              sheet
                                  .getRangeByName('A1')
                                  .setText('Codigo do Pedido');
                              sheet.getRangeByName('B1').setText('Comprador');
                              sheet.getRangeByName('C1').setText('Email');
                              sheet.getRangeByName('D1').setText('Telefone');
                              sheet
                                  .getRangeByName('E1')
                                  .setText('OBS. Cliente');
                              sheet
                                  .getRangeByName('F1')
                                  .setText('OBS. Faturamento');
                              sheet
                                  .getRangeByName('G1')
                                  .setText('OBS. Logistica');
                              sheet.getRangeByName('H1').setText('Itens');
                              sheet
                                  .getRangeByName('I1')
                                  .setText('Data Emissão');
                              sheet.getRangeByName('J1').setText('Valor Custo');
                              sheet.getRangeByName('K1').setText('Valor Final');
                              sheet
                                  .getRangeByName('A2')
                                  .setText(widget.venda.id.toString());
                              sheet
                                  .getRangeByName('B2')
                                  .setText(widget.venda.comprador);
                              sheet
                                  .getRangeByName('C2')
                                  .setText(widget.venda.email);
                              sheet
                                  .getRangeByName('D2')
                                  .setText(widget.venda.telefone);
                              sheet
                                  .getRangeByName('E2')
                                  .setText(widget.venda.obsCliente);
                              sheet
                                  .getRangeByName('F2')
                                  .setText(widget.venda.obsFaturamento);
                              sheet
                                  .getRangeByName('G2')
                                  .setText(widget.venda.obsLogistica);
                              sheet
                                  .getRangeByName('H2')
                                  .setText(widget.venda.itens.toString());
                              sheet
                                  .getRangeByName('I2')
                                  .setText(widget.venda.dataEmissao.toString());
                              sheet
                                  .getRangeByName('J2')
                                  .setText(widget.venda.valorCusto.toString());
                              sheet
                                  .getRangeByName('K2')
                                  .setText(widget.venda.valorFinal.toString());

                              final List<int> bytes = workbook.saveAsStream();
                              workbook.dispose();

                              final String path =
                                  (await getApplicationSupportDirectory()).path;
                              final String fileName =
                                  '$path/${widget.nome}_Compra.xlsx';
                              final File file = File(fileName);
                              await file.writeAsBytes(bytes, flush: true);
                            }

                            Future<void> createExcel2() async {
                              final aqui.Workbook workbook = aqui.Workbook();
                              final aqui.Worksheet sheet =
                                  workbook.worksheets[0];
                              sheet
                                  .getRangeByName('A1')
                                  .setText('Codigo do Cliente');
                              sheet.getRangeByName('B1').setText('Tipo');
                              sheet.getRangeByName('C1').setText('Documento');
                              sheet.getRangeByName('D1').setText('Nome');
                              sheet.getRangeByName('E1').setText('Logradouro');
                              sheet.getRangeByName('F1').setText('Numero');
                              sheet.getRangeByName('G1').setText('Bairro');
                              sheet.getRangeByName('H1').setText('Municipio');
                              sheet.getRangeByName('I1').setText('UF');
                              sheet.getRangeByName('J1').setText('Telefone');
                              sheet.getRangeByName('K1').setText('Comprador');
                              sheet.getRangeByName('L1').setText('Email');
                              sheet
                                  .getRangeByName('A2')
                                  .setText(lista[0].id.toString());
                              sheet.getRangeByName('B2').setText(lista[0].tipo);
                              sheet
                                  .getRangeByName('C2')
                                  .setText(lista[0].documento);
                              sheet.getRangeByName('D2').setText(lista[0].nome);
                              sheet
                                  .getRangeByName('E2')
                                  .setText(lista[0].logradouro);
                              sheet
                                  .getRangeByName('F2')
                                  .setText(lista[0].numero);
                              sheet
                                  .getRangeByName('G2')
                                  .setText(lista[0].bairro);
                              sheet
                                  .getRangeByName('H2')
                                  .setText(lista[0].municipio);
                              sheet.getRangeByName('I2').setText(lista[0].uf);
                              sheet
                                  .getRangeByName('J2')
                                  .setText(lista[0].telefone);
                              sheet
                                  .getRangeByName('K2')
                                  .setText(lista[0].comprador);

                              sheet
                                  .getRangeByName('L2')
                                  .setText(lista[0].email);

                              final List<int> bytes = workbook.saveAsStream();
                              workbook.dispose();

                              final String path =
                                  (await getApplicationSupportDirectory()).path;
                              final String fileName =
                                  '$path/${widget.nome}_Cliente.xlsx';
                              final File file = File(fileName);
                              await file.writeAsBytes(bytes, flush: true);
                            }

                            getCsv();
                            createExcel();
                            createExcel2();
                            sendEmail();
                            sendEmail2();
                            sendEmail3();
                          },
                          child: const Text(
                            'ENVIAR',
                            style: TextStyle(fontSize: 40),
                          ),
                        )
                      ],
                    );
                  });
            } else {
              return const Scaffold();
            }
          }),
    );
  }

  sendEmail() async {
    final Email email = Email(
      body: 'Dados da venda',
      subject: 'Dados da venda',
      recipients: ['fastlimpo.ti@gmail.com'],
      cc: ['victormenezes.vicente@gmail.com'],
      attachmentPaths: [
        '/data/data/com.example.vendas_ldf_new/files/${widget.nome}_Itens.xlsx'
      ],
      isHTML: true,
    );
    await FlutterEmailSender.send(email);
  }

  sendEmail2() async {
    final Email email = Email(
      body: 'Dados da venda',
      subject: 'Dados da venda',
      recipients: ['fastlimpo.ti@gmail.com'],
      cc: ['victormenezes.vicente@gmail.com'],
      attachmentPaths: [
        '/data/data/com.example.vendas_ldf_new/files/${widget.nome}_Compra.xlsx'
      ],
      isHTML: true,
    );
    await FlutterEmailSender.send(email);
  }

  sendEmail3() async {
    final Email email = Email(
      body: 'Dados da venda',
      subject: 'Dados da venda',
      recipients: ['fastlimpo.ti@gmail.com'],
      cc: ['victormenezes.vicente@gmail.com'],
      attachmentPaths: [
        '/data/data/com.example.vendas_ldf_new/files/${widget.nome}_Cliente.xlsx'
      ],
      isHTML: true,
    );
    await FlutterEmailSender.send(email);
  }
}
