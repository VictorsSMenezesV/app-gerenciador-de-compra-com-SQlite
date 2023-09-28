import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:vendas_ldf_new/main.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularPercentIndicator(
                  animation: true,
                  animationDuration: 28000,
                  radius: 150,
                  lineWidth: 30,
                  percent: 1,
                  progressColor: Colors.blue,
                  backgroundColor: Colors.blue.shade200,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                const Center(
                  child: Text(
                    '   Espere a atualização   \n  terminar para clicar em \n               "Avançar"',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const TableLayout()));
                    },
                    child:
                        const Text('Avançar', style: TextStyle(fontSize: 40)))
              ]),
        ),
      ),
    );
  }
}
