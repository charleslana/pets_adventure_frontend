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
import 'package:pets_adventure_frontend/src/feature/home/store/home_store.dart';
import 'package:pets_adventure_frontend/src/feature/landing/landing_module.dart';
import 'package:pets_adventure_frontend/src/feature/landing/landing_page.dart';
import 'package:pets_adventure_frontend/src/feature/landing/store/landing_store.dart';
import 'package:pets_adventure_frontend/src/feature/register/register_module.dart';
import 'package:pets_adventure_frontend/src/feature/register/register_page.dart';
import 'package:pets_adventure_frontend/src/feature/register/store/register_store.dart';
import 'package:pets_adventure_frontend/src/feature/splashscreen/splashscreen_module.dart';
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
        TripleBind.lazySingleton((i) => LandingStore(i(), i())),
        TripleBind.singleton((i) => AuthStore(i(), i(), i(), i())),
        TripleBind.singleton((i) => RegisterStore(i(), i())),
        TripleBind.lazySingleton((i) => HomeStore(i(), i())),
      ];

  @override
  List<ModularRoute> routes = [
    ModuleRoute<SplashscreenModule>(Modular.initialRoute,
        module: SplashscreenModule()),
    ModuleRoute<LandingModule>(LandingPage.routeName, module: LandingModule()),
    ModuleRoute<AuthModule>(LoginPage.routeName, module: AuthModule()),
    ModuleRoute<RegisterModule>(RegisterPage.routeName,
        module: RegisterModule()),
    ModuleRoute<HomeModule>(HomePage.routeName, module: HomeModule()),
  ];
}
