import 'package:esp_socket/socket/notification.dart';

abstract class NotificationObserver {
  late String id;

  void update(SocketNotification notification);
}
