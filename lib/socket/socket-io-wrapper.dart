import 'dart:io';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/foundation.dart';

class SocketIOWrapper {
  static const String _SERVER_ADDRESS = 'ws://192.168.43.121:80/ws';
  final ObserverList<Function> _listeners = ObserverList<Function>();

  late IO.Socket socket;

  initCommunication() async {}

  void onDisconnected() {}

  void tryConnect() {
    print("tryConnect");

    // socket = IO.io('ws://192.168.43.121', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    // });
    // socket = IO.io("https://192.168.43.121:80/ws"
    //     //     , <String, dynamic>{
    //     //   // 'transports': ['websocket'],
    //     //   'path' : "/"
    //     //   // 'autoConnect': false,
    //     // }
    //     );

    socket = IO.io("ws://192.168.43.121:80/ws", <String, dynamic>{
      'reconnectionAttempts': 5,
      'path': '/ws',
      'policyPort': 80,
      'rejectUnauthorized': false,
      'EIO': 2
    });

    socket.on("connection", (data) => print("connection : " + data.toString()));
    socket.onConnect((data) {
      print('connect : ' + data);
      socket.emit('msg', 'test');
      // print('connect');
      // socket.emitWithAck('msg', 'init', ack: (data) {
      //   print('ack $data') ;
      //   if (data != null) {
      //     print('from server $data');
      //   } else {
      //     print("Null") ;
      //   }
      // });
    });

    socket.on("connect", (data) => print("connect : " + data.toString()));
    socket.on(
        "connect_error", (data) => print("connect_error : " + data.toString()));
    socket.on("connect_timeout",
            (data) => print("connect_timeout : " + data.toString()));
    socket.on("connecting", (data) => print("connecting : " + data.toString()));
    socket.on("disconnect", (data) => print("disconnect : " + data.toString()));
    socket.on("error", (data) => print("error : " + data));

    socket.on("reconnect", (data) => print("reconnect : " + data.toString()));
    socket.on("reconnect_attempt",
            (data) => print("reconnect_attempt : " + data.toString()));
    socket.on("reconnect_failed",
            (data) => print("reconnect_failed : " + data.toString()));
    socket.on("reconnect_error",
            (data) => print("reconnect_error : " + data.toString()));
    socket.on(
        "reconnecting", (data) => print("reconnecting : " + data.toString()));

    socket.on("ping", (data) => print("ping : " + data.toString()));
    socket.on("pong", (data) => print("pong : " + data.toString()));

    socket.on('event', (data) => print("event : " + data.toString()));
    socket.on('fromServer', (data) => print("fromServer : " + data.toString()));

    socket.onDisconnect((_) => print('disconnect'));
  }

  getLostConnection() {}

  reset() {}

  send(String message) {}

  addListener(Function callback) {}

  removeListener(Function callback) {}

  _onReceptionOfMessageFromServer(message) {}
}
