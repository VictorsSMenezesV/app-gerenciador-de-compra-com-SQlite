import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vendas_ldf_new/database/dao/cliente_local_dao.dart';

import 'package:vendas_ldf_new/entities/cliente_local.dart';

import '../main.dart';

class EditPage extends StatefulWidget {
  final Cliente cliente;
  const EditPage({Key? key, required this.cliente}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
  var mask = MaskTextInputFormatter(mask: '(##)# ####-####');

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    setState(() {
      nomeController.text = widget.cliente.nome ?? '';
      valortipo = widget.cliente.tipo ?? '';
      docController.text = widget.cliente.documento ?? '';
      ruaController.text = widget.cliente.logradouro ?? '';
      numController.text = widget.cliente.numero ?? '';
      bairroController.text = widget.cliente.bairro ?? '';
      muniController.text = widget.cliente.municipio ?? '';
      foneController.text = widget.cliente.telefone ?? '';
      emailController.text = widget.cliente.email ?? '';
      compradorController.text = widget.cliente.comprador ?? '';
      valoruf = widget.cliente.uf ?? '';
    });
    super.initState();
  }

  var userService = ClienteLocalDAO();

  bool validateName = false;
  bool validateTipo = false;
  bool validateDoc = false;
  bool validateRua = false;
  bool validatenum = false;
  bool validateBairro = false;
  bool validateMuni = false;
  bool validateFone = false;
  bool validateEmail = false;
  bool validateComprador = false;
  bool validateUF = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Editar cadastro'),
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
                      decoration: InputDecoration(
                          labelText: 'Nome:',
                          errorText: validateName ? 'teste' : null),
                      controller: nomeController,
                    ),
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
                          decoration: InputDecoration(
                              labelText: 'CPF/CNPJ:',
                              errorText: validateDoc ? 'teste' : null),
                          controller: docController,
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
                          decoration: InputDecoration(
                              labelText: 'Rua:',
                              errorText: validateRua ? 'teste' : null),
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
                                decoration: InputDecoration(
                                    labelText: 'Número:',
                                    errorText: validatenum ? 'teste' : null),
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
                                decoration: InputDecoration(
                                    labelText: 'Bairro:',
                                    errorText: validateBairro ? 'teste' : null),
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
                                decoration: InputDecoration(
                                    labelText: 'Municipio:',
                                    errorText: validateMuni ? 'teste' : null),
                                controller: muniController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Inserir o municipio!';
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
                                decoration: InputDecoration(
                                    errorText: validateFone ? 'teste' : null,
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
                      decoration: InputDecoration(
                          labelText: 'E-mail:',
                          errorText: validateEmail ? 'teste' : null),
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
                      decoration: InputDecoration(
                          labelText: 'Comprador:',
                          errorText: validateComprador ? 'teste' : null),
                      controller: compradorController,
                    ),
                    const SizedBox(
                      height: 5,
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            nomeController.text.isEmpty
                                ? validateName = true
                                : validateName = false;
                            valortipo.toString().isEmpty
                                ? validateTipo = true
                                : validateTipo = false;
                            docController.text.isEmpty
                                ? validateDoc = true
                                : validateDoc = false;
                            ruaController.text.isEmpty
                                ? validateRua = true
                                : validateRua = false;
                            numController.text.isEmpty
                                ? validatenum = true
                                : validatenum = false;
                            bairroController.text.isEmpty
                                ? validateBairro = true
                                : validateBairro = false;
                            muniController.text.isEmpty
                                ? validateMuni = true
                                : validateMuni = false;
                            foneController.text.isEmpty
                                ? validateFone = true
                                : validateFone = false;
                            valoruf.toString().isEmpty
                                ? validateUF = true
                                : validateUF = false;
                            emailController.text.isEmpty
                                ? validateEmail = true
                                : validateEmail = false;
                            compradorController.text.isEmpty
                                ? validateComprador = true
                                : validateComprador = false;
                          });
                          if (validateName == false ||
                              validateTipo == false ||
                              validateDoc == false ||
                              validateRua == false ||
                              validatenum == false ||
                              validateBairro == false ||
                              validateMuni == false ||
                              validateFone == false ||
                              validateUF == false ||
                              validateEmail == false ||
                              validateComprador == false) {
                            var user = Cliente();
                            user.id = widget.cliente.id;
                            user.nome = nomeController.text;
                            user.tipo = valortipo;
                            user.documento = docController.text;
                            user.logradouro = ruaController.text;
                            user.numero = numController.text;
                            user.bairro = bairroController.text;
                            user.municipio = muniController.text;
                            user.telefone = foneController.text;
                            user.uf = valoruf;
                            user.email = emailController.text;
                            user.comprador = compradorController.text;
                            // ignore: unused_local_variable
                            var result =
                                userService.updateData('cliente_local', user);
                            //  Navigator.pop(context, result);
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const TableLayout()));
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
