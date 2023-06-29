import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sie021/services/auth_service.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  @override
  Widget build(BuildContext context) {
    var usuario = context.read<AuthService>().usuario?.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title: const Text('Usuario'),
              subtitle: Text(
                usuario.toString(),
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.indigo,
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: OutlinedButton(
                    onPressed: () => context.read<AuthService>().logout(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Sair do App',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
