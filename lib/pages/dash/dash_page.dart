import 'package:esp_socket/pages/dash/dash_view_model.dart';
import 'package:esp_socket/shared/helpers/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashPage extends StatelessWidget {
  static const String id = "DashPage";

  @override
  Widget build(BuildContext context) {
    print("DashPage : build() ");
    return Consumer<DashViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        body: _body(viewModel, context),
      );
    });
  }

  _body(DashViewModel viewModel, BuildContext context) {
    List<Widget> getMessages() {
      List<Widget> widgetList = List.generate(
          1000,
          (index) => Text(
                "msg " + index.toString(),
                style: const TextStyle(color: Colors.white),
              ));
      return widgetList;
    }

    List<Widget> stringToWidgets() {
      List<Widget> widgetList = [];
      // widgetList.

      // print("-------------------------------" + viewModel.messages.toString());

      viewModel.messages.forEach((msg) {
        widgetList.add(Text(msg, style: const TextStyle(color: Colors.white)));
      });

      viewModel.scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );

      return List.from(widgetList.reversed);
      // return widgetList;
    }

    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Control Page",
            ),
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: viewModel.dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.padding6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 35.0,
                    maxHeight: 300.0,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.padding12))),
                    padding: const EdgeInsets.all(Dimensions.padding16),
                    child: ListView(
                      reverse: true,
                      shrinkWrap: true,
                      controller: viewModel.scrollController,
                      // children: getMessages(),
                      children: stringToWidgets(),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: viewModel.controller,
                  )),
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: () => viewModel.onClear(),
                    child: const Text("Clear"),
                  ),
                  ElevatedButton(
                    onPressed: () => viewModel.onToggleTapped(),
                    child: const Text("Toggle"),
                  ),
                  ElevatedButton(
                    onPressed: () => viewModel.onSend(),
                    child: const Text("Send"),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
