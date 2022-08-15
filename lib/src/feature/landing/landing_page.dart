import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/core/const/shared_local_storage_const.dart';
import 'package:pets_adventure_frontend/src/core/const/version_const.dart';
import 'package:pets_adventure_frontend/src/core/service/encrypt_service.dart';
import 'package:pets_adventure_frontend/src/feature/auth/dto/login_credential.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/auth/state/auth_state.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_page.dart';
import 'package:pets_adventure_frontend/src/feature/landing/service/landing_service.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  static const routeName = '/landing/';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isLoading = true;
  String loadingText = 'Validando versão...';

  @override
  void initState() {
    context.read<AuthStore>().observer(onState: (state) {
      if (state is Logged) {
        Modular.to.navigate(HomePage.routeName);
      } else if (state is NotLogged) {
        Modular.to.navigate(LoginPage.routeName);
      }
    });
    _fetchVersion();
    super.initState();
  }

  Future<void> _fetchVersion() async {
    setState(() {
      loadingText = 'Validando versão...';
    });
    final landingService = Modular.get<LandingService>();
    final version = await landingService.getVersion();
    if (version != appVersion) {
      setState(() {
        isLoading = false;
        loadingText =
            'O aplicativo se encontra desatualizado, por favor atualize em sua loja de aplicações';
      });
      return;
    }
    await _fetchLogin();
  }

  Future<void> _fetchLogin() async {
    setState(() {
      loadingText = 'Validando conta...';
    });
    final store = context.watch<AuthStore>();
    final encryptService = Modular.get<EncryptService>();
    final username = await store.sharedLocalStorageService.get(usernameKey);
    final password = await store.sharedLocalStorageService.get(passwordKey);
    final loginCredential = LoginCredential()
      ..setEmail(encryptService.decrypt(username ?? ''))
      ..setPassword(encryptService.decrypt(password ?? ''));
    await store.login(loginCredential);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) const LinearProgressIndicator(),
              const SizedBox(height: 5),
              Text(loadingText),
            ],
          ),
        ),
      ),
    );
  }
}
