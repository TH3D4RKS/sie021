import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';
import '../models/gta.dart';
import 'duplicados/gta_dupli_view_detalhes.dart';
import 'duplicados/gtas_dupli_detalhes.dart';

class EscanearPage extends StatefulWidget {
  const EscanearPage({Key? key}) : super(key: key);
  @override
  _EscanearPageState createState() => _EscanearPageState();
}

class _EscanearPageState extends State<EscanearPage> {
  String _barcodeResult = 'Aguardando leitura do código de barras......';
  String _codigo = '';
  List<String> listaCodigoDeBarras = [];

  Future<void> _scanBarcode() async {
    String barcodeResult;
    try {
      barcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000', // Cor personalizada para a linha de escaneamento
        'Cancelar', // Texto do botão de cancelar
        true, // Mostrar flash no scanner
        ScanMode.BARCODE, // Modo de escaneamento (padrão)
      );
    } catch (e) {
      barcodeResult = 'Falha ao ler o código de barras: $e';
    }

    setState(() {
      _barcodeResult = barcodeResult;
      _codigo = barcodeResult;
    });
    _salvar();
  }

  mostrarDupDetalhes(GtaDupl gtadupl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GtasDupDetalhesPage(gtaDupl: gtadupl),
      ),
    );
  }

  mostrarViewDetalhes(Gta gta) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GtasViewDetalhesPage(gta: gta),
      ),
    );
  }

  Future<void> _salvar() async {
    if (_codigo.length == 44) {
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
          FirebaseFirestore.instance
              .collection('gtas_ok')
              .where('numero_gta', isEqualTo: numeroGta)
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((data) async {
              String duplcodMunicipio = data['cod_municipio'];
              String duplcodProp = data['cod_prop'];
              String dupldataEmissao = data['data_emissao'];
              String dupldataInsert = data['data_insert'];
              String datadupli = '';
              String duplespecie = data['especie'];
              String duplmod1 = data['mod1'];
              String duplmod2 = data['mod2'];
              String duplmod3 = data['mod3'];
              String duplnumeroGta = data['numero_gta'];
              String duplserie = data['serie'];
              String dupltotalAnimais = data['total_animais'];
              String dupluf = data['uf'];
              String duplusuarioInsert = data['usuario_insert'];

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

              Vibration.vibrate(pattern: [1, 1000, 500, 2000], amplitude: 128);

              mostrarDupDetalhes(gtadupl);
              try {
                await firestore.collection('gtas').add({
                  'cod_municipio': codMunicipio,
                  'cod_prop': codProp,
                  'data_emissao': dataEmissao,
                  'data_insert': dataInsert,
                  'data_dupli': dataFormatada,
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
              } catch (e) {
                return print(e.toString());
              }
            });
          });
          // O código de barras foi encontrado no banco de dados
        } else {
          try {
            Gta gta = Gta(
              codMunicipio: codMunicipio,
              codProp: codProp,
              dataEmissao: dataEmissao,
              dataInsert: dataInsert,
              especie: especie,
              mod1: mod1,
              mod2: mod2,
              mod3: mod3,
              numeroGta: numeroGta,
              serie: serie,
              totalAnimais: totalAnimais,
              uf: uf,
              usuarioInsert: usuarioInsert,
            );
            mostrarViewDetalhes(gta);
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Codigo de Barras Invalido'),
          backgroundColor: const Color.fromARGB(255, 255, 0, 0)));
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
            Text(_codigo),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanBarcode,
              child: Text('Escanear Código de Barras'),
            ),
            //  SizedBox(height: 20),
            //  ElevatedButton(
            //   onPressed: _salvar,
            // child: Text('Salvar'),
            //),
          ],
        ),
      ),
    );
  }
}
