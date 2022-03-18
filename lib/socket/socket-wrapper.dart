import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketsNotifications {
  static const String _SERVER_ADDRESS = 'ws://192.168.43.121/ws';

  WebSocketsNotifications();

  IOWebSocketChannel? _channel;

  WebSocket? socket;

  bool isOn = false;
  bool lostConnection = true;
  bool tryConnect = false;

  final ObserverList<Function> _listeners = ObserverList<Function>();

  initCommunication() async {
    reset();
    try {
      _tryConnect();
      isOn = true;
    } catch (e) {
      print("FAILED : ");
    }
  }

  void onDisconnected() {
    print('Disconnected');
    if (socket != null) {
      socket?.close();
    }
    socket = null;
    if (tryConnect == false) {
      _tryConnect();
    }
  }

  void _tryConnect() {
    tryConnect = true;
    print("_tryConnect");

    WebSocket.connect(_SERVER_ADDRESS).then((ws) {
      socket = ws;
      socket?.listen(
        _onReceptionOfMessageFromServer,
        onDone: onDisconnected,
        onError: (dynamic error) => onDisconnected(),
      );
      socket?.done.then((dynamic _) => onDisconnected());
      lostConnection = false;
      print("connected");
      tryConnect = false;
    }).catchError((onError) {
      lostConnection = true;
      print("catchError");
      tryConnect = false;
    });
  }

  getLostConnection() {
    return lostConnection;
  }

  reset() {
    if (_channel != null) {
      if (_channel?.sink != null) {
        _channel?.sink.close();
        isOn = false;
      }
    }
  }

  send(String message) {
    print("sending : " + message);
    if (socket != null) {
      socket?.add(message);
    }
  }

  addListener(Function callback) {
    _listeners.add(callback);
  }

  removeListener(Function callback) {
    _listeners.remove(callback);
  }

  _onReceptionOfMessageFromServer(message) {
    isOn = true;
    lostConnection = false;
    _listeners.forEach((Function callback) {
      callback(message);
    });
  }
}
