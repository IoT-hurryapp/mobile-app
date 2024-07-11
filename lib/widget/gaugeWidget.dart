import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/pages/gauge_data_controller.dart';

class Gaug extends StatefulWidget {
  const Gaug({super.key, required this.controller, required this.text});
  final GaugeDataController controller;
  final String text;
  @override
  State<Gaug> createState() => _GaugState();
}

class _GaugState extends State<Gaug> {
  @override
  Widget build(BuildContext context) {
    final GaugeDataController controller = widget.controller;
    controller.pointerType = PointerType.needle;
    controller.progressBarColor = c2;

    controller.pointerType = PointerType.triangle;
    controller.progressBarColor = const Color.fromARGB(0, 0, 0, 0);
    double value = controller.value;

    return Builder(builder: (context) {
      final gaugeWidget = Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) => SizedBox(
            width: controller.parentWidth,
            height: controller.parentHeight,
            child: AnimatedRadialGauge(
              radius: controller.gaugeRadius,
              builder: controller.hasPointer &&
                      controller.pointerType == PointerType.needle
                  ? null
                  : (context, _, value) => Directionality(
                        textDirection: TextDirection.ltr,
                        child: RadialGaugeLabel(
                          style: TextStyle(
                            color: const Color(0xFF002E5F),
                            fontSize: controller.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          value: value,
                          labelProvider: GaugeLabelProvider.map(
                            toLabel: (p0) {
                              return widget.text;
                            },
                          ),
                        ),
                      ),
              duration: const Duration(milliseconds: 2000),
              curve: Curves.elasticOut,
              value: value,
              axis: GaugeAxis(
                  min: 0,
                  max: 100,
                  degrees: controller.degree,
                  pointer: controller.hasPointer
                      ? controller.getPointer(
                          controller.pointerType,
                        )
                      : null,
                  progressBar: controller.hasProgressBar
                      ? controller.getProgressBar(controller.progressBarType)
                      : null,
                  transformer: const GaugeAxisTransformer.colorFadeIn(
                    interval: Interval(0.0, 0.3),
                    background: Color(0xFFD9DEEB),
                  ),
                  style: GaugeAxisStyle(
                    thickness: controller.thickness,
                    background: controller.backgroundColor,
                    segmentSpacing: controller.spacing,
                    blendColors: false,
                    cornerRadius: Radius.circular(controller.segmentsRadius),
                  ),
                  segments: controller.segments),
            ),
          ),
        ),
      );

      return gaugeWidget;
    });
  }
}
