import 'package:esp_socket/shared/app_navigator.dart';
import 'package:esp_socket/shared/notifications/notification-observer.dart';
import 'package:esp_socket/socket/custom-socket-wrapper.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class DashViewModel extends ChangeNotifier implements NotificationObserver {
  late final AppNavigator navigator;

  late TextEditingController controller;
  late ScrollController scrollController;

  @override
  late String id;

  late CustomSocketWrapper customSocketWrapper;
  MaterialColor dotColor = Colors.red;

  DashViewModel() {
    id = "DashPageViewModel";
    controller = TextEditingController();
    scrollController = ScrollController();
    navigator = Injector.appInstance.get<AppNavigator>();
    customSocketWrapper = Injector.appInstance.get<CustomSocketWrapper>();
    print("DashViewModel : CONSTRUCTOR() ");
  }

  @override
  void update(bool connectionEstablished) {
    // TODO: implement update
    print("DashViewModel : UPDATE ::: connectionEstablished=" + connectionEstablished.toString());
    if (connectionEstablished) {
      print("green");
      dotColor = Colors.green;
    } else {
      print("red");
      dotColor = Colors.red;
    }
    notifyListeners();
  }

  int userId = -1;

  onToggleTapped() async {
    try {
      print('toggle');
      customSocketWrapper.send("toggle");
    } catch (e) {
      print('Error: $e');
      return null;
    } finally {}
    notifyListeners();
  }

  onDash() async {
    try {
      // navigator.goToDashPage(userId);
      // game.send("dash");
    } catch (e) {
      print('Error: $e');
      return null;
    } finally {}
    notifyListeners();
  }

  onSend() async {
    try {
      print("DashViewModel : onSend : " + controller.text);
      customSocketWrapper.send(controller.text);
    } catch (e) {
      print('DashViewModel : onSend : Error: $e');
      return null;
    } finally {}
    notifyListeners();
  }
}
