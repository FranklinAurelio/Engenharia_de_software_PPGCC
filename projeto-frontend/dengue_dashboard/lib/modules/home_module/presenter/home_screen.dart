import 'package:dengue_dashboard/modules/home_module/widgets/gender_radio.dart';
import 'package:estados_municipios/estados_municipios.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRegiao = false;
  bool isState = false;

  Future<List<String>> getState() async {
    final controller = EstadosMunicipiosController();
    final estados = await controller.buscaTodosEstados();
    print(estados);
    return [];
  }

  Future<List<String>> getTown() async {
    final controller = EstadosMunicipiosController();
    final municipios = await controller.buscaMunicipiosPorEstado('SP');
    print(municipios);

    return [];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //await getTown();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Forecasting da dengue no Brasil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Card(
              color: Colors.cyan[200],
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 80,
                child: Row(
                  children: [
                    Center(
                      child: RadioGender(),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
