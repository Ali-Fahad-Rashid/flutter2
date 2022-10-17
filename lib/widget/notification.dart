import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class Notifi {
  var serverToken=FirebaseMessaging.instance.getToken();
      //'fQC0sWNXTWCN6gSuVZeGtK:APA91bEUMcJyTREkMFf1odM-AaNQwmbp4NaQpCdNxvRoTooHe4OxkJKnq0QPPn-waiNYYFup44b6c4UPRmCBOal3TYLEJjkoBhvUJs3QRTO-v8sKUpkJK2G9WE4mztbEoG_ds03lOb77';
 // var fbm = FirebaseMessaging.instance;
  sendnoty(title,body,top) async{
    await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString()
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': 'id',
            'name': "ali",
          },
          'to':"/topics/${top}",   //await FirebaseMessaging.instance.getToken(),
        },
      ),
    );

  }

/*  FirebaseMessaging.onMessage.listen((event) {
  print("===================== data Notification ==============================") ;
  AwesomeDialog(context: context , title: "title" , body: Text("${event.notification!.body}"))..show() ;
  print(event.data['name']);
  Navigator.of(context).pushNamed("setting") ;
  }) ;

  Future backgroudMessage(RemoteMessage message) async {
    print("=================== BackGroud Message ========================") ;
    print("${message.notification!.body}") ;
  }
  FirebaseMessaging.onBackgroundMessage(backgroudMessage) ;*/


 // initalMessage() ;

/*  fbm.getToken().then((token) {
  print("=================== Token ==================");
  print(token);
  print("====================================");
  });*/


/*  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  Navigator.of(context).pushNamed("Profile") ;
  }) ;

  initalMessage() async {
    var message =   await FirebaseMessaging.instance.getInitialMessage() ;
    if (message != null){
      Navigator.of(context).pushNamed("setting") ;
    }
  }
  */




/*  requestPermssion() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }*/

//  requestPermssion() ;


}
/*


FirebaseMessaging.onMessage.listen((event) {
print("===================== data Notification ==============================") ;
print(event.notification!.body);
print(event.data['name']);
}) ;

Future backgroudMessage(RemoteMessage message) async {
  print("=================== BackGroud Message ========================") ;
  print("${message.notification!.body}") ;
}
FirebaseMessaging.onBackgroundMessage(backgroudMessage) ;

FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
print("===================== onMessageOpenedApp  ==============================") ;
print(message.notification!.body);
print(message.data['name']);
}) ;

initalMessage() async {

  var message =   await FirebaseMessaging.instance.getInitialMessage() ;
  if (message != null){
    print("===================== initalMessage  ==============================") ;
  }
}
initalMessage() ;*/
