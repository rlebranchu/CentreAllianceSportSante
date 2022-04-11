import 'package:centre_alliance_sport_sante/Repository/HomeRepository.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository? homeRepository;

  HomeController(this.homeRepository);

  Future<String> getUserName() async {
    return await homeRepository!.getUserName();
  }
}