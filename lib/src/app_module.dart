import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_triple_bind/modular_triple_bind.dart';
import 'package:pets_adventure_frontend/src/feature/auth/interceptor/interceptors.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_page.dart';
import 'package:uno/uno.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) {
          final uno =
              Uno(baseURL: 'https://pets-adventure-backend.herokuapp.com');
          uno.interceptors.request.use(addToken);
          uno.interceptors.response.use(
            (response) => response,
            onError: tryRefreshToken,
          );
          return uno;
        }),
        TripleBind.singleton((i) => AuthStore(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute<dynamic>('/auth/login', child: (_, __) => const LoginPage()),
        ChildRoute<dynamic>('/home', child: (_, __) => const HomePage()),
      ];
}
