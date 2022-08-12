import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/core/const/shared_local_storage_const.dart';
import 'package:pets_adventure_frontend/src/core/service/encrypt_service.dart';
import 'package:pets_adventure_frontend/src/feature/auth/dto/login_credential.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/auth/state/auth_state.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_page.dart';

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
    await Future<void>.delayed(const Duration(seconds: 3));
    setState(() {
      loadingText = 'Validando conta...';
    });
    await _fetchLogin();
  }

  Future<void> _fetchLogin() async {
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
