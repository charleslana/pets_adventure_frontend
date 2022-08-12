import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/core/service/encrypt_service.dart';
import 'package:pets_adventure_frontend/src/core/service/shared_local_storage_service.dart';
import 'package:pets_adventure_frontend/src/feature/auth/service/auth_service.dart';

class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<AuthService>((i) => AuthService(i()), export: true),
        Bind<SharedLocalStorageService>((i) => SharedLocalStorageService(),
            export: true),
        Bind<EncryptService>((i) => EncryptService(), export: true),
      ];
}
