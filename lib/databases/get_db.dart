import 'package:cloud_firestore/cloud_firestore.dart';

class Dados {
  Future<List<Map<String, dynamic>>> buscaDadosFirestore() async {
    List<Map<String, dynamic>> dados = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('suaColecao').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          String codMunicipio = documentSnapshot['cod_municipio'];
          String codProp = documentSnapshot['cod_prop'];
          String dataEmissao = documentSnapshot['data_emissao'];
          String dataInsert = documentSnapshot['data_insert'];
          String especie = documentSnapshot['especie'];
          String mod1 = documentSnapshot['mod1'];
          String mod2 = documentSnapshot['mod2'];
          String mod3 = documentSnapshot['mod3'];
          String numeroGta = documentSnapshot['numero_gta'];
          String serie = documentSnapshot['serie'];
          String totalAnimais = documentSnapshot['total_animais'];
          String uf = documentSnapshot['uf'];
          String usuarioInsert = documentSnapshot['usuario_insert'];

          Map<String, dynamic> dadosDocumento = {
            'codMunicipio': codMunicipio,
            'codProp': codProp,
            'dataEmissao': dataEmissao,
            'dataInsert': dataInsert,
            'especie': especie,
            'mod1': mod1,
            'mod2': mod2,
            'mod3': mod3,
            'numeroGta': numeroGta,
            'serie': serie,
            'totalAnimais': totalAnimais,
            'uf': uf,
            'usuarioInsert': usuarioInsert,
          };

          dados.add(dadosDocumento);
        }
      } else {
        print('Não foram encontrados dados.');
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
    }

    return dados;
  }
}
