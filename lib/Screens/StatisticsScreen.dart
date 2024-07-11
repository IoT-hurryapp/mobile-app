import 'package:flutter/material.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/widget/TextWidget.dart';
import 'package:iotapp/widget/chart.dart';

class StatiSticsScreen extends StatefulWidget {
  const StatiSticsScreen({super.key});

  @override
  State<StatiSticsScreen> createState() => _StatiSticsScreenState();
}

class _StatiSticsScreenState extends State<StatiSticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      appBar: AppBar(
        backgroundColor: c4,
        leading:const BackButton(
          color: c1,
        ),
      ),
      body: Column(
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
                    TextWidget(text: "بغداد", color: cb, textSize: 50),
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
                                text: "جودة الهواء", color: cb, textSize: 20),
                            TextWidget(
                                text: "مؤشر الجودة", color: c5, textSize: 14),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
          Chart()
        ],
      ),
    );
  }
}
