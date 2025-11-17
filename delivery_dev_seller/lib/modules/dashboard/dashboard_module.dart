import 'package:delivery_dev_seller/modules/dashboard/data/repositories/dashboard_repository.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/pages/dashboard_page.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/pages/drivers_page.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/pages/solitations_page.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/viewmodels/dashboard_viewmodel.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => DeliveryRepository());
    i.addSingleton(() => DashboardViewmodel(i.get<DeliveryRepository>()));

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => DashboardPage());
    r.child('/solitations', child: (_) => SolitationsPage());
    r.child('/drivers', child: (_) => DriversPage());

    super.routes(r);
  }
}