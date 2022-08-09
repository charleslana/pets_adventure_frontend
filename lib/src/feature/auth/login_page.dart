import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/core/error/global_exception.dart';
import 'package:pets_adventure_frontend/src/feature/auth/dto/login_credential.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscured = true;
  final credential = LoginCredential();

  @override
  void initState() {
    super.initState();
    context.read<AuthStore>().observer(onError: (e) {
      final snackBar = SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AuthStore>();

    return Scaffold(
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
              onPressed: () {
                final validate = credential.validate();
                if (validate == null) {
                  store.login(credential);
                } else {
                  store.setError(GlobalException(validate));
                }
              },
              child: const Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
