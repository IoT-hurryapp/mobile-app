import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iotapp/API/checkLocations.dart';
import 'package:iotapp/API/sokcetIO.dart';
import 'package:iotapp/Screens/setUpNewLoc.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/main.dart';
import 'package:iotapp/provider/MainProvider.dart';
import 'package:iotapp/widget/TextWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

class Setlocations extends StatefulWidget {
  const Setlocations({super.key});

  @override
  State<Setlocations> createState() => _SetlocationsState();
}

class _SetlocationsState extends State<Setlocations> {
  TextEditingController name = TextEditingController();

  Future dataLoc = Checklocations().getLocations();
  SocketService? _socketService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _socketService ??= SocketService(context);
  }

  @override
  void dispose() {
    _socketService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
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
                  TextWidget(text: "تصفح وأضف موقعك!", color: cb, textSize: 30),
                ],
              ),
            ),
          ]),
          Container(
              margin: const EdgeInsets.all(10),
              child: const TextWidget(
                  text: "المواقع الخاصة", color: cb, textSize: 25)),
          FutureBuilder(
            future: dataLoc,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = jsonDecode(snapshot.requireData);
                if (data.length == 0) {
                  return Column(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: const TextWidget(
                              text: "قم بأضافة موقعك الخاص",
                              color: cb,
                              textSize: 18),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          addLoc();
                        },
                        child: Container(
                          height: 80,
                          width: double.maxFinite,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: cw,
                              border: Border.all(color: c5)),
                          child: const Icon(
                            Icons.add,
                            size: 50,
                            color: c5,
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  "LOCATION",
                                  jsonEncode({
                                    "data": [
                                      data[index]["name"],
                                      data[index]["id"],
                                      data[index]["devices"][0]["id"],
                                    ]
                                  }));

                              Provider.of<MainProvider>(context, listen: false)
                                  .setSocket(_socketService);

                              Navigator.pushAndRemoveUntil(
                                // ignore: use_build_context_synchronously
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const MyApp()),
                                (route) {
                                  return false;
                                },
                              );
                            },
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: cw,
                                  border: Border.all(color: c5)),
                              margin: const EdgeInsets.only(
                                  right: 10, left: 10, top: 10),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const TextWidget(
                                          text: "الأجهزة المرتبطة ",
                                          color: cb,
                                          textSize: 18),
                                      Container(
                                        margin: const EdgeInsets.all(2),
                                        child:const TextWidget(
                                            text: "1",
                                            color: Colors.green,
                                            textSize: 18),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextWidget(
                                        text: data[index]["name"],
                                        color: cb,
                                        textSize: 20,
                                        isTitle: true,
                                      ),
                                      TextWidget(
                                        text:
                                            " الاشعارات ${data[index]["notifications"].length}",
                                        color: c5,
                                        textSize: 16,
                                        isTitle: true,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SetUpNewLoc()),
                          );
                        },
                        child: Container(
                          height: 80,
                          width: double.maxFinite,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: cw,
                              border: Border.all(color: c5)),
                          child: const Icon(
                            Icons.add,
                            size: 50,
                            color: c5,
                          ),
                        ),
                      )
                    ],
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            },
          ),
          Container(
              margin: const EdgeInsets.all(10),
              child: const TextWidget(
                  text: "المواقع العامة", color: cb, textSize: 25)),
          FutureBuilder(
            future: dataLoc,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = jsonDecode(snapshot.requireData);

                if (data.length == 0) {
                  return Expanded(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: const TextWidget(
                            text: "No Locaitons have been set",
                            color: c4,
                            textSize: 18),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length, //data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: cw,
                                border: Border.all(color: c5)),
                            margin: const EdgeInsets.only(
                                right: 10, left: 10, top: 10),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const TextWidget(
                                        text: "الأجهزة المرتبطة ",
                                        color: cb,
                                        textSize: 18),
                                    Container(
                                      margin: const EdgeInsets.all(2),
                                      child: const TextWidget(
                                          text: "1",
                                          color: Colors.green,
                                          textSize: 18),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextWidget(
                                      text: data[index]["name"],
                                      color: cb,
                                      textSize: 20,
                                      isTitle: true,
                                    ),
                                    TextWidget(
                                      text:
                                          " الاشعارات ${data[index]["notifications"].length}",
                                      color: c5,
                                      textSize: 16,
                                      isTitle: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  void addLoc() {
    Future<List<String>> getDropdownValues() async {
      // Replace this with your actual data fetching logic
      return ['device 1'];
    }

    showDialog(
      context: context,
      builder: (cntext) {
        return FutureBuilder<List<String>>(
          future: getDropdownValues(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                title: Text("Add location"),
                content: Text("Waiting..."),
              );
            } else if (snapshot.hasError) {
              return const AlertDialog(
                title: Text("Add location"),
                content: Text("Error fetching dropdown values"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const AlertDialog(
                title: Text("Add location"),
                content: Text("No dropdown values available"),
              );
            } else {
              return AlertDialog(
                title: const Text("Add location"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        fillColor: c1,
                        filled: true,
                        counter: Container(),
                        label: const TextWidget(
                            text: "Location", color: c4, textSize: 16),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: c4, width: 3.0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: c4, width: 3.0),
                        ),
                      ),
                      maxLines: 1,
                      maxLength: 25,
                      onChanged: (value) => setState(() {
                        name.text = value;
                      }),
                      style: const TextStyle(fontSize: 18, color: c4),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Choose a device"),
                        DropdownButton<String>(
                          value: "device 1",
                          onChanged: (String? newValue) {
                            setState(() {
                              // Handle the selected value if needed
                            });
                          },
                          items: snapshot.data!
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setLocation(name.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  void selected() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("LOCATION", "1");
    // ignore: use_build_context_synchronously
    Navigator.popAndPushNamed(context, "/");
  }

  void setLocation(String name) async {
    String id = json.decode(await Checklocations().setNewLoc(name))["id"];
    await Checklocations().attachNewDevice(id, "1");
    setState(() {
      dataLoc = Checklocations().getLocations();
    });
  }
}
