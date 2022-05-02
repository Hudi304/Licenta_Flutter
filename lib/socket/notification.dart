import 'package:esp_socket/shared/notifications/notification-observer.dart';

class SocketNotification {
   late bool connectionEstablished;
   late String msg;

   bool isConnectionEstablished(){
     return connectionEstablished;
   }
   // bool isConnectionEstablished(){
   //   return connectionEstablished;
   // }


   SocketNotification( this.connectionEstablished,this.msg);


}
