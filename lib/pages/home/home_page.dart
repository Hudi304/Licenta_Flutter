import 'package:esp_socket/pages/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String id = "LoginPage";

  @override
  Widget build(BuildContext context) {
    print("HomePage : build() ");
    return Consumer<HomePageViewModel>(builder: (context, viewModel, child) {
      return _body(viewModel);
    });
  }

  _body(HomePageViewModel viewModel) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Home"),
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
        body: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
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
        ));
  }
}
