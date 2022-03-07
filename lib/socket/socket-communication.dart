import 'package:esp_socket/socket/socket-wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';

class SocketCommunication {
  late final WebSocketsNotifications sockets;

  SocketCommunication() {
    sockets = Injector.appInstance.get<WebSocketsNotifications>();
    sockets.initCommunication();
    sockets.addListener(_onMessageReceived);
  }

  _onMessageReceived(serverMessage) {
    print(serverMessage);

    if (serverMessage == "connected") {
      print("in if Connected");
    }
    _listeners.forEach((Function callback) {
      callback(serverMessage);
    });
  }

  send(String data) {
    sockets.send(data);
  }

  ObserverList<Function> _listeners = new ObserverList<Function>();

  addListener(Function callback) {
    _listeners.add(callback);
  }

  removeListener(Function callback) {
    _listeners.remove(callback);
  }
}
