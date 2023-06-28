import 'package:sie021/configs/app_settings.dart';
import 'package:sie021/configs/hive_config.dart';
import 'package:sie021/repositories/gta_repository.dart';
import 'package:sie021/services/auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sie_aplicativo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
          create: (context) => GtaRepository(),
          lazy: false,
        ),
        ChangeNotifierProvider(create: (context) => AppSettings()),
      ],
      child: const MeuAplicativo(),
    ),
  );
}
