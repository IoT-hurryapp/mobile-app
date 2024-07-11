import 'package:flutter/material.dart';
import 'package:iotapp/API/authstuff.dart';
import 'package:iotapp/API/checkLocations.dart';
import 'package:iotapp/Screens/HomePage.dart';
import 'package:iotapp/Screens/setLocations.dart';
import 'package:iotapp/Screens/wPage.dart';
import 'package:iotapp/provider/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => MainProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLooding = true;

  bool isthereAsavedLocation = false;

  Future log() async {
    
    await loginwithToken(context);
    if (await Checklocations().isthereAsavedLocation()) {
      setState(() {
        isthereAsavedLocation = true;
      });
    }
    setState(() {
      isLooding = false;
    });
  }

  @override
  void initState() {
    super.initState();
    log();
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WApp',
        theme: ThemeData(
         
          useMaterial3: true,
        ),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Consumer<MainProvider>(
            builder: (context, value, child) {
              if (isLooding) {
                return Scaffold(
                  body: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/imgs/backround.png"))),
                  ),
                );
              }
              if (value.isLog) {
                if (isthereAsavedLocation) {
                  return const HomePage();
                } else {
                  return const HomePage();

                  return const Setlocations();
                }
              } else {
                return const WPage();
              }
            },
          ),
        ));
  }
}
