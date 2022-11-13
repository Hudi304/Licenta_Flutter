import 'dart:async';
import 'dart:io';
import 'package:esp_socket/shared/notifications/notification-manager.dart';
import 'package:esp_socket/socket/notification.dart';
import 'dart:typed_data';

// const String _SERVER_ADDRESS = 'ws://192.168.43.246:80/ws';
const String _SERVER_ADDRESS = 'ws://192.168.0.130:80/ws';

const Duration pingInterval = Duration(milliseconds: 500);

class CustomSocketWrapper {
  static CustomSocketWrapper? _instance;
  late bool connectionEstablished;
  WebSocket? socket;
  int? status;
  int msgNo = 0;
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
      connecting = false;
      WebSocket.connect(_SERVER_ADDRESS).then((ws) {
        // connecting = false;
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
        notifySubscribers(SocketNotification(true, ""));
      }).catchError((onError) {
        connecting = true;
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
    notifySubscribers(SocketNotification(connectionEstablished, ""));
    _tryConnect();
  }

  void onError() {
    print("CustomSocketWrapper : ERROR");
    connectionEstablished = false;
    socket = null;
    connecting = true;
    notifySubscribers(SocketNotification(connectionEstablished, ""));
    // _tryConnect();
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

    Uint8List byteBuff =  message;

      // print("CustomSocketWrapper : MESSAGE FROM SERVER : " + byteBuff.length.toString());
      // print("CustomSocketWrapper : MESSAGE FROM SERVER : " + byteBuff.lengthInBytes.toString());

     var iter = byteBuff.iterator;

     String full = "";

    full = "[" + msgNo.toString() + "]:";

     while(iter.moveNext()){
      // print( iter.current.toUnsigned(8).toString());
      full = full + iter.current.toUnsigned(8).toString()+ "|";
     }

     print(full);

    // print("CustomSocketWrapper : MESSAGE FROM SERVER : " + byteBuff.);


      notifySubscribers(SocketNotification(connectionEstablished, full));
    msgNo++;
  }

  notifySubscribers(SocketNotification notification) {
    NotificationManager.instance.observers.forEach((e) {
      e.update(notification);
    });
  }
}
