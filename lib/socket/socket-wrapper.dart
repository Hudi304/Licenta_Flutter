import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketsNotifications sockets = WebSocketsNotifications();

const String _SERVER_ADDRESS = 'ws://192.168.43.121/ws';

class WebSocketsNotifications {
  static final WebSocketsNotifications _sockets =
      WebSocketsNotifications._internal();

  factory WebSocketsNotifications() {
    return _sockets;
  }

  WebSocketsNotifications._internal();

  IOWebSocketChannel _channel;
  bool isOn = false;
  final ObserverList<Function> _listeners = ObserverList<Function>();

  // int close = _channel?.closeCode;

  initCommunication() async {
    reset();
    try {
      _channel = IOWebSocketChannel.connect(_SERVER_ADDRESS);
      // _channel = WebSocketChannel.connect(
      //   Uri.parse('wss://echo.websocket.org'),
      // );
      // print(" initCommunication : pingInterval : " +
      //     _channel.innerWebSocket.pingInterval.inSeconds.toString());
      // int close = _channel.innerWebSocket.closeCode;

      // print(close.toString());

      _channel.stream.listen(_onReceptionOfMessageFromServer
      //     , onDone: () {
      //   isOn = false;
      //   print("disconnected");
      // }, onError: () {
      //   print("onError");
      // }
      );
      print("CONNECTED");
    } catch (e) {
      print("FAILED : ");
    }
  }

  reset() {
    if (_channel != null) {
      if (_channel.sink != null) {
        _channel.sink.close();
        isOn = false;
      }
    }
  }

  send(String message) {
    if (_channel != null) {
      if (_channel.sink != null && isOn) {
        _channel.sink.add(message);
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
