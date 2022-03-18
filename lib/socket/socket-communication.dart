import 'dart:async';

import 'package:esp_socket/socket/socket-wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class SocketCommunication {
  late final WebSocketsNotifications sockets;
  bool lostConnection = true;
  Timer? timer;
  VoidCallback? refresh;

  //
  static SocketCommunication? _instance;

  SocketCommunication._();

  MaterialColor color = Colors.red;

  bool conected = false;

  SocketCommunication() {
    sockets = Injector.appInstance.get<WebSocketsNotifications>();
    sockets.initCommunication();
    sockets.addListener(_onMessageReceived);

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (lostConnection) {
        print("in timer lost connection");
        sockets.onDisconnected();
        color = Colors.red;
        conected = false;
      } else {
        lostConnection = true;
      }
      // refresh!();
      print("lostConnection : " + lostConnection.toString());
      // notifyListeners();
    });
  }

  _onMessageReceived(serverMessage) {
    lostConnection = false;
    conected = true;
    color = Colors.green;
    print("_onMessageReceived : |" + serverMessage + "|");

    if (serverMessage == "connected") {
      print("in if Connected");
    }
    _listeners.forEach((Function callback) {
      callback(serverMessage);
    });
  }

  setRefresh(VoidCallback cb) {
    refresh = cb;
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
