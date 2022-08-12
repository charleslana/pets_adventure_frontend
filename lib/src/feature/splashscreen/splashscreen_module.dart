import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/feature/splashscreen/splashscreen_page.dart';

class SplashscreenModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute<dynamic>(
          Modular.initialRoute,
          child: (_, __) => const SplashscreenPage(),
        ),
      ];
}
