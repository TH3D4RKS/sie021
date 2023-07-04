import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sie021/models/gta.dart';

import 'gta_dupli_detalhes.dart';

class GtasDupliPage extends StatefulWidget {
  const GtasDupliPage({Key? key}) : super(key: key);

  @override
  State<GtasDupliPage> createState() => _GtasDupliPageState();
}

class _GtasDupliPageState extends State<GtasDupliPage> {
  appBarDinamica() {
    return AppBar(title: const Text('GTAs Duplicadas'), actions: []);
  }

  mostrarDetalhes(GtaDupl gtaDupl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GtasDupliDetalhesPage(gtadupl: gtaDupl),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('gtas').snapshots(),
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
                      // Extracting data from Firestore documents
                      String duplcodMunicipio = data['cod_municipio'];
                      String duplcodProp = data['cod_prop'];
                      String dupldataEmissao = data['data_emissao'];
                      String dupldataInsert = data['data_insert'];
                      String datadupli = data['data_dupli'];
                      String duplespecie = data['especie'];
                      String duplmod1 = data['mod1'];
                      String duplmod2 = data['mod2'];
                      String duplmod3 = data['mod3'];
                      String duplnumeroGta = data['numero_gta'];
                      String duplserie = data['serie'];
                      String dupltotalAnimais = data['total_animais'];
                      String dupluf = data['uf'];
                      String duplusuarioInsert = data['usuario_insert'];
                      // ignore: unnecessary_null_comparison

                      return Card(
                        child: ListTile(
                          title: Text('Código Gta: $duplnumeroGta'),
                          subtitle: Text(
                              'Data de Emissão: $dupldataEmissao \nData Duplicata $datadupli'),
                          trailing: Icon(Icons.more_vert),
                          onTap: () {
                            GtaDupl gtadupl = GtaDupl(
                              duplcodMunicipio: duplcodMunicipio,
                              duplcodProp: duplcodProp,
                              dupldataEmissao: dupldataEmissao,
                              dupldataInsert: dupldataInsert,
                              datadupli: datadupli,
                              duplespecie: duplespecie,
                              duplmod1: duplmod1,
                              duplmod2: duplmod2,
                              duplmod3: duplmod3,
                              duplnumeroGta: duplnumeroGta,
                              duplserie: duplserie,
                              dupltotalAnimais: dupltotalAnimais,
                              dupluf: dupluf,
                              duplusuarioInsert: duplusuarioInsert,
                            );

                            mostrarDetalhes(gtadupl);
                          },
                        ),
                      );
                    } else {
                      return Card(
                        child: ListTile(
                          title: Text('NADA POR AQUI :)'),
                        ),
                      );
                    }
                  }),
            );
          } else if (snapshot.hasError) {
            Card(
              child: ListTile(
                title: Text('Código Gta'),
              ),
            );
            return Text('Error: ${snapshot.error}');
          } else {
            Card(
              child: ListTile(
                title: Text('Código Gta'),
              ),
            );

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
