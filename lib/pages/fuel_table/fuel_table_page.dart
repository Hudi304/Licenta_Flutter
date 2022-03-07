import 'package:esp_socket/pages/fuel_table/fuel_table_view_model.dart';
import 'package:esp_socket/pages/home/home_view_model.dart';
import 'package:esp_socket/shared/helpers/dimentions.dart';
import 'package:esp_socket/shared/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FuelTablePage extends StatelessWidget {
  static const String id = "FuelTablePage";

  @override
  Widget build(BuildContext context) {
    return Consumer<FuelTableViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        body: _body(viewModel),
      );
    });
  }

  _body(FuelTableViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.padding16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "FuelTablePage",
          ),
        ],
      ),
    );
  }
}
