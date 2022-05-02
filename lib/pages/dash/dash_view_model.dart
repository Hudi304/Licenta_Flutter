import 'package:esp_socket/shared/app_navigator.dart';
import 'package:esp_socket/shared/notifications/notification-manager.dart';
import 'package:esp_socket/shared/notifications/notification-observer.dart';
import 'package:esp_socket/socket/custom-socket-wrapper.dart';
import 'package:esp_socket/socket/notification.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class DashViewModel extends ChangeNotifier implements NotificationObserver {
  late final AppNavigator navigator;

  late TextEditingController controller;
  late ScrollController scrollController;

  List<String> messages = [];

  @override
  late String id;

  late CustomSocketWrapper customSocketWrapper;
  MaterialColor dotColor = Colors.red;

  DashViewModel() {
    controller = TextEditingController();
    scrollController = ScrollController();
    id = "DashPageViewModel";
    navigator = Injector.appInstance.get<AppNavigator>();
    customSocketWrapper = Injector.appInstance.get<CustomSocketWrapper>();
    print("DashViewModel : CONSTRUCTOR() ");
    NotificationManager.instance.subscribe(this);
  }


  @override
  void update(SocketNotification notification) {
    print("DashViewModel : UPDATE ::: connectionEstablished=" + notification.connectionEstablished.toString());
      if (notification.connectionEstablished) {
        print("green");
        dotColor = Colors.green;
      } else {
        print("red");
        dotColor = Colors.red;
      }

      if(notification.msg !=  ""){
        messages.add(notification.msg);
        print("DashViewModel : UPDATE ::: messages" + messages.toString());
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
