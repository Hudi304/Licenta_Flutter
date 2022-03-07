import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketsNotifications {
  static const String _SERVER_ADDRESS = 'ws://192.168.43.121/ws';

  WebSocketsNotifications();

  IOWebSocketChannel? _channel;
  bool isOn = false;
  final ObserverList<Function> _listeners = ObserverList<Function>();

  // WebSocket? socket;
  //
  // WebSocket socket;
  //
  // void _onDisconnected() {
  //   print('Disconnected');
  //   if (socket != null) {
  //     socket.close();
  //   }
  //   socket = null;
  //   _tryConnect();
  // }
  //
  // void _tryConnect() {
  //   WebSocket.connect(url).then((ws) {
  //     socekt = ws;
  //     socket.listen(
  //           (dynamic message) {
  //         print(message)
  //       },
  //       onDone: _onDisconnected,
  //       onError: (dynamic error) => _onDisconnected(),
  //     );
  //     socket.done.then((dynamic _) => _onDisconnected());
  //   });
  // }


  initCommunication() async {
    reset();
    try {
      _channel = IOWebSocketChannel.connect(_SERVER_ADDRESS);
      _channel?.innerWebSocket?.pingInterval = const Duration(seconds: 1);
      int? readySate = _channel?.innerWebSocket?.readyState;
      print("ready state : " + readySate.toString());


      _channel?.stream.listen(
        _onReceptionOfMessageFromServer,
        onDone: () => print("disconnected"),
        onError: (_) => print("onError"),
      );
      print("CONNECTED");
      isOn = true;
    } catch (e) {
      print("FAILED : ");
    }
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
    if (_channel != null) {
      if (_channel?.sink != null && isOn) {
        _channel?.sink.add(message);
      }
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
    _listeners.forEach((Function callback) {
      callback(message);
    });
  }
}
