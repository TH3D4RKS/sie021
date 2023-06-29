import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../cidades/cidades.dart';
import '../models/gta.dart';

class EscanearPage extends StatefulWidget {
  const EscanearPage({Key? key}) : super(key: key);
  @override
  _EscanearPageState createState() => _EscanearPageState();
}

class _EscanearPageState extends State<EscanearPage> {
  String _barcodeResult = 'Aguardando leitura do código de barras......';
  List<String> listaCodigoDeBarras = [];

  Future<void> _scanBarcode() async {
    // String barcodeResult;
    // try {
    // barcodeResult = await FlutterBarcodeScanner.scanBarcode(
    //   '#FF0000', // Cor personalizada para a linha de escaneamento
    //   'Cancelar', // Texto do botão de cancelar
    //   true, // Mostrar flash no scanner
    //   ScanMode.BARCODE, // Modo de escaneamento (padrão)
    // );
    //  } catch (e) {
    //   barcodeResult = 'Falha ao ler o código de barras: $e';
    // }

    setState(() {
      _barcodeResult = '11170536918040620230100000180000124499000494';
    });
  }

  mostrarDupDetalhes(Gta gta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GtasDupDetalhesPage(gta: gta),
      ),
    );
  }

  Future<void> _salvar() async {
    String userr = FirebaseAuth.instance.currentUser!.email.toString();
    DateTime dataAtual = DateTime.now();

    String dataFormatada = DateFormat('dd/MM/yyyy').format(dataAtual);

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String uf = _barcodeResult.substring(0, 2);
    String serie = _barcodeResult.substring(2, 4);
    String numeroGta = _barcodeResult.substring(4, 10);
    String mod1 = _barcodeResult.substring(10, 11);
    String dataEmissao =
        '${_barcodeResult.substring(11, 13)}/${_barcodeResult.substring(13, 15)}/${_barcodeResult.substring(15, 19)}';
    String especie = _barcodeResult.substring(19, 21);
    String totalAnimais = _barcodeResult.substring(21, 28);
    String mod2 = _barcodeResult.substring(28, 29);
    String codProp = _barcodeResult.substring(29, 38);
    String codMunicipio = _barcodeResult.substring(38, 43);
    String mod3 = _barcodeResult.substring(43);

    String dataInsert = dataFormatada;
    String? usuarioInsert = userr;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('gtas_ok')
          .where('numero_gta', isEqualTo: numeroGta)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // O código de barras foi encontrado no banco de dados
      } else {
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
    } catch (e) {
      print('Erro ao adicionar dados ao Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          //11 14 728878 4 13062023 01 0000025 0 000051253 00189 8
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_barcodeResult),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanBarcode,
              child: Text('Escanear Código de Barras'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvar,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

class GtasDupDetalhesPage extends StatelessWidget {
  final Gta gta;

  const GtasDupDetalhesPage({Key? key, required this.gta}) : super(key: key);

  tipo() {
    if (gta.especie == '01') {
      String tipo = 'Bovino';
      return tipo;
    }
  }

  uf() {
    for (var uf in estado) {
      if (uf['cod_uf'] == gta.uf) {
        String nomeuf = uf['nome'].toString();
        return nomeuf;
      }
    }
  }

  municipio() {
    for (var cidade in cidades) {
      if (cidade['cod_cidade'] == gta.codMunicipio) {
        String nomecit = cidade['nome'].toString();
        return nomecit;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gta Duplicado Detalhes'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Código Gta'),
              subtitle: Text('${gta.numeroGta}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Data de Emissão'),
              subtitle: Text('${gta.dataEmissao}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Município'),
              subtitle: Text(municipio()),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Estado'),
              subtitle: Text(uf()),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Código Propriedade'),
              subtitle: Text('${gta.codProp}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Espécie'),
              subtitle: Text(tipo()),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Série'),
              subtitle: Text('${gta.serie}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Total de Animais'),
              subtitle: Text('${gta.totalAnimais}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Usuário Inserção'),
              subtitle: Text('${gta.usuarioInsert}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Data de Inserção'),
              subtitle: Text('${gta.dataInsert}'),
            ),
          ),
        ],
      ),
    );
  }
}
