import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/pages/gauge_data_controller.dart';
import 'package:iotapp/widget/TextWidget.dart';
import 'package:iotapp/widget/gaugeWidget.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class Circularprog extends StatelessWidget {
  Circularprog(
      {super.key,
      required this.h,
      required this.w,
      required this.v,
      required this.p,
      required this.t,
      this.revers = false,
      required this.page});
  double h, w, v;
  final String p, t;
  final bool revers;
  final page;
  @override
  Widget build(BuildContext context) {
    GaugeDataController c = GaugeDataController();
    c.value = 20;
    c.gaugeRadius = w * 0.5;
    c.parentHeight = h;
    c.parentWidth = w;
    c.fontSize = w * 0.2;
    c.pointerSize = w * 0.12;
    c.degree = 240;
    c.thickness = w * 0.1;
    c.value = v;
    c.spacing = w * 0.04;
    c.segments = [
      const GaugeSegment(from: 0, to: 25, color: Colors.green),
      const GaugeSegment(from: 25, to: 50, color: Colors.yellow),
      const GaugeSegment(from: 50, to: 75, color: Colors.orange),
      const GaugeSegment(from: 75, to: 100, color: Colors.red)
    ];
    if (revers) {
      c.segments = c.segments = [
        const GaugeSegment(from: 0, to: 25, color: Colors.red),
        const GaugeSegment(from: 25, to: 50, color: Colors.orange),
        const GaugeSegment(from: 50, to: 75, color: Colors.yellow),
        const GaugeSegment(from: 75, to: 100, color: Colors.green)
      ];
    }
    bool neg = false;
    if (v < 0) {
      neg = true;
      v = v * -1;
      c.value = v;
      c.segments = c.segments = [
        const GaugeSegment(from: 0, to: 25, color: Colors.blue),
        const GaugeSegment(from: 25, to: 50, color: Colors.lightBlue),
        const GaugeSegment(
            from: 50, to: 75, color: Color.fromARGB(255, 0, 242, 255)),
        const GaugeSegment(
            from: 75, to: 100, color: Color.fromARGB(255, 172, 249, 255))
      ];
    }
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            PageTransition(type: PageTransitionType.fade, child: page),
           
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: c1,
            border: Border.all(
              color: c5,
            )),
        child: Column(
          children: [
            Gaug(
              controller: c,
              text: neg ? "$p" : p,
            ),
            TextWidget(
              text: t,
              color: cb,
              textSize: h * 0.15,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
