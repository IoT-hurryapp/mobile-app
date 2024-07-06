import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iotapp/API/checkLocations.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/widget/TextWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setlocations extends StatefulWidget {
  const Setlocations({super.key});

  @override
  State<Setlocations> createState() => _SetlocationsState();
}

class _SetlocationsState extends State<Setlocations> {
  TextEditingController name = TextEditingController();
  Future dataLoc = Checklocations().getLocations();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      appBar: AppBar(
        title: const TextWidget(
          text: "Browse and add your locaitons",
          color: c4,
          textSize: 20,
          isTitle: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                AddLoc();
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: c4, borderRadius: BorderRadius.circular(15)),
                  child: const TextWidget(
                      text: "Add locaiton", color: cw, textSize: 18))),
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
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: cw),
                        margin: EdgeInsets.all(10),
                        height: 70,
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: data[index]["name"],
                              color: c4,
                              textSize: 20,
                              isTitle: true,
                            ),
                            ElevatedButton(
                                onPressed: () {selected();},
                                child: TextWidget(
                                    text: "select", color: c4, textSize: 18))
                          ],
                        ),
                      );
                      return Text(data[index]["name"]);
                    },
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }

  void AddLoc() {
    String? selectedValue;
    Future<List<String>> getDropdownValues() async {
      // Replace this with your actual data fetching logic
      // await Future.delayed(Duration(seconds: 2));
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
                content: Text("watting..."),
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
                title: Text("Add location"),
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
                        const Text("chose a device"),
                        DropdownButton<String>(
                          value: "device 1",
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue;
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
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      setLocation(name.text);
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
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
