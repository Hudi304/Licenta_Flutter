import 'package:esp_socket/pages/dash/dash_view_model.dart';
import 'package:esp_socket/shared/helpers/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashPage extends StatelessWidget {
  static const String id = "DashPage";

  @override
  Widget build(BuildContext context) {
    return Consumer<DashViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        body: _body(viewModel),
      );
    });
  }

  _body(DashViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.padding16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [Text("Dash Page")],
      ),
    );
  }
}
