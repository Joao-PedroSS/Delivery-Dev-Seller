import 'package:delivery_dev_seller/app_module.dart';
import 'package:delivery_dev_seller/app_widget.dart';
import 'package:delivery_dev_seller/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    debugPrint('[Firebase] initialized app: ${app.name}');
    debugPrint('[Firebase] projectId: ${app.options.projectId}');
    debugPrint('[Firebase] total apps: ${Firebase.apps.length}');
    debugPrint('[Firebase] auth currentUser: ${FirebaseAuth.instance.currentUser?.uid}');
  } catch (e, s) {
    debugPrint('[Firebase] initialize error: $e');
    debugPrint('$s');
  }

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
