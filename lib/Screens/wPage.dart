import 'package:flutter/material.dart';
import 'package:iotapp/Screens/loginScreen.dart';
import 'package:iotapp/Screens/regScreen.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/widget/TextWidget.dart';
import 'package:page_transition/page_transition.dart';

class WPage extends StatefulWidget {
  const WPage({super.key});

  @override
  State<WPage> createState() => _WPageState();
}

class _WPageState extends State<WPage> {
  bool start = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.centerRight,
                height: 150,
                child: const TextWidget(
                  text: "مرحباً!",
                  color: cb,
                  textSize: 50,
                  isTitle: true,
                )),
            Container(
              padding: const EdgeInsets.only(right: 100),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: const Radius.circular(100),
                      bottomRight:
                          Radius.circular(100)), // Set the desired radius here
                  child: Image.asset(
                    "assets/imgs/img1.png",
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: TextWidget(
                text: "استكشف درجات الحرارة ومستويات التلوث ",
                color: cb,
                textSize: 34,
                isTitle: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: TextWidget(
                text:
                    "مرحبًا بكم في منصتنا، حيث تلتقي التكنولوجيا بالاستدامة. نحن ملتزمون بتمكين الأفراد والمجتمعات بأدوات متقدمة لمراقبة وتحسين الظروف البيئية.",
                color: cb,
                textSize: 15,
                isTitle: true,
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Wpage2()));
                },
                child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(right: 30, left: 30),
                    decoration: BoxDecoration(
                        color: c2, borderRadius: BorderRadius.circular(15)),
                    child:
                        const TextWidget(text: "ابدأ", color: cw, textSize: 18))),
          ],
        ),
      ),
    );
  }
}

class Wpage2 extends StatelessWidget {
  const Wpage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight:
                            Radius.circular(30)), // Set the desired radius here
                    child: Image.asset(
                      "assets/imgs/img2.png",
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: TextWidget(
                    text: "معًا من أجل مستقبل أكثر اخضرارًا",
                    color: cb,
                    textSize: 25,
                    isTitle: true,
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextWidget(
                      isTextCenterd: true,
                      text:
                          "مرحبًا بكم في منصتنا، حيث تلتقي التكنولوجيا بالاستدامة. نحن ملتزمون بتمكين الأفراد والمجتمعات بأدوات متقدمة لمراقبة وتحسين الظروف البيئية.",
                      color: cb,
                      textSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                      
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const RegScreen()));
                    },
                    child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 30, left: 30),
                        decoration: BoxDecoration(
                            color: c2, borderRadius: BorderRadius.circular(10)),
                        child: const TextWidget(
                            text: "انشاء حساب جديد", color: cw, textSize: 22))),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () {
                       Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const LoginScreen()));
                    },
                    child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 30, left: 30),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(217, 217, 217, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const TextWidget(
                            text: "تسجيل الدخول",
                            color: Color.fromRGBO(116, 116, 116, 1),
                            textSize: 22))),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "تخطي تسجيل لرؤية الاجهزة العامة من حولك",
                      style: TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: const Color.fromARGB(255, 117, 116, 116)),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
