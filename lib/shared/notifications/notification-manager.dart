import 'notification-observer.dart';

class NotificationManager {
  static NotificationManager? _instance;

  late List<NotificationObserver> _observers;
  late bool _areAllNotificationsRead;

  NotificationManager() {
    _observers = [];
    _areAllNotificationsRead = true;
  }

  static NotificationManager get instance =>
      _instance ??= NotificationManager();

  bool get areNotificationsRead => _areAllNotificationsRead;

  subscribe(NotificationObserver observer) {
    _observers.add(observer);
  }

  unsubscribe(NotificationObserver observer) {
    _observers.removeWhere((e) => e.id == observer.id);
  }

  notifySubscribers(bool areNotificationRead) {
    _areAllNotificationsRead = areNotificationRead;
    _observers.forEach((e) {
      e.update();
    });
  }
}