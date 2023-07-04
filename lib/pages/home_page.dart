import 'package:sie021/pages/configuracoes_page.dart';
import 'package:sie021/pages/duplicados/gta_dupli_page.dart';
import 'package:sie021/pages/escanear_page.dart';

import 'package:flutter/material.dart';
import 'package:sie021/pages/normais/gta_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          GtasPage(),
          EscanearPage(),
          GtasDupliPage(),
          ConfiguracoesPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'GTAs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_2), label: 'Escanear'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Duplicados'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Conta'),
        ],
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
        //backgroundColor: Colors.grey[100],
      ),
    );
  }
}
