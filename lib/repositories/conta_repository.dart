import 'package:sie021/database/db.dart';
import 'package:sie021/models/historico.dart';
import 'package:sie021/models/gta.dart';
import 'package:sie021/models/posicao.dart';
import 'package:sie021/repositories/gta_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class ContaRepository extends ChangeNotifier {
  late Database db;
  List<Posicao> _carteira = [];
  List<Historico> _historico = [];
  double _saldo = 0;
  GtaRepository gtas;

  get saldo => _saldo;
  List<Posicao> get carteira => _carteira;
  List<Historico> get historico => _historico;

  ContaRepository({required this.gtas}) {
    _initRepository();
  }

  _initRepository() async {
    await _getSaldo();
    await _getCarteira();
    await _getHistorico();
  }

  _getSaldo() async {
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor,
    });
    _saldo = valor;
    notifyListeners();
  }

  comprar(Gta gta, double valor) async {
    db = await DB.instance.database;
    await db.transaction((txn) async {
      // Verificar se a gta já foi comprada
      final posicaoGta = await txn.query(
        'carteira',
        where: 'sigla = ?',
        whereArgs: [gta.sigla],
      );
      // Se não tem a gta em carteira
      if (posicaoGta.isEmpty) {
        await txn.insert('carteira',
            {'sigla': gta.sigla, 'gta': gta.nome, 'quantidade': (valor / gta.preco).toString()});
      }
      // Já tem a gta em carteira
      else {
        final atual = double.parse(posicaoGta.first['quantidade'].toString());
        await txn.update(
          'carteira',
          {'quantidade': (atual + (valor / gta.preco)).toString()},
          where: 'sigla = ?',
          whereArgs: [gta.sigla],
        );
      }

      // Inserir a compra no historico
      await txn.insert('historico', {
        'sigla': gta.sigla,
        'gta': gta.nome,
        'quantidade': (valor / gta.preco).toString(),
        'valor': valor,
        'tipo_operacao': 'compra',
        'data_operacao': DateTime.now().millisecondsSinceEpoch
      });

      //Atualizar o saldo
      await txn.update('conta', {'saldo': saldo - valor});
    });
    await _initRepository();
    notifyListeners();
  }

  _getCarteira() async {
    _carteira = [];
    List posicoes = await db.query('carteira');
    for (var posicao in posicoes) {
      Gta gta = gtas.tabela.firstWhere(
        (m) => m.sigla == posicao['sigla'],
      );
      _carteira.add(Posicao(
        gta: gta,
        quantidade: double.parse(posicao['quantidade']),
      ));
    }
    notifyListeners();
  }

  _getHistorico() async {
    _historico = [];
    List operacoes = await db.query('historico');
    for (var operacao in operacoes) {
      Gta gta = gtas.tabela.firstWhere(
        (m) => m.sigla == operacao['sigla'],
      );
      _historico.add(
        Historico(
          dataOperacao: DateTime.fromMillisecondsSinceEpoch(operacao['data_operacao']),
          tipoOperacao: operacao['tipo_operacao'],
          gta: gta,
          valor: operacao['valor'],
          quantidade: double.parse(operacao['quantidade']),
        ),
      );
    }
    notifyListeners();
  }
}
