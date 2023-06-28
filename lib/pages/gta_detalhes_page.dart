import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sie021/models/gta.dart';
import 'package:sie021/services/auth_service.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class GtasDetalhesPage extends StatefulWidget {
  final Gta gta;

  const GtasDetalhesPage({Key? key, required this.gta}) : super(key: key);

  @override
  State<GtasDetalhesPage> createState() => _GtasDetalhesPageState();
}

class _GtasDetalhesPageState extends State<GtasDetalhesPage> {
  late NumberFormat real;
  double quantidade = 0;
  Widget grafico = Container();
  bool graficoLoaded = false;

  compartilharPreco() async {
    //final gta = widget.gta;
    final FlutterShareMe shareMe = FlutterShareMe();

    shareMe.shareToSystem(msg: "[DADOS_GTA]");
    // SocialShare.shareOptions(
    //   "Confira o preço do ${gta.nome} agora: ${real.format(gta.preco)}",
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //widget.gta.nome +
        title: Text('[NUMERO_GTA]'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: compartilharPreco,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthService>().logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.network(
                    //   widget.gta.icone,
                    //  scale: 2.5,
                    //  ),
                    Container(width: 10),
                    Text(
                      // real.format(widget.gta.preco) +
                      '[Dados_GTA]',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -1,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
              (quantidade > 0)
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        // padding: EdgeInsets.all(12),
                        alignment: Alignment.center,
                        child: Text(
                          '$quantidade ${widget.gta.sigla}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.teal,
                          ),
                        ),
                        // decoration: BoxDecoration(
                        //   color: Colors.teal.withOpacity(0.05),
                        // ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(bottom: 24),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
