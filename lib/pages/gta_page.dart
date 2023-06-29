import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sie021/models/gta.dart';

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

  appBarDinamica() {
    return AppBar(title: const Text('Sie 021'), actions: []);
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
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('gtas_ok').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

            return Scaffold(
              appBar: appBarDinamica(),
              body: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;

                  // Extracting data from Firestore documents
                  String codMunicipio = data['cod_municipio'];
                  String codProp = data['cod_prop'];
                  String dataEmissao = data['data_emissao'];
                  String dataInsert = data['data_insert'];
                  String especie = data['especie'];
                  String mod1 = data['mod1'];
                  String mod2 = data['mod2'];
                  String mod3 = data['mod3'];
                  String numeroGta = data['numero_gta'];
                  String serie = data['serie'];
                  String totalAnimais = data['total_animais'];
                  String uf = data['uf'];
                  String usuarioInsert = data['usuario_insert'];

                  return Card(
                    child: ListTile(
                      title: Text('Código Gta: $numeroGta'),
                      subtitle: Text('Data de Emissão: $dataEmissao'),
                      trailing: Icon(Icons.more_vert),
                      onTap: () {
                        Gta gta = Gta(
                          codMunicipio: codMunicipio,
                          codProp: codProp,
                          dataEmissao: dataEmissao,
                          dataInsert: dataInsert,
                          especie: especie,
                          mod1: mod1,
                          mod2: mod2,
                          mod3: mod3,
                          numeroGta: numeroGta,
                          serie: serie,
                          totalAnimais: totalAnimais,
                          uf: uf,
                          usuarioInsert: usuarioInsert,
                        );
                        mostrarDetalhes(gta);
                      },
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      );
}

class GtasDetalhesPage extends StatelessWidget {
  final Gta gta;

  const GtasDetalhesPage({Key? key, required this.gta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do GTA'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Código Município: ${gta.codMunicipio}'),
            Text('Código Prop: ${gta.codProp}'),
            Text('Data de Emissão: ${gta.dataEmissao}'),
            Text('Data de Inserção: ${gta.dataInsert}'),
            Text('Espécie: ${gta.especie}'),
            Text('Mod1: ${gta.mod1}'),
            Text('Mod2: ${gta.mod2}'),
            Text('Mod3: ${gta.mod3}'),
            Text('Número GTA: ${gta.numeroGta}'),
            Text('Série: ${gta.serie}'),
            Text('Total de Animais: ${gta.totalAnimais}'),
            Text('UF: ${gta.uf}'),
            Text('Usuário Inserção: ${gta.usuarioInsert}'),
          ],
        ),
      ),
    );
  }
}
