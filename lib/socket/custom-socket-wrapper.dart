import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

const String _SERVER_ADDRESS = 'ws://192.168.43.121:80/ws';
const Duration pingInterval = Duration(milliseconds: 100);

class CustomSocketWrapper extends ChangeNotifier {
  static CustomSocketWrapper? _instance;
  WebSocket? socket;
  int? status;
  Timer? timer;
  dynamic socketStatus;

  bool connecting = true;

  static CustomSocketWrapper get instance =>
      _instance ??= CustomSocketWrapper();

  void onDisconnected() {
    print("DISCONNECTED : ");
    notifyListeners();
    socket = null;
    connecting = true;
    tryConnect();
  }

  void tryConnect() {
    print("tryConnect");
    if ((socket == null || status != null) && connecting) {
      WebSocket.connect(_SERVER_ADDRESS).then((ws) {
        socket = ws;
        socket?.pingInterval = pingInterval;
        status = socket?.closeCode;
        socket?.listen(
          onReceptionOfMessageFromServer,
          onDone: onDisconnected,
          onError: (dynamic error) => onDisconnected(),
        );
        socket?.done.then((dynamic _) => onDisconnected());
        connecting = false;
      }).catchError((onError) {
        print("connection attempt failed");
        tryConnect();
      });
    } else {
      connecting = true;
    }
  }

  void onReceptionOfMessageFromServer(message) {
    print("MESSAGE FROM SERVER : " + message);
  }
}
