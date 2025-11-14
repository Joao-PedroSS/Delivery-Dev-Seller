import 'package:delivery_dev_seller/app_module.dart';
import 'package:delivery_dev_seller/app_widget.dart';
import 'package:delivery_dev_seller/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ModularApp(module: AppModule(), child: AppWidget(), ));
}
