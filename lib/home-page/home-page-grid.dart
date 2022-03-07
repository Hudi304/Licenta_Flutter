import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePageGrid extends StatefulWidget {
  var channel;

  HomePageGrid(this.channel, {required Key key}) : super(key: key);

  @override
  _HomePageGridState createState() => _HomePageGridState();

  void toggleLed() {
    channel.sink.add("toggle");
  }


}

class _HomePageGridState extends State<HomePageGrid> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(double.infinity),
                ),
                onPressed: () => widget.toggleLed(),
                child: const Icon(Icons.send),
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(double.infinity),
                ),
                onPressed: _sendMessage,
                child: const Icon(Icons.tune),
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(double.infinity),
                ),
                onPressed: _sendMessage,
                child: const Icon(Icons.access_alarm),
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(double.infinity),
                ),
                onPressed: _sendMessage,
                child: const Icon(Icons.account_tree_outlined),
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(double.infinity),
                ),
                onPressed: _sendMessage,
                child: const Icon(Icons.access_alarm),
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(double.infinity),
                ),
                onPressed: _sendMessage,
                child: const Icon(Icons.account_tree_outlined),
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(double.infinity),
                ),
                onPressed: _sendMessage,
                child: const Icon(Icons.access_alarm),
              )),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(double.infinity),
                ),
                onPressed: _sendMessage,
                child: const Icon(Icons.account_tree_outlined),
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _sendMessage() {}
}
