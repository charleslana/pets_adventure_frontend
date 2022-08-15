// ignore_for_file: sort_constructors_first

import 'package:pets_adventure_frontend/src/feature/home/model/user_details_model.dart';
import 'package:uno/uno.dart';

class HomeService {
  final Uno uno;

  HomeService(this.uno);

  Future<UserDetailsModel> getDetails() async {
    final response = await uno.get('/user/details');
    return UserDetailsModel.fromMap(response.data);
  }
}
