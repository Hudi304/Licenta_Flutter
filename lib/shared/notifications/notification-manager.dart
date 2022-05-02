import 'package:esp_socket/socket/notification.dart';

import 'notification-observer.dart';

class NotificationManager {
  static NotificationManager? _instance;

  late List<NotificationObserver> observers;
  late bool _areAllNotificationsRead;

  NotificationManager() {
    observers = [];
    _areAllNotificationsRead = true;
  }

  static NotificationManager get instance =>
      _instance ??= NotificationManager();

  bool get areNotificationsRead => _areAllNotificationsRead;

  subscribe(NotificationObserver observer) {
    observers.add(observer);
  }

  unsubscribe(NotificationObserver observer) {
    observers.removeWhere((e) => e.id == observer.id);
  }

  notifySubscribers(SocketNotification notification) {
    _areAllNotificationsRead = notification.connectionEstablished;
    observers.forEach((e) {
      e.update(notification);
    });
  }
}