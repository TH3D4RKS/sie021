import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EscanearPage extends StatefulWidget {
  const EscanearPage({Key? key}) : super(key: key);

  @override
  State<EscanearPage> createState() => _EscanearPageState();
}

class _EscanearPageState extends State<EscanearPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firestore Example'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Populate Firestore'),
            onPressed: () {
              populateFirestore();
            },
          ),
        ),
      ),
    );
  }

  void populateFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String codMunicipio = '10';
    String codProp = '999999999';
    String dataEmissao = '19/06/2023';
    String dataInsert = '20/06/2023';
    String especie = '01';
    String mod1 = '02';
    String mod2 = '02';
    String mod3 = '03';
    String numeroGta = '99663322';
    String serie = '15';
    String totalAnimais = '00012';
    String uf = '11';
    String usuarioInsert = 'd4rks';

    try {
      await firestore.collection('gtas_ok').add({
        'cod_municipio': codMunicipio,
        'cod_prop': codProp,
        'data_emissao': dataEmissao,
        'data_insert': dataInsert,
        'especie': especie,
        'mod1': mod1,
        'mod2': mod2,
        'mod3': mod3,
        'numero_gta': numeroGta,
        'serie': serie,
        'total_animais': totalAnimais,
        'uf': uf,
        'usuario_insert': usuarioInsert,
      });
      print('Dados adicionados ao Firestore com sucesso!');
    } catch (e) {
      print('Erro ao adicionar dados ao Firestore: $e');
    }
  }
}
