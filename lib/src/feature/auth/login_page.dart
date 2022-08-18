import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/core/widgets/app_loading.dart';
import 'package:pets_adventure_frontend/src/core/widgets/app_snack_bar.dart';
import 'package:pets_adventure_frontend/src/feature/auth/dto/login_credential.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';
import 'package:pets_adventure_frontend/src/feature/home/home_page.dart';
import 'package:pets_adventure_frontend/src/feature/register/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = '/auth/login/';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscured = true;
  final credential = LoginCredential();
  bool isObscuredPassword = true;
  bool isObscuredConfirmPassword = true;

  @override
  void initState() {
    context.read<AuthStore>().observer(
          onError: (e) {
            showSnackBar(context, e.message, SnackBarEnum.error);
          },
          onLoading: (isLoading) => {
            if (isLoading)
              {
                showLoading(context),
              }
            else
              {
                Navigator.of(context).pop(),
              }
          },
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AuthStore>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                height: 50,
                'https://seeklogo.com/images/J/jwt-logo-65D86B4640-seeklogo.com.png',
              ),
              const SizedBox(height: 60),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: credential.setEmail,
                validator: (value) => credential.email.validate(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: credential.setPassword,
                validator: (value) => credential.password.validate(),
                obscureText: isObscured,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final validate = credential.validate();
                  if (validate == null) {
                    await store.login(credential);
                  } else {
                    store.showError(validate);
                  }
                },
                child: const Text('Entrar'),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () => {
                  Modular.dispose<AuthStore>(),
                  Modular.to.navigate(RegisterPage.routeName),
                },
                child: const Text('Registrar'),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () => Modular.to.navigate(HomePage.routeName),
                child: const Text('Ir para Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
