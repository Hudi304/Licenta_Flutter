import 'package:esp_socket/pages/dash/dash_page.dart';
import 'package:esp_socket/pages/fuel_table/fuel_table_page.dart';
import 'package:esp_socket/pages/ignition_table/ignition_table_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helpers/string.dart';

class AppNavigator {
  static AppNavigator? _instance;

  AppNavigator._();

  static AppNavigator get instance => _instance ??= AppNavigator._();

  //Page routes

  // goToUserDetails(int userId) => _goToPageWithArguments(UserDetailsPage.id, {
  //   ARG_ID: userId,
  // });
  //
  // void goToAdminPage(int userId) => _goToPageWithArguments(MyHomePage.id, {
  //       ARG_ID: userId,
  //     });

  void goToDashPage() => _goToPage(DashPage.id);

  void goToFuelTablePage() => _goToPage(FuelTablePage.id);

  void goToIgnitionTablePage() => _goToPage(IgnitionTablePage.id);

  // goToAddPage(AddType type, VoidCallback refresh) => _goToPageWithArguments(
  //     AddPage.id, {ARG_ADD_TYPE: type, ARG_REFRESH_CALLBACK: refresh});

  // void goToAssociationPage(dynamic parent, List<dynamic> items,
  //     AssociationType type, VoidCallback refresh) =>
  //     _goToPageWithArguments(AssociationPage.id, {
  //       ARG_ITEM_LIST: items,
  //       ARG_ASSOCIATION_TYPE: type,
  //       ARG_PARENT: parent,
  //       ARG_REFRESH_CALLBACK: refresh,
  //     });

  // void goToGraphsPage(int userId) => _goToPageWithArguments(GraphsPage.id, {
  //   ARG_USER_ID: userId,
  // });

  //Methods

  dynamic getArguments() => Get.arguments;

  _goToPage(String pageId) async => await Get.toNamed(pageId);

  goToPageWithCallback(String pageId, VoidCallback callback) async =>
      await Get.toNamed(pageId)?.then((_) {
        callback();
      });

  _goToPageWithArguments(String pageId, dynamic arguments) async =>
      await Get.toNamed(pageId, arguments: arguments);

  _clearNavigatorAndGoToPage(String pageId) => Get.offAllNamed(pageId);

  setCurrentRoute(String pageId) {
    Get.routing.current = pageId;
  }

  String getCurrentRoute() => Get.routing.current;

  showNotificationPopUp(String data) {
    Get.snackbar(Strings.exceedingRecording, "", messageText: Text(data));
  }

  goBack() => Get.back();

  // ARG Strings
  static const String ARG_ID = "userId";
  static const String ARG_USER_FIRST_NAME = "userFirstName";
  static const String ARG_USER_LAST_NAME = "userLastName";
  static const String ARG_ADD_TYPE = "addType";
  static const String ARG_REFRESH_CALLBACK = "refreshCallback";
  static const String ARG_ASSOCIATION_TYPE = "associationType";
  static const String ARG_ITEM_LIST = "itemList";
  static const String ARG_PARENT = "parent";
  static const String ARG_USER_ID = "userId";
}
