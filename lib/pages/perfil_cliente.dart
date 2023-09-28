import 'package:flutter/material.dart';
import 'package:vendas_ldf_new/entities/venda_local.dart';
import 'package:vendas_ldf_new/entities/cliente_local.dart';

class ProfilePage extends StatefulWidget {
  final Cliente cliente;
  final VendaLocal veenda;
  const ProfilePage({Key? key, required this.cliente, required this.veenda})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                'Nome: ${widget.cliente.nome}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: 380,
                color: Colors.black,
              ),
              Row(
                children: [
                  const SizedBox(
                    height: 40,
                    width: 20,
                  ),
                  Text('Rua: ${widget.cliente.logradouro}',
                      style: const TextStyle(fontSize: 15)),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Nº: ${widget.cliente.numero}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Container(
                height: 1,
                width: 380,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Município: ${widget.cliente.municipio}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Bairro: ${widget.cliente.bairro}',
                      style: const TextStyle(fontSize: 15)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'UF: ${widget.cliente.uf}',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: 380,
                color: Colors.black,
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Text(
                    'Tipo: ${widget.cliente.tipo}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'CPF/CNPJ: ${widget.cliente.documento}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Container(
                height: 1,
                width: 380,
                color: Colors.black,
              ),
              const SizedBox(height: 30),
              Text(
                'Telefone: ${widget.cliente.telefone}',
                style: const TextStyle(fontSize: 15),
              ),
              Container(
                height: 1,
                width: 380,
                color: Colors.black,
              ),
              const SizedBox(height: 30),
              Text('E-mail: ${widget.cliente.email}',
                  style: const TextStyle(fontSize: 15)),
              Container(
                height: 1,
                width: 380,
                color: Colors.black,
              ),
              const SizedBox(height: 30),
              Text('Comprador: ${widget.cliente.comprador}',
                  style: const TextStyle(fontSize: 15)),
              Container(
                height: 1,
                width: 380,
                color: Colors.black,
              ),
              const SizedBox(
                height: 1,
              ),
              Image.asset('assets/logo.png', width: 200, height: 200),
            ],
          ),
        ),
      ),
    );
  }
}
