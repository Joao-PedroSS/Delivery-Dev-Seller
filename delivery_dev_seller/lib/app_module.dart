import 'package:delivery_dev_seller/modules/auth/auth_module.dart';
import 'package:delivery_dev_seller/core/data/repositories/auth_repository.dart';
import 'package:delivery_dev_seller/modules/dashboard/dashboard_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    r.redirect('/', to: '/auth/');

    r.module('/auth', module: AuthModule(), guards: [AuthGuard()]);
    r.module('/dashboard', module: DashboardModule(), guards: [AuthGuard()]);
  }
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/auth/');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final user = FirebaseAuth.instance.currentUser;
    
    return user != null;
  }
}