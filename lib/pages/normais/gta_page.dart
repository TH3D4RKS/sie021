import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sie021/models/gta.dart';
import 'package:sie021/pages/normais/gta_detalhes.dart';

class GtasPage extends StatefulWidget {
  const GtasPage({Key? key}) : super(key: key);

  @override
  State<GtasPage> createState() => _GtasPageState();
}

class _GtasPageState extends State<GtasPage> {
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
  Widget build(BuildContext context) => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('gtas_ok').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return Column(
                children: [
                  appBarDinamica(),
                  ListTile(
                    title: Text('Nada por Aki :('),
                  )
                ],
              );
            }
            return Scaffold(
              appBar: appBarDinamica(),
              body: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;
                  if (data.isNotEmpty) {
                    print('entrou no builder');
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
                  }
                  print("aki");
                  return null;
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: [
                appBarDinamica(),
                CircularProgressIndicator(),
              ],
            );
          }
        },
      );
}
