import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/core/service/encrypt_service.dart';
import 'package:pets_adventure_frontend/src/core/service/shared_local_storage_service.dart';
import 'package:pets_adventure_frontend/src/feature/auth/service/auth_service.dart';
import 'package:pets_adventure_frontend/src/feature/home/service/home_service.dart';
import 'package:pets_adventure_frontend/src/feature/landing/service/landing_service.dart';
import 'package:pets_adventure_frontend/src/feature/register/service/register_service.dart';

class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<AuthService>((i) => AuthService(i()), export: true),
        Bind<SharedLocalStorageService>((i) => SharedLocalStorageService(),
            export: true),
        Bind<EncryptService>((i) => EncryptService(), export: true),
        Bind.singleton<HomeService>((i) => HomeService(i()), export: true),
        Bind.singleton<LandingService>((i) => LandingService(i()),
            export: true),
        Bind.singleton<RegisterService>((i) => RegisterService(i()),
            export: true),
      ];
}
