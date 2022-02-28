// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final TextEditingController _debugInputController = TextEditingController();
//
//
//   final _channel = WebSocketChannel.connect(
//     Uri.parse('ws://192.168.43.121/ws'),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Home"),
//         ),
//         body: Column(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 ElevatedButton(
//                     onPressed: _toggleLed, child: const Text('Toggle')),
//                 ElevatedButton(
//                     onPressed: _toggleLed, child: const Text('Connect')),
//                 ElevatedButton(
//                     onPressed: _toggleLed, child: const Text('Disconnect')),
//               ],
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 ConstrainedBox(
//                   constraints: BoxConstraints.loose(Size(300, 50)),
//                   child: Form(
//                     child: TextFormField(
//                       controller: _debugInputController,
//                       decoration:
//                           const InputDecoration(labelText: 'Send a message'),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 50.0,
//                   child: ElevatedButton(
//                     onPressed: _sendMessage,
//                     child: const Icon(Icons.send),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ));
//   }
//
//   void _toggleLed() {
//     _channel.sink.add("toggle");
//   }
//
//   @override
//   void dispose() {
//     _channel.sink.close();
//     _debugInputController.dispose();
//     super.dispose();
//   }
//
//   void _sendMessage() {
//     if (_debugInputController.text.isNotEmpty) {
//       _channel.sink.add(_debugInputController.text);
//     }
//   }
// }
//
// void _toggleLed() {
//   print("toggle");
// }
