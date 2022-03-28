import 'package:esp_socket/pages/dash/dash_page.dart';
import 'package:esp_socket/pages/dash/dash_view_model.dart';
import 'package:esp_socket/pages/fuel_table/fuel_table_page.dart';
import 'package:esp_socket/pages/fuel_table/fuel_table_view_model.dart';
import 'package:esp_socket/pages/home/home_page.dart';
import 'package:esp_socket/pages/home/home_view_model.dart';
import 'package:esp_socket/pages/ignition_table/ignition_table_page.dart';
import 'package:esp_socket/pages/ignition_table/ignition_table_view_model.dart';
import 'package:esp_socket/shared/app_navigator.dart';
import 'package:esp_socket/shared/helpers/pallet.dart';
import 'package:esp_socket/shared/helpers/string.dart';
import 'package:esp_socket/shared/notifications/notification-manager.dart';
import 'package:esp_socket/socket/custom-socket-wrapper.dart';
import 'package:esp_socket/socket/socket-communication.dart';
import 'package:esp_socket/socket/socket-io-wrapper.dart';
import 'package:esp_socket/socket/socket-wrapper.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  _initInjection();

  runApp(
    MultiProvider(
      providers: _getProvidersArray,
      child: MyApp(),
    ),
  );
}

List<SingleChildWidget> get _getProvidersArray {
  return [
    ChangeNotifierProvider(create: (_) => HomePageViewModel()),
    ChangeNotifierProvider(create: (_) => DashViewModel()),
    ChangeNotifierProvider(create: (_) => IgnitionTableViewModel()),
    ChangeNotifierProvider(create: (_) => FuelTableViewModel()),
  ];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
      theme: ThemeData(
          buttonTheme: const ButtonThemeData(buttonColor: Colors.blueAccent),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Palette.lightBlue),
      home: HomePage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        DashPage.id: (context) => DashPage(),
        FuelTablePage.id: (context) => FuelTablePage(),
        IgnitionTablePage.id: (context) => IgnitionTablePage(),
      },
    );
  }
}

_initInjection() {
  Injector injector = Injector.appInstance;
  injector.registerDependency<AppNavigator>(() => AppNavigator.instance);
  injector.registerDependency<CustomSocketWrapper>(() => CustomSocketWrapper.instance);
  injector.registerDependency<SocketIOWrapper>(() => SocketIOWrapper());
  injector.registerDependency<NotificationManager>(() => NotificationManager());
  // injector.registerDependency<SocketCommunication>(() => SocketCommunication());
  // injector.registerDependency<WebSocketsNotifications>(() => WebSocketsNotifications());
}
