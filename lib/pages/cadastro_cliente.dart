import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vendas_ldf_new/database/dao/cliente_local_dao.dart';
import 'package:vendas_ldf_new/entities/cliente_local.dart';
import 'package:get/get.dart';

import 'package:vendas_ldf_new/main.dart';
import 'package:brasil_fields/brasil_fields.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nomeController = TextEditingController();
  final tipoController = TextEditingController();
  final docController = TextEditingController();
  final ruaController = TextEditingController();
  final numController = TextEditingController();
  final bairroController = TextEditingController();
  final muniController = TextEditingController();
  final foneController = TextEditingController();
  final ufController = TextEditingController();
  final emailController = TextEditingController();
  final compradorController = TextEditingController();

  Future<dynamic> add() async {
    return ClienteLocalDAO().save2(Cliente(
        idClienteLocal: null,
        nome: nomeController.text,
        tipo: valortipo,
        documento: docController.text,
        logradouro: ruaController.text,
        numero: numController.text,
        bairro: bairroController.text,
        municipio: muniController.text,
        telefone: foneController.text,
        uf: valoruf,
        email: emailController.text,
        comprador: compradorController.text));
  }

  final List<String> uniFe = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];
  final List<String> tipos = ['PESSOA_FISICA', 'PESSOA_JURIDICA'];

  String? valortipo;
  String? valoruf;
  String doc = '';
  var mask = MaskTextInputFormatter(mask: '(##)# ####-####');

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Cadastro'),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                        decoration: const InputDecoration(labelText: 'Nome:'),
                        controller: nomeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Insira um nome';
                          }
                          return null;
                        }),
                    Row(
                      children: [
                        DropdownButton<String>(
                          items: tipos.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                            valortipo = value;
                          }),
                          value: valortipo,
                          hint: const Text('Tipo'),
                        ),
                        const SizedBox(
                          height: 15,
                          width: 15,
                        ),
                        Flexible(
                            child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'CPF/CNPJ:'),
                          controller: docController,
                          validator: (value) {
                            if (GetUtils.isCpf(value!) == true ||
                                GetUtils.isCnpj(value) == true) {
                              return null;
                            }
                            return 'CPF/CNPJ incorreto ';
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfOuCnpjFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Rua:'),
                          controller: ruaController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Inserir a rua!';
                            }
                            return null;
                          },
                        )),
                        const SizedBox(
                          height: 15,
                          width: 15,
                        ),
                        Flexible(
                            child: TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'Numero:'),
                                controller: numController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Inserir o numero!';
                                  }
                                  return null;
                                }))
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: TextFormField(
                                decoration:
                                    const InputDecoration(labelText: 'Bairro:'),
                                controller: bairroController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Inserir a bairro!';
                                  }
                                  return null;
                                })),
                        const SizedBox(
                          height: 15,
                          width: 15,
                        ),
                        Flexible(
                            child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Município:'),
                                controller: muniController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Inserir o município!';
                                  }
                                  return null;
                                }))
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Inserir o telefone!';
                                  }
                                  return null;
                                },
                                inputFormatters: [mask],
                                decoration: const InputDecoration(
                                    labelText: 'Telefone:',
                                    hintText: '(00)00000-0000'),
                                controller: foneController,
                                keyboardType: TextInputType.number)),
                        const SizedBox(width: 60),
                        Flexible(
                          child: DropdownButton<String>(
                            items: uniFe.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              valoruf = value;
                            }),
                            value: valoruf,
                            hint: const Text('UF:'),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'E-mail:'),
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(value)) {
                          return "E-mail Inválido";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                      width: 5,
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(labelText: 'Comprador:'),
                      controller: compradorController,
                    ),
                    const SizedBox(
                      height: 5,
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() == true) {
                            add();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const TableLayout()));
                          }
                        },
                        child: const Text('Cadastrar')),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
              )),
        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ));
}
