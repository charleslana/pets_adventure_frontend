// ignore_for_file: sort_constructors_first

import 'package:uno/uno.dart';

class LandingService {
  final Uno uno;

  LandingService(this.uno);

  Future<String> getVersion() async {
    final response = await uno.get(
      '/version',
      responseType: ResponseType.plain,
    );
    return response.data;
  }
}
