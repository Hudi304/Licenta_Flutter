import 'package:esp_socket/shared/app_navigator.dart';
import 'package:esp_socket/socket/socket-communication.dart';
import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';

class LoginViewModel extends ChangeNotifier {
  late final AppNavigator navigator;
  late final SocketCommunication game;
  bool isOn = false;

  bool isWebSocketRunning = false;
  int retryLimit = 3;

  LoginViewModel() {
    navigator = Injector.appInstance.get<AppNavigator>();
    game = Injector.appInstance.get<SocketCommunication>();
    // game.addListener(onDataReceieved);
    isOn = game.sockets.isOn;

    game.setRefresh(() => refreshPage());
  }

  onLoginTapped() async {
    try {
      navigator.goToDashPage();
    } catch (e) {
      print('Error: $e');
      return null;
    } finally {}
    notifyListeners();
  }

  onDashTapped() {
    navigator.goToDashPage();
  }

  refreshPage() {
    print("refresh");
    notifyListeners();
  }

  onFuelTapped() {
    navigator.goToFuelTablePage();
  }

  onIgnitionTapped() {
    navigator.goToIgnitionTablePage();
  }

  onDataReceieved(String message) {
    print("HomePage : " + message);
  }
}
