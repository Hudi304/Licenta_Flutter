import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StatusDot extends StatefulWidget {
  MaterialColor color;

  StatusDot(this.color, {required Key key}) : super(key: key);

  @override
  _StatusDotState createState() => _StatusDotState();
}

class _StatusDotState extends State<StatusDot> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: widget.color,
        shape: BoxShape.circle,
      ),
    );
  }
}

// class StatusDot extends StatefulWidget {
//   var channel;
//
//   StatusDot(this.channel, {Key key}) : super(key: key);
//
//   @override
//   _StatusDotState createState() => _StatusDotState();
// }
//
// class _StatusDotState extends State<StatusDot> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       width: 20.0,
//       height: 20.0,
//       decoration: BoxDecoration(
//         color: Colors.red,
//         shape: BoxShape.circle,
//       ),
//     );
//   }
// }
