import 'package:flutter/material.dart';
import 'package:vendas_ldf_new/database/dao/venda_local_dao.dart';
import 'package:vendas_ldf_new/entities/venda_local.dart';
import 'package:vendas_ldf_new/main.dart';

class ObsPage extends StatefulWidget {
  final VendaLocal valor;
  const ObsPage({Key? key, required this.valor}) : super(key: key);

  @override
  State<ObsPage> createState() => _ObsPageState();
}

class _ObsPageState extends State<ObsPage> {
  final obsCliente = TextEditingController();
  final obsFaturamento = TextEditingController();
  final obsLogistica = TextEditingController();
  var userService2 = VendasLocalDAO();

  @override
  void initState() {
    setState(() {
      obsCliente.text = widget.valor.obsCliente ?? '';
      obsFaturamento.text = widget.valor.obsFaturamento ?? '';
      obsLogistica.text = widget.valor.obsLogistica ?? '';
    });
    super.initState();
  }

  bool validateObsC = false;
  bool validateObsF = false;
  bool validateObsL = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, title: const Text('Observação')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Observação do Cliente:',
              errorText: validateObsC ? 'teste' : null,
            ),
            controller: obsCliente,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Observação para o Faturamento:',
              errorText: validateObsF ? 'teste' : null,
            ),
            controller: obsFaturamento,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Observação para Logistica:',
              errorText: validateObsL ? 'teste' : null,
            ),
            controller: obsLogistica,
          ),
          ElevatedButton(
              onPressed: () {
                userService2.inserRemainig3(VendaLocal(
                    obsCliente: obsCliente.text,
                    obsLogistica: obsFaturamento.text,
                    obsFaturamento: obsLogistica.text,
                    id: widget.valor.id));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const TableLayout()));
              },
              child: const Text('Finalizar', style: TextStyle(fontSize: 20)))
        ]),
      ),
    );
  }
}
