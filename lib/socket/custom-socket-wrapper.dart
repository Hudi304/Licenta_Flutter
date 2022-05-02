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
    print("CustomSocketWrapper : CONSTRUCTOR() ");
    connectionEstablished = false;
    _tryConnect();
  }

  static CustomSocketWrapper get instance =>
      _instance ??= CustomSocketWrapper._();

  void _tryConnect() {
    print("CustomSocketWrapper : tryConnect()");
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
        //todo check if this is important
        socket?.done.then((dynamic _) => onDone());
        connectionEstablished = true;
        notifySubscribers(true);
      }).catchError((onError) {
        print("CustomSocketWrapper : connection attempt failed");
        _tryConnect();
      });
    } else {
      connecting = true;
    }
  }

  void onDone() {
    print("CustomSocketWrapper : DISCONNECTED");
    connectionEstablished = false;
    socket = null;
    connecting = true;
    notifySubscribers(true);
    _tryConnect();
  }

  void onError() {
    print("CustomSocketWrapper : ERROR");
    connectionEstablished = false;
    socket = null;
    connecting = true;
    notifySubscribers(true);
    _tryConnect();
  }

  void send(String string) {
    print("CustomSocketWrapper : send() : " + string);
    socket?.add(string);
  }

  void sendUTF8(List<int> bytes) {
    print("CustomSocketWrapper : sendUTF8() : " + bytes.toString());
    socket?.addUtf8Text(bytes);
  }

  void onReceptionOfMessageFromServer(message) {
    print("CustomSocketWrapper : MESSAGE FROM SERVER : " + message);
  }

  notifySubscribers(bool areNotificationRead) {
    NotificationManager.instance.observers.forEach((e) {
      e.update(connectionEstablished);
    });
  }
}
