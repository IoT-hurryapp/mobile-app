import 'package:flutter/material.dart';
import 'package:iotapp/const/MyColors.dart';

import 'TextWidget.dart';

// ignore: must_be_immutable
class Circularprog extends StatelessWidget {
  Circularprog(
      {super.key,
      required this.h,
      required this.w,
      required this.v,
      required this.p,
      required this.t,
      this.revers = false});
  double h, w, v;
  final String p, t;
  final bool revers;
  @override
  Widget build(BuildContext context) {
    bool neg = false;
    if (v < 0) {
      neg = true;
      v = v * -1;
      
    }
    return Container(
      padding: EdgeInsets.all(15),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: c4),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              TextWidget(
                text: p,
                color: cw,
                textSize: h / 4,
                isTitle: true,
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                height: h,
                width: w,
                child: RotationTransition(
                  turns:const AlwaysStoppedAnimation(270 / 360),
                  child: AnimatedBuilder(
                    animation: Tween<double>(begin: 0, end: 1).animate(
                      const AlwaysStoppedAnimation(100),
                    ),
                    builder: (context, child) {
                      Color color;
                      if (neg) {
                         color =
                            ColorTween(begin: Colors.blue, end: Colors.white)
                                .lerp(v)!;
                      } else {
                         color = revers
                            ? ColorTween(begin: Colors.green, end: Colors.red)
                                .lerp(v)!
                            : ColorTween(begin: Colors.red, end: Colors.green)
                                .lerp(v)!;
                      }

                      return CircularProgressIndicator(
                        strokeWidth: 20,
                        backgroundColor: color.withOpacity(v / 2),
                        valueColor: AlwaysStoppedAnimation(color),
                        value: v,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          TextWidget(
            text: t,
            color: cw,
            textSize: 16,
            isTitle: true,
          ),
        ],
      ),
    );
  }
}
