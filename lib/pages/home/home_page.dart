import 'package:esp_socket/pages/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String id = "LoginPage";

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: _body(viewModel),
      );
    });
  }

  _body(HomePageViewModel viewModel) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            // color: viewModel.game.color,
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () => viewModel.onLoginTapped(),
              child: const Icon(Icons.access_alarm),
            )),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () => viewModel.onFuelTapped(),
              child: const Icon(Icons.local_gas_station),
            )),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () => viewModel.onIgnitionTapped(),
              child: const Icon(Icons.local_fire_department),
            )),
      ],
    );
  }
}
