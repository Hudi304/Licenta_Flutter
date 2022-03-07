import 'package:esp_socket/shared/app_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';

class IgnitionTableViewModel extends ChangeNotifier {
  late final AppNavigator navigator;

  IgnitionTableViewModel() {
    navigator = Injector.appInstance.get<AppNavigator>();
  }
}
