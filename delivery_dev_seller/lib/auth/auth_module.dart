import 'package:delivery_dev_seller/core/data/repositories/auth_repository.dart';
import 'package:delivery_dev_seller/auth/ui/pages/auth_page.dart';
import 'package:delivery_dev_seller/auth/ui/viewmodels/auth_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AuthViewmodel>(() => AuthViewmodel(Modular.get<AuthRepository>()));
  }

  @override
  void routes(r) {
    super.routes(r);

    r.child('/', child: (context) =>  AuthPage());
  }
}