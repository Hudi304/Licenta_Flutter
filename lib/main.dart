import 'dart:convert';

import 'package:esp_socket/home-page/home-page-grid.dart';
import 'package:esp_socket/pages/dash/dash_page.dart';
import 'package:esp_socket/pages/dash/dash_view_model.dart';
import 'package:esp_socket/pages/fuel_table/fuel_table_page.dart';
import 'package:esp_socket/pages/fuel_table/fuel_table_view_model.dart';
import 'package:esp_socket/pages/home-page.dart';
import 'package:esp_socket/pages/home/home_page.dart';
import 'package:esp_socket/pages/home/home_view_model.dart';
import 'package:esp_socket/pages/ignition_table/ignition_table_page.dart';
import 'package:esp_socket/pages/ignition_table/ignition_table_view_model.dart';
import 'package:esp_socket/shared/app_navigator.dart';
import 'package:esp_socket/shared/helpers/pallet.dart';
import 'package:esp_socket/shared/helpers/string.dart';
import 'package:esp_socket/socket/socket-communication.dart';
import 'package:esp_socket/socket/socket-wrapper.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// import 'home-page/home-page.dart';
import 'home-page/hompage-navigation.dart';
import 'home-page/home-page-grid.dart';

// import 'package:adhara_socket_io/adhara_socket_io.dart';
//TODO try catch on socket connection coz it crashes the app




//TODO Tudor's main
Future<void> main() async {
  _initInjection();

  runApp(
    MultiProvider(
      providers: _getProvidersArray,
      child: MyApp(),
    ),
  );
}

List<SingleChildWidget> get _getProvidersArray {
  return [
    ChangeNotifierProvider(create: (_) => LoginViewModel()),
    ChangeNotifierProvider(create: (_) => DashViewModel()),
    ChangeNotifierProvider(create: (_) => IgnitionTableViewModel()),
    ChangeNotifierProvider(create: (_) => FuelTableViewModel()),
  ];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
      theme: ThemeData(
          buttonTheme: const ButtonThemeData(buttonColor: Colors.blueAccent),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Palette.lightBlue),
      home: LoginPage(),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        DashPage.id: (context) => DashPage(),
        FuelTablePage.id: (context) => FuelTablePage(),
        IgnitionTablePage.id: (context) => IgnitionTablePage(),
      },
    );
  }
}

_initInjection() {
  Injector injector = Injector.appInstance;
  injector.registerDependency<AppNavigator>(() => AppNavigator.instance);
  injector.registerDependency<SocketCommunication>(() => SocketCommunication());
  injector.registerDependency<WebSocketsNotifications>(() => WebSocketsNotifications());

}

//TODO Socket Client with the WebSocketChannel wrapper
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     const title = 'WebSocket Demo';
//     return const MaterialApp(
//       title: title,
//       // home: HomePageNav(),
//       home: HomePage(),
//     );
//   }
// }

//TODO ---------- Socket Client implementation

// const uri = 'http://192.168.0.105:7070/';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   List<String> toPrint = ['trying to connect'];
//    SocketIOManager manager;
//   Map<String, SocketIO> sockets = {};
//   final _isProbablyConnected = <String, bool>{};
//   final ScrollController _scrollController = ScrollController();
//
//   List get messagesToPublish => null;
//
//   @override
//   void initState() {
//     super.initState();
//     manager = SocketIOManager();
//     initSocket('default');
//   }
//
//   Future<void> initSocket(String identifier) async {
//     setState(() => _isProbablyConnected[identifier] = true);
//     final socket = await manager.createInstance(SocketOptions(
//       uri,
//       namespace: (identifier == 'namespaced') ? '/adhara' : '/',
//       query: {
//         'auth': '--SOME AUTH STRING---',
//         'info': 'new connection from adhara-socketio',
//         'timestamp': DateTime.now().toString()
//       },
//       enableLogging: true,
//       transports: [
//         Transports.webSocket,
//       ],
//     ));
//
//     socket.onConnect.listen((data) {
//       pPrint('$identifier | connected...');
//       pPrint(data);
//       sendMessage(identifier);
//     });
//     socket.onConnectError.listen((data) => pPrint('onConnectError'));
//     socket.onConnectTimeout.listen((data) => pPrint('onConnectTimeout'));
//     socket.onError.listen((data) => pPrint('onError'));
//     socket.onDisconnect.listen((data) => pPrint('onDisconnect'));
//     socket
//         .on('type:string')
//         .listen((data) => pPrint('$identifier | type:string... | $data'));
//     socket
//         .on('type:bool')
//         .listen((data) => pPrint('$identifier | type:bool | $data'));
//     socket
//         .on('type:number')
//         .listen((data) => pPrint('$identifier | type:number | $data'));
//     socket
//         .on('type:object')
//         .listen((data) => pPrint('$identifier | type:object | $data'));
//     socket
//         .on('type:list')
//         .listen((data) => pPrint('$identifier | type:list | $data'));
//     socket
//         .on('message')
//         .listen((data) => pPrint('$identifier | type:string... | $data'));
//     socket.on('echo').listen((data) =>
//         pPrint('$identifier | echo received | ${data.length} | $data'));
//     socket
//         .on('namespace')
//         .listen((data) => pPrint('$identifier | namespace: | $data'));
//     //TODO add stream subscription in example
//     await socket.connect();
//     sockets[identifier] = socket;
//   }
//
//   bool isProbablyConnected(String identifier) =>
//       _isProbablyConnected[identifier] ?? false;
//
//   Future<void> disconnect(String identifier) async {
//     await manager.clearInstance(sockets[identifier]);
//     setState(() => _isProbablyConnected[identifier] = false);
//   }
//
//   void sendMessage(String identifier) {
//     if (sockets[identifier] != null) {
//       pPrint("sending message from '$identifier'...");
//       sockets[identifier]?.emit('data', messagesToPublish);
//       pPrint("Message emitted from '$identifier'...");
//     }
//   }
//
//   Future<void> sendEchoMessage(String identifier) async {
//     if (sockets[identifier] != null) {
//       for (final message in messagesToPublish) {
//         pPrint('publishing echo message $message');
//         await sockets[identifier]?.emit('echo', [message]);
//       }
//       pPrint('publishing echo message ${messagesToPublish?.last}');
//       await sockets[identifier]?.emit('echo', messagesToPublish?.last as List);
//     }
//   }
//
//   void sendMessageWithACK(String identifier) {
//     pPrint('$identifier | Sending ACK message...');
//     final msg = [
//       'Hello world!',
//       1,
//       true,
//       {'p': 1},
//       [3, 'r']
//     ];
//     sockets[identifier]?.emitWithAck('ack-message', msg).then((data) {
//       pPrint('$identifier | ACK received | $msg -> $data');
//     });
//   }
//
//   void pPrint(Object data) {
//     setState(() {
//       if (data is Map) {
//         data = json.encode(data);
//       }
//       print(data);
//       toPrint.add(data.toString());
//     });
//
//     Future.delayed(const Duration(milliseconds: 250), () {
//       _scrollController.animateTo(_scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
//     });
//   }
//
//   Widget getButtonSet(String identifier) {
//     final ipc = isProbablyConnected(identifier);
//     return SizedBox(
//       height: 60,
//       child: Container(
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: <Widget>[
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8),
//               child: ElevatedButton(
//                 onPressed: ipc ? null : () => initSocket(identifier),
//                 style: ButtonStyle(
//                   padding: MaterialStateProperty.resolveWith(
//                     (states) => const EdgeInsets.symmetric(horizontal: 8),
//                   ),
//                 ),
//                 child: const Text('Connect'),
//               ),
//             ),
//             Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 child: ElevatedButton(
//                   onPressed: ipc ? () => sendMessage(identifier) : null,
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.resolveWith(
//                       (states) => const EdgeInsets.symmetric(horizontal: 8),
//                     ),
//                   ),
//                   child: const Text('Send Message'),
//                 )),
//             Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 child: ElevatedButton(
//                   onPressed: ipc ? () => sendEchoMessage(identifier) : null,
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.resolveWith(
//                       (states) => const EdgeInsets.symmetric(horizontal: 8),
//                     ),
//                   ),
//                   child: const Text('Send Echo Message'),
//                 )),
//             Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 child: ElevatedButton(
//                   onPressed: ipc ? () => sendMessageWithACK(identifier) : null,
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.resolveWith(
//                       (states) => const EdgeInsets.symmetric(horizontal: 8),
//                     ),
//                   ),
//                   child: const Text('Send w/ ACK'), //Send message with ACK
//                 )),
//             Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 child: ElevatedButton(
//                   onPressed: ipc ? () => disconnect(identifier) : null,
//                   style: ButtonStyle(
//                     padding: MaterialStateProperty.resolveWith(
//                       (states) => const EdgeInsets.symmetric(horizontal: 8),
//                     ),
//                   ),
//                   child: const Text('Disconnect'),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//             textTheme: const TextTheme(
//               headline6: TextStyle(color: Colors.white),
//               headline5: TextStyle(color: Colors.white),
//               subtitle2: TextStyle(color: Colors.white),
//               subtitle1: TextStyle(color: Colors.white),
//               bodyText2: TextStyle(color: Colors.white),
//               bodyText1: TextStyle(color: Colors.white),
//               button: TextStyle(color: Colors.white),
//               caption: TextStyle(color: Colors.white),
//               overline: TextStyle(color: Colors.white),
//               headline4: TextStyle(color: Colors.white),
//               headline3: TextStyle(color: Colors.white),
//               headline2: TextStyle(color: Colors.white),
//               headline1: TextStyle(color: Colors.white),
//             ),
//             buttonTheme: ButtonThemeData(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
//                 disabledColor: Colors.lightBlueAccent.withOpacity(0.5),
//                 buttonColor: Colors.lightBlue,
//                 splashColor: Colors.cyan)),
//         home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Adhara Socket.IO example'),
//             backgroundColor: Colors.black,
//             elevation: 0,
//             actions: [
//               IconButton(
//                   icon: const Icon(Icons.delete),
//                   onPressed: () {
//                     setState(() {
//                       toPrint = [];
//                     });
//                   })
//             ],
//           ),
//           body: Container(
//             color: Colors.black,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Expanded(
//                     child: Center(
//                   child: ListView(
//                     controller: _scrollController,
//                     children: toPrint.map((_) => Text(_ ?? '')).toList(),
//                   ),
//                 )),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 8, bottom: 8),
//                   child: Text(
//                     'Default Connection',
//                   ),
//                 ),
//                 getButtonSet('default'),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 8, bottom: 8, top: 8),
//                   child: Text(
//                     'Alternate Connection',
//                   ),
//                 ),
//                 getButtonSet('alternate'),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 8, bottom: 8, top: 8),
//                   child: Text(
//                     'Namespace Connection',
//                   ),
//                 ),
//                 getButtonSet('namespaced'),
//                 const SizedBox(
//                   height: 12,
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
// }
