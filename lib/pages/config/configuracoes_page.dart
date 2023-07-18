import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sie021/services/auth_service.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  appBarDinamica() {
    return AppBar(title: const Text('Usuario'), actions: []);
  }

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  var uemail = FirebaseAuth.instance.currentUser?.email.toString();

  @override
  Widget build(BuildContext context) => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('USERS')
            .where('email', isEqualTo: uemail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return Column(
                children: [
                  appBarDinamica(),
                  ListTile(
                    title: Text(
                        'Usuario com cadastro \nincompleto \ncontate um administrador '),
                  )
                ],
              );
            }
            return Scaffold(
              appBar: appBarDinamica(),
              body: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;

                  if (data.isNotEmpty) {
                    // Extracting data from Firestore documents
                    String nome = data['user'];
                    String email = data['email'];
                    String type = data['type'];
                    // TAMANHO TELA  print(MediaQuery.of(context).size.height * 0.9);
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Card(
                            child: ListTile(
                              title: Text('Usuario: $nome\n\nEmail: $email\n'),
                              subtitle: Text('Nivel De Acesso  $type'),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                          ),
                          ElevatedButton(
                            style: style,
                            onPressed: () => AuthService().logout(),
                            child: const Text('Sair Da Conta'),
                          ),
                        ],
                      ),
                    );
                  }

                  return null;
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: [
                appBarDinamica(),
                CircularProgressIndicator(),
              ],
            );
          }
        },
      );
}
