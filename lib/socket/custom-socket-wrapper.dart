import 'dart:async';
import 'dart:io';
import 'package:esp_socket/shared/notifications/notification-manager.dart';

const String _SERVER_ADDRESS = 'ws://192.168.43.121:80/ws';
const Duration pingInterval = Duration(milliseconds: 200);

class CustomSocketWrapper {
  static CustomSocketWrapper? _instance;
  late bool connectionEstablished;
  WebSocket? socket;
  int? status;
  Timer? timer;
  dynamic socketStatus;
  bool connecting = true;

  CustomSocketWrapper._() {
    print("CONSTRUCTOR ");
    connectionEstablished = false;
    _tryConnect();
  }

  static CustomSocketWrapper get instance =>
      _instance ??= CustomSocketWrapper._();

  void _tryConnect() {
    print("tryConnect");
    if ((socket == null || status != null) && connecting) {
      WebSocket.connect(_SERVER_ADDRESS).then((ws) {
        connecting = false;
        socket = ws;
        socket?.pingInterval = pingInterval;
        status = socket?.closeCode;
        socket?.listen(
          onReceptionOfMessageFromServer,
          onDone: onDone,
          onError: (dynamic error) => onError(),
        );
        socket?.done.then((dynamic _) => onDone());
        connectionEstablished = true;
        notifySubscribers(true);
      }).catchError((onError) {
        print("connection attempt failed");
        _tryConnect();
      });
    } else {
      connecting = true;
    }
  }

  void onDone() {
    print("DISCONNECTED : ");
    connectionEstablished = false;
    socket = null;
    connecting = true;
    notifySubscribers(true);
    _tryConnect();
  }

  void onError() {
    print("ERROR : ");
    connectionEstablished = false;
    socket = null;
    connecting = true;
    notifySubscribers(true);
    _tryConnect();
  }

  void send(string) {
    print("send");
    print("" + (socket == null).toString());
    socket?.add("toggle");
  }

  void onReceptionOfMessageFromServer(message) {
    print("MESSAGE FROM SERVER : " + message);
  }

  notifySubscribers(bool areNotificationRead) {
    NotificationManager.instance.observers.forEach((e) {
      e.update(connectionEstablished);
    });
  }
}
