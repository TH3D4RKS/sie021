import 'package:sie021/models/gta.dart';

class Historico {
  DateTime dataOperacao;
  String tipoOperacao;
  Gta gta;
  double valor;
  double quantidade;

  Historico({
    required this.dataOperacao,
    required this.tipoOperacao,
    required this.gta,
    required this.valor,
    required this.quantidade,
  });
}
