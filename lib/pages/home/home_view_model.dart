import 'package:esp_socket/shared/app_navigator.dart';
import 'package:esp_socket/shared/notifications/notification-manager.dart';
import 'package:esp_socket/shared/notifications/notification-observer.dart';
import 'package:esp_socket/socket/custom-socket-wrapper.dart';
import 'package:esp_socket/socket/socket-communication.dart';
import 'package:esp_socket/socket/socket-io-wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';

class HomePageViewModel extends ChangeNotifier implements NotificationObserver {
  late final AppNavigator navigator;

  // late final SocketIOWrapper socketWrapper;
  // late final SocketCommunication game;
  bool isOn = false;
  late final CustomSocketWrapper customSocketWrapper;
  bool isWebSocketRunning = false;
  int retryLimit = 3;

  late NotificationManager notificationManager;

  @override
  late String id;

  HomePageViewModel() {
    navigator = Injector.appInstance.get<AppNavigator>();
    id = "HomePageViewModel";
    // game = Injector.appInstance.get<SocketCommunication>();
    // game.addListener(onDataReceieved);
    // isOn = game.sockets.isOn;
    // socketWrapper = Injector.appInstance.get<SocketIOWrapper>();

    notificationManager = Injector.appInstance<NotificationManager>();
    notificationManager.subscribe(this);
    customSocketWrapper = Injector.appInstance<CustomSocketWrapper>();
    customSocketWrapper.addListener(() {
      print("HomePageViewModel Listener");
    });

    customSocketWrapper.tryConnect();

    addListener(() {
      print("listener");
    });

  }

  @override
  void update() {
    // TODO: implement update

    print("HomePageViewModel : UPDATE :::");
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
