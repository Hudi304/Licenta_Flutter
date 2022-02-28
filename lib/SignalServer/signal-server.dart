// import 'package:adhara_socket_io/manager.dart';
// import 'package:adhara_socket_io/options.dart';
// import 'package:adhara_socket_io/socket.dart';
//
// const uri = 'http://192.168.0.105:7070/';
//
// class SignalServer {
//   late SignalServer _instance;
//
//   factory SignalServer() => _instance ?? new SignalServer._();
//
//   SignalServer._();
//
//   SocketIO socketIO;
//   int State = 0;
//
//   void ConnectServer() async {
//     this.socketIO =
//     await SocketIOManager().createInstance(SocketOptions(
//       //Socket IO server URI
//       uri,
//       namespace: (identifier == 'namespaced') ? '/adhara' : '/',
//       //Query params - can be used for authentication
//       query: {
//         'auth': '--SOME AUTH STRING---',
//         'info': 'new connection from adhara-socketio',
//         'timestamp': DateTime.now().toString()
//       },
//       //Enable or disable platform channel logging
//       enableLogging: true,
//       transports: [
//         Transports.webSocket,
//         // Transports.polling,
//       ], //Enable required transport
//     ));
//     socketIO.onConnect((data) {
//       print("Signal server connected");
//       State = 1;
//     });
//     socketIO.onDisconnect((_) {
//       print("Signal Disconnected");
//       State = 0;
//     });
//     socketIO.connect();
//   }
//
//
