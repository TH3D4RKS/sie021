import 'package:flutter/material.dart';

import '../../cidades/data_list.dart';
import '../../models/gta.dart';

class GtasDupliDetalhesPage extends StatelessWidget {
  final GtaDupl gtadupl;

  const GtasDupliDetalhesPage({Key? key, required this.gtadupl})
      : super(key: key);
  tipo() {
    if (gtadupl.duplespecie == '01') {
      String tipo = 'Bovino';
      return tipo;
    }
  }

  uf() {
    for (var uf in estado) {
      if (uf['cod_uf'] == gtadupl.dupluf) {
        String nomeuf = uf['nome'].toString();
        return nomeuf;
      }
    }
  }

  sarie() {
    for (var serie in alfabeto) {
      if (serie['posicao'] == gtadupl.duplserie) {
        String lserie = serie['letra'].toString();
        return lserie;
      }
    }
  }

  municipio() {
    for (var cidade in cidades) {
      if (cidade['cod_cidade'] == gtadupl.duplcodMunicipio) {
        String nomecit = cidade['nome'].toString();
        return nomecit;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do GTA Duplicado'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Código Gta'),
              subtitle: Text('${gtadupl.duplnumeroGta}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Data de Emissão'),
              subtitle: Text('${gtadupl.dupldataEmissao}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Data de Inserção'),
              subtitle: Text('${gtadupl.dupldataInsert}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Data Duplicação'),
              subtitle: Text('${gtadupl.datadupli}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Município Destino'),
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
              subtitle: Text('${gtadupl.duplcodProp}'),
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
              subtitle: Text('${gtadupl.duplserie}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Total de Animais'),
              subtitle: Text('${gtadupl.dupltotalAnimais}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Usuário Inserção'),
              subtitle: Text('${gtadupl.duplusuarioInsert}'),
            ),
          ),
        ],
      ),
    );
  }
}
