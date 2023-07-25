import 'package:flutter/material.dart';

import '../../cidades/data_list.dart';
import '../../models/gta.dart';

class GtasDetalhesPage extends StatelessWidget {
  final Gta gta;

  const GtasDetalhesPage({Key? key, required this.gta}) : super(key: key);
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

  serie() {
    for (var letra in alfabeto) {
      print(letra);
      if (letra['posicao'] == gta.serie) {
        print(gta.serie);
        print(letra);
        String lserie = letra['letra'].toString();
        return lserie;
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
        title: Text('Detalhes do GTA'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Código Gta'),
              subtitle: Text('${serie()}' ' ${gta.numeroGta}'),
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
              title: Text('Município Destino'),
              subtitle: Text(municipio()),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Estado Emissão'),
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
