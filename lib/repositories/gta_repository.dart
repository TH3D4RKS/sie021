import 'dart:async';
import 'dart:convert';

import 'package:sie021/database/db.dart';
import 'package:sie021/models/gta.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:http/http.dart' as http;

class GtaRepository extends ChangeNotifier {
  List<Gta> _tabela = [];
  late Timer intervalo;

  List<Gta> get tabela => _tabela;

  GtaRepository() {
    _setupGtasTable();
    _setupDadosTableGta();
    _readGtasTable();
    // _refreshPrecos();
  }

  // _refreshPrecos() async {
  //   intervalo = Timer.periodic(Duration(minutes: 5), (_) => checkPrecos());
  // }

  getHistoricoGta(Gta gta) async {
    final response = await http.get(
      Uri.parse(
        'https://api.coinbase.com/v2/assets/prices/${gta.baseId}?base=BRL',
      ),
    );
    List<Map<String, dynamic>> precos = [];

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final Map<String, dynamic> gta = json['data']['prices'];

      precos.add(gta['hour']);
      precos.add(gta['day']);
      precos.add(gta['week']);
      precos.add(gta['month']);
      precos.add(gta['year']);
      precos.add(gta['all']);
    }

    return precos;
  }

  checkPrecos() async {
    String uri = 'https://api.coinbase.com/v2/assets/prices?base=BRL';
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> gtas = json['data'];
      Database db = await DB.instance.database;
      Batch batch = db.batch();

      for (var atual in _tabela) {
        for (var novo in gtas) {
          if (atual.baseId == novo['base_id']) {
            final gta = novo['prices'];
            final preco = gta['latest_price'];
            final timestamp = DateTime.parse(preco['timestamp']);

            batch.update(
              'gtas',
              {
                'preco': gta['latest'],
                'timestamp': timestamp.millisecondsSinceEpoch,
                'mudancaHora': preco['percent_change']['hour'].toString(),
                'mudancaDia': preco['percent_change']['day'].toString(),
                'mudancaSemana': preco['percent_change']['week'].toString(),
                'mudancaMes': preco['percent_change']['month'].toString(),
                'mudancaAno': preco['percent_change']['year'].toString(),
                'mudancaPeriodoTotal': preco['percent_change']['all'].toString()
              },
              where: 'baseId = ?',
              whereArgs: [atual.baseId],
            );
          }
        }
      }
      await batch.commit(noResult: true);
      await _readGtasTable();
    }
  }

  _readGtasTable() async {
    Database db = await DB.instance.database;
    List resultados = await db.query('gtas');

    _tabela = resultados.map((row) {
      return Gta(
        baseId: row['baseId'],
        icone: row['icone'],
        sigla: row['sigla'],
        nome: row['nome'],
        preco: double.parse(row['preco']),
        timestamp: DateTime.fromMillisecondsSinceEpoch(row['timestamp']),
        mudancaHora: double.parse(row['mudancaHora']),
        mudancaDia: double.parse(row['mudancaDia']),
        mudancaSemana: double.parse(row['mudancaSemana']),
        mudancaMes: double.parse(row['mudancaMes']),
        mudancaAno: double.parse(row['mudancaAno']),
        mudancaPeriodoTotal: double.parse(row['mudancaPeriodoTotal']),
      );
    }).toList();

    notifyListeners();
  }

  _gtasTableIsEmpty() async {
    Database db = await DB.instance.database;
    List resultados = await db.query('gtas');
    return resultados.isEmpty;
  }

  _setupDadosTableGta() async {
    if (await _gtasTableIsEmpty()) {
      String uri = 'https://api.coinbase.com/v2/assets/search?base=BRL';

      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> gtas = json['data'];
        Database db = await DB.instance.database;
        Batch batch = db.batch();

        for (var gta in gtas) {
          final preco = gta['latest_price'];
          final timestamp = DateTime.parse(preco['timestamp']);

          batch.insert('gtas', {
            'baseId': gta['id'],
            'sigla': gta['symbol'],
            'nome': gta['name'],
            'icone': gta['image_url'],
            'preco': gta['latest'],
            'timestamp': timestamp.millisecondsSinceEpoch,
            'mudancaHora': preco['percent_change']['hour'].toString(),
            'mudancaDia': preco['percent_change']['day'].toString(),
            'mudancaSemana': preco['percent_change']['week'].toString(),
            'mudancaMes': preco['percent_change']['month'].toString(),
            'mudancaAno': preco['percent_change']['year'].toString(),
            'mudancaPeriodoTotal': preco['percent_change']['all'].toString()
          });
        }
        await batch.commit(noResult: true);
      }
    }
  }

  _setupGtasTable() async {
    const String table = '''
      CREATE TABLE IF NOT EXISTS gtas (
        baseId TEXT PRIMARY KEY,
        sigla TEXT,
        nome TEXT,
        icone TEXT,
        preco TEXT,
        timestamp INTEGER,
        mudancaHora TEXT,
        mudancaDia TEXT,
        mudancaSemana TEXT,
        mudancaMes TEXT,
        mudancaAno TEXT,
        mudancaPeriodoTotal TEXT
      );
    ''';
    Database db = await DB.instance.database;
    await db.execute(table);
  }
}
