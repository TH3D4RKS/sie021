import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
//import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//import 'package:sie021/configs/app_settings.dart';
import 'package:sie021/repositories/conta_repository.dart';
import 'package:sie021/services/auth_service.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  XFile? comprovante;

  @override
  Widget build(BuildContext context) {
    //final conta = context.watch<ContaRepository>();
    //final loc = context.read<AppSettings>().locale;
    //NumberFormat real =
    // NumberFormat.currency(locale: loc['locale'], name: loc['name']);
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
                // real.format(conta.saldo),
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.indigo,
                ),
              ),
              // trailing: IconButton(onPressed: updateSaldo, icon: const Icon(Icons.edit)),
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

  selecionarComprovante() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) setState(() => comprovante = file);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  updateSaldo() async {
    final form = GlobalKey<FormState>();
    final valor = TextEditingController();
    final conta = context.read<ContaRepository>();

    valor.text = conta.saldo.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Atualizar o Saldo'),
        content: Form(
          key: form,
          child: TextFormField(
            controller: valor,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
            ],
            validator: (value) {
              if (value!.isEmpty) return 'Informe o valor do saldo';
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCELAR'),
          ),
          TextButton(
            onPressed: () {
              if (form.currentState!.validate()) {
                conta.setSaldo(double.parse(valor.text));

                Navigator.of(context).pop();
              }
            },
            child: const Text('SALVAR'),
          ),
        ],
      ),
    );
  }
}
