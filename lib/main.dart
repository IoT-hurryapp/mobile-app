import 'package:flutter/material.dart';
import 'package:iotapp/API/authstuff.dart';
import 'package:iotapp/API/checkLocations.dart';
import 'package:iotapp/API/sokcetIO.dart';
import 'package:iotapp/Screens/HomePage.dart';
import 'package:iotapp/Screens/authScreen.dart';
import 'package:iotapp/Screens/setLocations.dart';
import 'package:iotapp/provider/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebasePushNotfications().initNotf();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => MainProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isLooding = true;
    bool isthereAsavedLocation = false;
    Future log() async {
      SocketService().connect(context);
      await loginwithToken(context);
      if (await Checklocations().isthereAsavedLocation()) {
        isthereAsavedLocation =true;
      }
      isLooding = false;
    }

    if (isLooding) {
      log();
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Consumer<MainProvider>(
          builder: (context, value, child) {
            if (isLooding) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (value.isLog) {
              if(isthereAsavedLocation){
                return const HomePage();
              }else{
                return const Setlocations();
              }
              
            } else {
              return const AuthScreen();
            }
          },
        ));
  }
}


class FirebasePushNotfications{


  final _fbM = FirebaseMessaging.instance;

  Future initNotf()async{

    await _fbM.requestPermission();
    final token = await _fbM.getToken();

    //print("Token: $token");
    print(token);
    return token;
  }




}