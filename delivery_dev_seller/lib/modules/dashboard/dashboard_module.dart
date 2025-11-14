import 'package:delivery_dev_seller/modules/dashboard/ui/pages/dashboard_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardModule extends Module {
  @override
  void binds(Injector i) {
    // TODO: implement binds
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => DashboardPage());

    super.routes(r);
  }
}