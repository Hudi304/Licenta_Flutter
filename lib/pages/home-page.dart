// import 'dart:async';
//
// import 'package:esp_socket/components/status-dot.dart';
// import 'package:esp_socket/home-page/home-page-grid.dart';
// import 'package:esp_socket/socket/socket-communication.dart';
// import 'package:esp_socket/socket/socket-wrapper.dart';
// import 'package:flutter/material.dart';
//
// // import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'dart:io';
// import 'package:web_socket_channel/io.dart';
// import 'package:websocket_manager/websocket_manager.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({required Key key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // final WebSocketChannel channel = IOWebSocketChannel.connect(
//   //   Uri.parse('ws://192.168.43.121/ws'),
//   // );
//
//   bool isWebsocketRunning = false;
//   int retryLimit = 3;
//
//   // Timer timer =
//   //     Timer.periodic(new Duration(seconds: 1), (timer) => {
//   //       // game.send("ping")
//   //       print(sockets)
//   //     });
//
//   // int closeCode =
//
//   @override
//   void initState() {
//     super.initState();
//     game.addListener(onDataRecieved);
//   }
//
//   onDataRecieved(String message) {
//     print("HomePage : " + message);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home"),
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           StatusDot(sockets.isOn ? Colors.green : Colors.red, key: UniqueKey()),
//           // HomePageGrid(_channel),
//           ElevatedButton(
//             onPressed: _toggleLed,
//             child: const Icon(Icons.send),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _toggleLed() {
//     // channel.sink.add("toggle");
//   }
// }
