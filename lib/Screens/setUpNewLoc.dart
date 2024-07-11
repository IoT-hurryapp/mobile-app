import 'dart:convert';
import 'package:iotapp/API/checkLocations.dart';
import 'package:iotapp/Screens/setLocations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:iotapp/Screens/qrCodeScann.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/const/Utlis.dart';
import 'package:iotapp/widget/TextWidget.dart';


class SetUpNewLoc extends StatefulWidget {
  const SetUpNewLoc({super.key});

  @override
  State<SetUpNewLoc> createState() => _SetUpNewLocState();
}

class _SetUpNewLocState extends State<SetUpNewLoc> {
  TextEditingController name = TextEditingController(),
      id = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: c4,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Image.asset(
          "assets/imgs/logo.png",
          scale: 2,
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Image.asset(
              "assets/imgs/lookup4.us.png",
              scale: 0.8,
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(alignment: Alignment.centerRight, children: [
            Image.asset(
              "assets/imgs/u.png",
              scale: 0.9,
              fit: BoxFit.fill,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(text: "أضف موقعك وجهازك", color: cb, textSize: 30),
                ],
              ),
            ),
          ]),
          Container(
              margin: const EdgeInsets.all(10),
              child: const TextWidget(text: "الموقع", color: cb, textSize: 25)),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: const EdgeInsets.all(10),
              height: 50,
              child: TextField(
                controller: name,
                onChanged: (value) {
                  setState(() {
                    name.text = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "بغداد/الكرادة",
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
          ),
          Container(
              margin: const EdgeInsets.all(10),
              child: const TextWidget(
                  text: "معرف الجهاز", color: cb, textSize: 25)),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: Utils(context).screenSize.width * 0.8,
                  height: 50,
                  child: TextField(
                    controller: id,
                    onChanged: (value) {
                      setState(() {
                        id.text = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "29163052443",
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
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: c5)),
                    child: IconButton(
                        onPressed: () async {
                          final scannedCode = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BarcodeScannerScreen()),
                          );
                          if (scannedCode != null) {
                            setState(() {
                              id.text = scannedCode;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.qr_code_scanner,
                          size: 35,
                        ))),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
              onTap: () {},
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                      color: c2, borderRadius: BorderRadius.circular(10)),
                  child: const TextWidget(
                      text: "أضافة", color: cw, textSize: 22))),
        ],
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
    final res = jsonDecode(await Checklocations().setNewLoc(name.text));
    final r =
        jsonDecode(await Checklocations().attachNewDevice(res["id"], id.text));
    if (r["success"] == true) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.fade, child: const Setlocations()),
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
