import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pets_adventure_frontend/src/feature/auth/login_page.dart';
import 'package:pets_adventure_frontend/src/feature/auth/store/auth_store.dart';
import 'package:pets_adventure_frontend/src/feature/home/model/user_details_model.dart';
import 'package:pets_adventure_frontend/src/feature/home/service/home_service.dart';
import 'package:uno/uno.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<UserDetailsModel> _fetchDetails() async {
    final homeService = Modular.get<HomeService>();
    final response = await homeService.getDetails();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AuthStore>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
              icon: const Icon(Icons.login),
              onPressed: () => Modular.to.navigate(LoginPage.routeName),
              tooltip: 'Go to login route',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _futureDetails(),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: const Text('Get user'),
                  onPressed: () async {
                    final uno = Modular.get<Uno>();
                    final response = await uno.get('/user');
                    print(response.data);
                  },
                ),
                const SizedBox(height: 30),
                OutlinedButton(
                  onPressed: store.logout,
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _futureDetails() {
    return FutureBuilder(
      future: _fetchDetails(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occurred',
                style: const TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data as UserDetailsModel;
            return _details(data);
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _details(UserDetailsModel userDetailsModel) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('ID'),
            Text(userDetailsModel.id.toString()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('E-mail'),
            Text(userDetailsModel.email),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Name'),
            Text(userDetailsModel.name),
          ],
        ),
      ],
    );
  }
}
