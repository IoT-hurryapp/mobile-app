import 'package:flutter/material.dart';
import 'package:iotapp/API/sokcetIO.dart';
import 'package:iotapp/Screens/setLocations.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/pages/aqiPage.dart';
import 'package:iotapp/pages/humdPage.dart';
import 'package:iotapp/pages/polluPage.dart';
import 'package:iotapp/pages/tempPage.dart';
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
  List<String> tempState = ["متجمد", "بارد", "طبيعي", "حار", "حرارة مرتفعة"];
  List<String> state = ["خطير", "سيئ", "طبيعي", "جيد"];

  int temp = 0, humed = 0, dust = 0, air = 0;
  
  SocketService? _socketService;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _socketService = SocketService(context);
      Provider.of<MainProvider>(context, listen: false).setSocket(_socketService!);
    });
  }

  @override
  void dispose() {
    _socketService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Setlocations()),
              );
            },
            child: const TextWidget(
              text: "الموقع",
              color: c1,
              textSize: 18,
              isTitle: true,
            ),
          ),
        ],
        title: const TextWidget(
          text: "الطقس",
          color: cw,
          textSize: 18,
          isTitle: true,
        ),
        backgroundColor: c4,
      ),
      backgroundColor: c1,
      body: SingleChildScrollView(
        child: Consumer<MainProvider>(
          builder: (context, value, child) {
            temp = value.temp;
            humed = value.humed;
            dust = value.dust;
            air = value.air;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: c1,
                    border: Border.all(color: c5),
                  ),
                  child: TextWidget(
                    text: "حالة الجو : ${getState()}",
                    color: cb,
                    isTextCenterd: true,
                    maxLines: 1,
                    textSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Circularprog(
                    h: 180,
                    w: 250,
                    v: temp * 1.5,
                    p: "${temp}c°",
                    t: "الحرارة",
                    page: TempPage(
                      p: "${temp}c°",
                      t: "الحرارة",
                      v: temp + 0.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Circularprog(
                      h: 85,
                      w: 85,
                      v: humed + 0.0,
                      p: "$humed%",
                      t: "الرطوبة",
                      page: HumdPage(v: humed + 0.0, p: "$humed%", t: "الرطوبة"),
                    ),
                    Circularprog(
                      h: 85,
                      w: 85,
                      v: air / 5,
                      p: "$air",
                      t: "جودة الهواء",
                      page: AQIPage(v: air + 0.0, p: "$air", t: "جودة الهواء"),
                    ),
                    Circularprog(
                      h: 85,
                      w: 85,
                      v: dust + 0.0,
                      p: "$dust%",
                      t: "التلوث",
                      page: PolluPage(v: dust + 0.0, p: "$dust%", t: "التلوث"),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildWeatherInfo("الرطوبة", "$humed%", getHumidityState(), 110, 110, 2),
                    buildWeatherInfo("جودة الهواء", "${(100 - ((air / 500) * 100)).toInt()}%", getAirQualityState(), 110, 110, 3),
                    buildWeatherInfo("التلوث", "$dust%", getPollutionState(), 110, 110, 4),
                  ],
                ),
                buildWeatherInfo("الحرارة", "$temp °C", getTempState(), 400, 150, 1),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }

  String getState() {
    // Determine the most severe weather condition based on current values
    String temperatureState = getTempState();
    String humidityState = getHumidityState();
    String airQualityState = getAirQualityState();
    String pollutionState = getPollutionState();

    // Return the highest danger state among all weather conditions
    List<String> states = [temperatureState, humidityState, airQualityState, pollutionState];
    if (states.contains("خطير")) {
      return "خطير";
    } else if (states.contains("سيئ")) {
      return "سيئ";
    } else if (states.contains("طبيعي")) {
      return "طبيعي";
    } else {
      return "جيد";
    }
  }

  String getTempState() {
    if (temp <= -10) {
      return tempState[0];
    } else if (temp <= 10) {
      return tempState[1];
    } else if (temp <= 30) {
      return tempState[2];
    } else if (temp <= 40) {
      return tempState[3];
    } else {
      return tempState[4];
    }
  }

  String getHumidityState() {
    if (humed <= 50) {
      return state[2];
    } else if (humed <= 70) {
      return state[1];
    } else {
      return state[0];
    }
  }

  String getAirQualityState() {
    int _air = ((air / 500) * 100).toInt();
    if (_air <= 20) {
      return state[3];
    } else if (_air <= 40) {
      return state[2];
    } else if (_air <= 60) {
      return state[1];
    } else {
      return state[0];
    }
  }

  String getPollutionState() {
    if (dust <= 10) {
      return state[3];
    } else if (dust <= 20) {
      return state[2];
    } else if (dust <= 40) {
      return state[1];
    } else {
      return state[0];
    }
  }

  Widget buildWeatherInfo(String title, String value, String state, double w, double h, int index) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: w,
      height: h,
      padding: w > 200 ? const EdgeInsets.all(20) : const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: c1,
        border: Border.all(color: c5),
      ),
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: w > 200 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          TextWidget(
            text: title,
            color: cb,
            textSize: w > 200 ? 32 : 16,
            isTitle: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: state,
                color: Colors.grey,
                textSize: w > 200 ? 32 : 17,
              ),
              Image.asset(
                "assets/imgs/$index.png",
                fit: BoxFit.scaleDown,
                scale: w > 200 ? 9 : 12.5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
