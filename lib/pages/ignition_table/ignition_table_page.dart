import 'package:esp_socket/pages/home/home_view_model.dart';
import 'package:esp_socket/pages/ignition_table/ignition_table_view_model.dart';
import 'package:esp_socket/shared/helpers/dimentions.dart';
import 'package:esp_socket/shared/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IgnitionTablePage extends StatelessWidget {
  static const String id = "IgnitionTablePage";

  @override
  Widget build(BuildContext context) {
    return Consumer<IgnitionTableViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        body: _body(viewModel),
      );
    });
  }

  _body(IgnitionTableViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.padding16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "IgnitionTablePage",
          ),
        ],
      ),
    );
  }
}
