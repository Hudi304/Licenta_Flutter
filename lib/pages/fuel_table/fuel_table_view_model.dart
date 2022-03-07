import 'package:esp_socket/shared/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';

class FuelTableViewModel extends ChangeNotifier {
  late final AppNavigator navigator;

  FuelTableViewModel() {
    navigator = Injector.appInstance.get<AppNavigator>();
  }
}
