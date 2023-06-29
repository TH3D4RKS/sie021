import 'package:cloud_firestore/cloud_firestore.dart';

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
