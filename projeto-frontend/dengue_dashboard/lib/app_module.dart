import 'package:dengue_dashboard/modules/home_module/home_module.dart';
import 'package:dengue_dashboard/shared/dio_http_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((_) => DioHttpService()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      '/home/',
      module: HomeModule(),
    )
  ];
}
