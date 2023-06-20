import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:sie021/configs/app_settings.dart';
import 'package:sie021/models/gta.dart';
import 'package:sie021/pages/gta_detalhes_page.dart';
import 'package:sie021/repositories/gta_repository.dart';

class GtasPage extends StatefulWidget {
  const GtasPage({Key? key}) : super(key: key);

  @override
  State<GtasPage> createState() => _GtasPageState();
}

class _GtasPageState extends State<GtasPage> {
  late List<Gta> tabela;
  late NumberFormat real;
  List<Gta> selecionadas = [];
  late Map<String, String> loc;
  late GtaRepository gtas;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  appBarDinamica() {
    return AppBar(
      title: const Text('Sie 021'),
      actions: [],
    );
  }

  mostrarDetalhes(Gta gta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GtasDetalhesPage(gta: gta),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<GtaRepository>().checkPrecos();
  }

  @override
  Widget build(BuildContext context) {
    // favoritas = Provider.of<FavoritasRepository>(context);
    gtas = context.watch<GtaRepository>();
    tabela = gtas.tabela;
    readNumberFormat();

    return Scaffold(
      appBar: appBarDinamica(),
      body: RefreshIndicator(
        onRefresh: () => gtas.checkPrecos(),
        child: tabela.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (BuildContext context, int gta) {
                  return ListTile(
                    title: Text(
                      '[GTA_NUMERO]',
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    leading: (selecionadas.contains(tabela[gta]))
                        ? const CircleAvatar(
                            //child: Icon(Icons.check),
                            )
                        : SizedBox(
                            //  width: 40,child: Image.network(tabela[gta].icone),
                            ),
                    trailing: Text(
                      'Data Leitura',
                      //  real.format(tabela[gta].preco),
                      style: const TextStyle(fontSize: 15),
                    ),
                    onTap: () => mostrarDetalhes(tabela[gta]),
                  );
                },
                padding: const EdgeInsets.all(16),
                separatorBuilder: (_, ___) => const Divider(),
                itemCount: tabela.length,
              ),
      ),
    );
  }
}
