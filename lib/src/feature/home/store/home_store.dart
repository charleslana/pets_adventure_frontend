// ignore_for_file: sort_constructors_first

import 'package:flutter_triple/flutter_triple.dart';
import 'package:pets_adventure_frontend/src/core/error/global_exception.dart';
import 'package:pets_adventure_frontend/src/feature/home/service/home_service.dart';
import 'package:pets_adventure_frontend/src/feature/home/state/home_state.dart';
import 'package:uno/uno.dart';

class HomeStore extends StreamStore<GlobalException, HomeState> {
  final Uno uno;
  final HomeService homeService;

  HomeStore(
    this.uno,
    this.homeService,
  ) : super(InProcess());

  Future<dynamic> fetchDetails() async {
    try {
      final response = await homeService.getDetails();
      update(DetailsLoaded());
      return response;
    } on UnoError<dynamic> catch (e) {
      update(DetailsNotLoaded());
      return e.response;
    }
  }

  void showError(String message) {
    setError(GlobalException(message));
  }
}
