import 'package:firebase_messaging/firebase_messaging.dart';

class FirebasePushNotfications {
  final _fbM = FirebaseMessaging.instance;

  Future initNotf() async {
    await _fbM.requestPermission();
    final token = await _fbM.getToken();

    //print("Token: $token");
    print(token);
    return token;
  }
}
