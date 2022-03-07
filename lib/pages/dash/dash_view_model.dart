import 'package:esp_socket/shared/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';

class DashViewModel extends ChangeNotifier {
  late final AppNavigator navigator;

  DashViewModel() {
    navigator = Injector.appInstance.get<AppNavigator>();
  }



  int userId = -1;

  // onLoginTapped() async {
  //   try {
  //     navigator.goToDashPage(userId);
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   } finally {}
  //   notifyListeners();
  // }
}
