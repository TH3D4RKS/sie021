import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sie021/databases/db_firestore.dart';
import 'package:sie021/models/gta.dart';
import 'package:sie021/repositories/gta_repository.dart';
import 'package:sie021/services/auth_service.dart';

import 'package:flutter/material.dart';

class FavoritasRepository extends ChangeNotifier {
  final List<Gta> _lista = [];
  late FirebaseFirestore db;
  late AuthService auth;
  GtaRepository gtas;

  FavoritasRepository({required this.auth, required this.gtas}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readFavoritas();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readFavoritas() async {
    if (auth.usuario != null && _lista.isEmpty) {
      try {
        final snapshot = await db.collection('gtas').get();

        for (var doc in snapshot.docs) {
          Gta gta = gtas.tabela.firstWhere((gta) => gta.sigla == doc.get('sigla'));
          _lista.add(gta);
          notifyListeners();
        }
      } catch (e) {
        debugPrint('Sem id de usuário');
      }
    }
  }

  UnmodifiableListView<Gta> get lista => UnmodifiableListView(_lista);

  saveAll(List<Gta> gtas) async {
    for (var gta in gtas) {
      if (!_lista.any((atual) => atual.sigla == gta.sigla)) {
        _lista.add(gta);
        try {
          await db.collection('gta').doc(gta.sigla).set({
            'gta': gta.nome,
            'sigla': gta.sigla,
            'preco': gta.preco,
          });
        } on FirebaseException catch (e) {
          debugPrint('Permissão Required no Firestore: $e');
        }
      }
    }
    notifyListeners();
  }

  remove(Gta gta) async {
    await db.collection('gta').doc(gta.sigla).delete();
    _lista.remove(gta);
    notifyListeners();
  }
}
