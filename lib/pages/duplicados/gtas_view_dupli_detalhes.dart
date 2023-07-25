import 'package:flutter/material.dart';

import '../../cidades/data_list.dart';
import '../../models/gta.dart';

class GtasViewDupliDetalhesPage extends StatelessWidget {
  final GtaDupl gtaDupl;

  const GtasViewDupliDetalhesPage({Key? key, required this.gtaDupl})
      : super(key: key);

  tipo() {
    if (gtaDupl.duplespecie == '01') {
      String tipo = 'Bovino';
      return tipo;
    }
  }

  uf() {
    for (var uf in estado) {
      if (uf['cod_uf'] == gtaDupl.dupluf) {
        String nomeuf = uf['nome'].toString();
        return nomeuf;
      }
    }
  }

  municipio() {
    for (var cidade in cidades) {
      if (cidade['cod_cidade'] == gtaDupl.duplcodMunicipio) {
        String nomecit = cidade['nome'].toString();
        return nomecit;
      }
    }
  }

  final bgcolor = const Color.fromARGB(255, 245, 7, 7);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        title: Text('Gta Duplicado Detalhes'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Código Gta'),
              subtitle: Text('${gtaDupl.duplnumeroGta}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Data de Emissão'),
              subtitle: Text('${gtaDupl.dupldataEmissao}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Município destino'),
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
              subtitle: Text('${gtaDupl.duplcodProp}'),
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
              subtitle: Text('${gtaDupl.duplserie}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Total de Animais'),
              subtitle: Text('${gtaDupl.dupltotalAnimais}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Usuário Inserção'),
              subtitle: Text('${gtaDupl.duplusuarioInsert}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Data de Inserção'),
              subtitle: Text('${gtaDupl.dupldataInsert}'),
            ),
          ),
        ],
      ),
    );
  }
}
