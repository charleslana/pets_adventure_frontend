import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_triple_bind/modular_triple_bind.dart';
import 'package:pets_adventure_frontend/src/core/api/api.dart';
import 'package:pets_adventure_frontend/src/core/core_module.dart';
import 'package:pets_adventure_frontend/src/feature/auth/auth_module.dart';
import 'package:pets_adventure_frontend/src/feature/auth/interceptor/interceptors.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_module.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_page.dart';
import 'package:uno/uno.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) {
          final uno = Uno(baseURL: baseUrl);
          uno.interceptors.request.use(addToken);
          uno.interceptors.response.use(
            (response) => response,
            onError: tryRefreshToken,
          );
          return uno;
        }),
        TripleBind.singleton((i) => AuthStore(i(), i())),
      ];

  @override
  List<ModularRoute> routes = [
    ModuleRoute<AuthModule>(LoginPage.routeName, module: AuthModule()),
    ModuleRoute<HomeModule>(HomePage.routeName, module: HomeModule()),
  ];
}
