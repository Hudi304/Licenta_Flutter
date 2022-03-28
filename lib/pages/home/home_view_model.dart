import 'package:esp_socket/shared/app_navigator.dart';
import 'package:esp_socket/shared/notifications/notification-manager.dart';
import 'package:esp_socket/shared/notifications/notification-observer.dart';
import 'package:esp_socket/socket/custom-socket-wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class HomePageViewModel extends ChangeNotifier implements NotificationObserver {
  late final AppNavigator navigator;

  bool isOn = false;

  late final CustomSocketWrapper customSocketWrapper;
  bool isWebSocketRunning = false;
  int retryLimit = 3;
  MaterialColor dotColor = Colors.red;
  @override
  late String id;

  HomePageViewModel() {
    navigator = Injector.appInstance.get<AppNavigator>();
    id = "HomePageViewModel";
    customSocketWrapper = Injector.appInstance.get<CustomSocketWrapper>();
    NotificationManager.instance.subscribe(this);
  }

  @override
  void update(bool connectionEstablished) {
    // TODO: implement update
    print("HomePageViewModel : UPDATE :::" + connectionEstablished.toString());
    if (connectionEstablished) {
      print("green");
      dotColor = Colors.green;
    } else {
      print("red");
      dotColor = Colors.red;
    }
    notifyListeners();
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
