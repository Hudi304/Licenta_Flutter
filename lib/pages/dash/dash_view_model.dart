import 'package:esp_socket/shared/app_navigator.dart';
import 'package:esp_socket/socket/socket-communication.dart';
import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';

class DashViewModel extends ChangeNotifier {
  late final AppNavigator navigator;
  late final SocketCommunication game;

  DashViewModel() {
    navigator = Injector.appInstance.get<AppNavigator>();
    game = Injector.appInstance.get<SocketCommunication>();
    game.send("dash");
  }

  int userId = -1;

  onToggleTapped() async {
    try {
      // navigator.goToDashPage(userId);
      game.send("");
    } catch (e) {
      print('Error: $e');
      return null;
    } finally {}
    notifyListeners();
  }

  onDash() async {
    try {
      // navigator.goToDashPage(userId);
      game.send("dash");
    } catch (e) {
      print('Error: $e');
      return null;
    } finally {}
    notifyListeners();
  }
}
