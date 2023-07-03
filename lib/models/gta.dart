import 'package:cloud_firestore/cloud_firestore.dart';

//return Scaffold(
//          appBar: appBarDinamica(),
//          body: Card(child: ListTile(title: Text('NADA POR AQUI :)'))));
class Gta {
  String codMunicipio;
  String codProp;
  String dataEmissao;
  String dataInsert;
  String especie;
  String mod1;
  String mod2;
  String mod3;
  String numeroGta;
  String serie;
  String totalAnimais;
  String uf;
  String usuarioInsert;
  Gta({
    required this.codMunicipio,
    required this.codProp,
    required this.dataEmissao,
    required this.dataInsert,
    required this.especie,
    required this.mod1,
    required this.mod2,
    required this.mod3,
    required this.numeroGta,
    required this.serie,
    required this.totalAnimais,
    required this.uf,
    required this.usuarioInsert,
  });

  static fromSnapshot(QueryDocumentSnapshot<Object?> doc) {}
}

class GtaDupl {
  String duplcodMunicipio;
  String duplcodProp;
  String dupldataEmissao;
  String dupldataInsert;
  String datadupli;
  String duplespecie;
  String duplmod1;
  String duplmod2;
  String duplmod3;
  String duplnumeroGta;
  String duplserie;
  String dupltotalAnimais;
  String dupluf;
  String duplusuarioInsert;
  GtaDupl({
    required this.duplcodMunicipio,
    required this.duplcodProp,
    required this.dupldataEmissao,
    required this.dupldataInsert,
    required this.datadupli,
    required this.duplespecie,
    required this.duplmod1,
    required this.duplmod2,
    required this.duplmod3,
    required this.duplnumeroGta,
    required this.duplserie,
    required this.dupltotalAnimais,
    required this.dupluf,
    required this.duplusuarioInsert,
  });

  static fromSnapshot(QueryDocumentSnapshot<Object?> doc) {}
}
