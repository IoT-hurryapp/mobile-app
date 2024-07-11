import 'dart:convert';
import 'package:iotapp/Screens/setLocations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:iotapp/API/authstuff.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/provider/MainProvider.dart';
import 'package:iotapp/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  TextEditingController userName = TextEditingController(),
      email = TextEditingController(),
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
                    text: "إنشاء حساب الآن",
                    color: cb,
                    textSize: 25,
                    isTitle: true,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const TextWidget(
                    text: "الأسم الكامل",
                    color: cb,
                    textSize: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 50,
                    child: TextField(
                      controller: userName,
                      onChanged: (value) {
                        setState(() {
                          userName.text = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Muntazer Abbas",
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
                  const SizedBox(
                    height: 10,
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
                              text: "انشاء حساب جديد",
                              color: cw,
                              textSize: 22))),
                  Center(
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "هل لديك حساب؟ سجل الدخول",
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 117, 116, 116)),
                        )),
                  )
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
    final r =
        jsonDecode(await register(userName.text, password.text, email.text));

    if (r["success"] == true) {
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Provider.of<MainProvider>(context, listen: false).IsLogged(true);
      Navigator.pushAndRemoveUntil(context,
          PageTransition(type: PageTransitionType.fade, child:const Setlocations()),(route) {
           return false;
          },);
      // ignore: use_build_context_synchronously
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
                ))
              ],
            );
          });
    }
  }
}
