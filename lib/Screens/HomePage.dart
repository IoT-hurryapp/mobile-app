import 'package:flutter/material.dart';
import 'package:iotapp/Screens/setLocations.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/provider/MainProvider.dart';
import 'package:iotapp/widget/TextWidget.dart';
import 'package:iotapp/widget/circularProg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<String> tempState = [
      "Freezing",
      "Cold",
      "Moderate",
      "Hot",
      "Very Hot"
    ];
    List<String> state = ["Dangerous", "Bad", "Good"];

    int _temp = 0, _humed = 0, _dust = 0, _air = 0;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setlocations()));
              },
              child: const TextWidget(
                text: "Locaitons",
                color: c1,
                textSize: 18,
                isTitle: true,
              ))
        ],
        title: const TextWidget(
          text: "Weather in Baghdad",
          color: cw,
          textSize: 18,
          isTitle: true,
        ),
        backgroundColor: c4,
      ),
      backgroundColor: c1,
      body: SingleChildScrollView(child: Consumer<MainProvider>(
        builder: (context, value, child) {
          _temp = value.temp;
          _humed = value.humed;
          _dust = value.dust;
          _air = value.air;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: c4),
                child:  TextWidget(
                    text: "Weather state:"+"Temperature :   ${_temp <= -10 ? tempState[0] : _temp <= 10 ? tempState[1] : _temp <= 30 ? tempState[2] : _temp <= 40 ? tempState[3] : tempState[4]}",
                    color: cw,
                    isTextCenterd: true,
                    maxLines: 1,
                    textSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Circularprog(
                h: 120,
                w: 120,
                v: (_temp / 100 * 1.5),
                p: "$_temp c°",
                t: "Temperature",
                revers: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Circularprog(
                    h: 60,
                    w: 60,
                    v: _humed / 100,
                    p: "$_humed%",
                    t: "Humidity",
                    revers: true,
                  ),
                  Circularprog(
                    h: 60,
                    w: 60,
                    v: (1 - (_air / 350)),
                    p: "${(100 - ((_air / 350) * 100)).toInt()}%",
                    t: "Air quality",
                  ),
                  Circularprog(
                    h: 60,
                    w: 60,
                    v: _dust / 100,
                    p: "$_dust%",
                    t: "Pollution",
                    revers: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 320,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: c4,
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8),
                child: TextWidget(
                    text:
                        "Temperature : $_temp c°   ${_temp <= -10 ? tempState[0] : _temp <= 10 ? tempState[1] : _temp <= 30 ? tempState[2] : _temp <= 40 ? tempState[3] : tempState[4]}",
                    color: cw,
                    textSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 320,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: c4,
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8),
                child: TextWidget(
                    text:
                        "Humidity : $_humed%   ${_humed <= 50 ? state[2] : _humed <= 70 ? state[1] : state[0]}",
                    color: cw,
                    textSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 320,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: c4,
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8),
                child: TextWidget(
                    text:
                        "Air quality : ${100 - _air}%   ${_air <= 20 ? state[2] : _air <= 40 ? state[1] : state[0]}",
                    color: cw,
                    textSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 320,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: c4,
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8),
                child: TextWidget(
                    text:
                        "Pollution : $_dust   ${_dust <= 20 ? state[2] : _dust <= 40 ? state[1] : state[0]}",
                    color: cw,
                    textSize: 20),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          );
        },
      )),
    );
  }
}
