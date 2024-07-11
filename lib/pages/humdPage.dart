import 'package:flutter/material.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/const/Utlis.dart';
import 'package:iotapp/provider/MainProvider.dart';
import 'package:iotapp/widget/TextWidget.dart';
import 'package:iotapp/widget/chart.dart';
import 'package:iotapp/widget/circularProg.dart';
import 'package:provider/provider.dart';

class HumdPage extends StatefulWidget {
  const HumdPage({
    super.key,
    required this.v,
    required this.p,
    required this.t,
    this.revers = false,
  });
  final double v;
  final String p, t;
  final bool revers;

  @override
  State<HumdPage> createState() => _HumdPageState();
}

class _HumdPageState extends State<HumdPage> {
  @override
  Widget build(BuildContext context) {
    double v = widget.v;
    return Scaffold(
      backgroundColor: c1,
      appBar: AppBar(
        backgroundColor: c4,
        leading: const BackButton(
          color: c1,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(child: Consumer<MainProvider>(
          builder: (context, value, child) {
            if (value.humed != 0) {
              v = value.humed.toDouble();
            }
            return Column(
              children: [
                Container(
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    Image.asset(
                      "assets/imgs/u.png",
                      scale: 0.9,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                              text: "بغداد", color: cb, textSize: 50),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.asset("assets/imgs/img3.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      text: "درجة الرطوبة",
                                      color: cb,
                                      textSize: 20),
                                  TextWidget(
                                      text: "مؤشر الرطوبة",
                                      color: c5,
                                      textSize: 14),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Circularprog(
                      h: 200,
                      w: 250,
                      v: v,
                      p: "${v.toInt()}%",
                      t: widget.t,
                      page: null),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        width: Utils(context).screenSize.width / 4.22,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: const TextWidget(
                          text: "76-100",
                          color: c1,
                          textSize: 20,
                          isTitle: true,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        width: Utils(context).screenSize.width / 4.22,
                        color: Colors.orange,
                        child: const TextWidget(
                          text: "51-75",
                          color: c1,
                          textSize: 20,
                          isTitle: true,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        width: Utils(context).screenSize.width / 4.22,
                        color: Colors.yellow,
                        child: const TextWidget(
                          text: "26-50",
                          color: c1,
                          textSize: 20,
                          isTitle: true,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        width: Utils(context).screenSize.width / 4.22,
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        child: const TextWidget(
                          text: "0-25",
                          color: c1,
                          textSize: 20,
                          isTitle: true,
                        ),
                      )
                    ],
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextWidget(text: "خطير", color: cb, textSize: 18),
                    TextWidget(text: "سيئ", color: cb, textSize: 18),
                    TextWidget(text: "طبيعي", color: cb, textSize: 18),
                    TextWidget(text: "جيد", color: cb, textSize: 18),
                  ],
                ),
                const Directionality(
                    textDirection: TextDirection.ltr, child: Chart())
              ],
            );
          },
        )),
      ),
    );
  }
}
