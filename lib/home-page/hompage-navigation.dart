import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePageNav extends StatefulWidget {
  const HomePageNav({
    required Key key,
  }) : super(key: key);

  @override
  _HomePageNavState createState() => _HomePageNavState();
}

class _HomePageNavState extends State<HomePageNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Container(
          // color: Colors.red,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _sendMessage,
                          child: Icon(Icons.send),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                        child: ElevatedButton(
                          onPressed: _sendMessage,
                          child: Icon(Icons.tune),
                        ),
                      ))
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _sendMessage,
                          child: Icon(Icons.access_alarm),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                        child: ElevatedButton(
                          onPressed: _sendMessage,
                          child: Icon(Icons.add_alarm_rounded),
                        ),
                      ))
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _sendMessage,
                          child: Icon(Icons.account_tree_outlined),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                        child: ElevatedButton(
                          onPressed: _sendMessage,
                          child: Icon(Icons.assessment),
                        ),
                      ))
                    ],
                  )),
            ],
          ),
        ));
  }

  void _toggleLed() {
    print("toggle");
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _sendMessage() {}
}
