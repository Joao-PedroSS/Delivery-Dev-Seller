import 'package:delivery_dev_seller/auth/auth_module.dart';
import 'package:delivery_dev_seller/core/data/repositories/auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);

    i.addLazySingleton<AuthRepository>(() => AuthRepository());
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.redirect('/', to: '/auth');

    r.module('/auth', module: AuthModule());
  }
}