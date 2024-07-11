import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iotapp/API/authstuff.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/const/Utlis.dart';
import 'package:iotapp/main.dart';
import 'package:iotapp/widget/TextWidget.dart';
import 'package:iotapp/provider/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  TextEditingController email = TextEditingController(),
      password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image.asset(
                  "assets/imgs/v1.png",
                  fit: BoxFit.fill,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 40, right: 15),
                  child: TextWidget(
                    text: "تسجيل الدخول",
                    color: cb,
                    textSize: 25,
                    isTitle: true,
                  ),
                )
              ],
            ),
            SizedBox(
              height: Utils(context).screenSize.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: "الأيميل",
                    color: cb,
                    textSize: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 50,
                    child: TextField(
                      controller: email,
                      onChanged: (value) {
                        setState(() {
                          email.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "demo@gmail.com",
                        hintStyle: const TextStyle(color: c5),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(44, 100, 83, 253)),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: const Color.fromARGB(44, 100, 83, 253),
                        filled: true,
                      ),
                    ),
                  ),
                  const TextWidget(
                    text: "كلمة المرور",
                    color: cb,
                    textSize: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 50,
                    child: TextField(
                      controller: password,
                      onChanged: (value) {
                        setState(() {
                          password.text = value;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "********",
                        hintStyle: const TextStyle(color: c5),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(44, 100, 83, 253)),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: const Color.fromARGB(44, 100, 83, 253),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Utils(context).screenSize.height * 0.2,
                  ),
                  GestureDetector(
                      onTap: () {
                        submit();
                      },
                      child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                              color: c2,
                              borderRadius: BorderRadius.circular(10)),
                          child: const TextWidget(
                              text: "تسجيل الدخول", color: cw, textSize: 22))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future submit() async {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: c4,
          children: <Widget>[
            Center(
                child: Container(
              padding: const EdgeInsets.all(10),
              child: const Row(children: <Widget>[
                CircularProgressIndicator(
                  color: c1,
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                Text(
                  "Checking in Please Wait!",
                  style: TextStyle(color: c1),
                ),
              ]),
            ))
          ],
        );
      },
    );
    final r = jsonDecode(await login(email.text, password.text));
    if (r["success"] == true) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Provider.of<MainProvider>(context, listen: false).IsLogged(true);
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.fade, child: const MyApp()),
        (route) {
          return false;
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      final msg = r["message"] ?? "";
      // ignore: use_build_context_synchronously
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return SimpleDialog(
              backgroundColor: c4,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      msg,
                      style: const TextStyle(color: c1),
                    ),
                  ),
                )
              ],
            );
          });
    }
  }
}
