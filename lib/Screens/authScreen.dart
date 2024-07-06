import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iotapp/API/authstuff.dart';
import 'package:iotapp/const/MyColors.dart';
import 'package:iotapp/provider/MainProvider.dart';
import 'package:iotapp/widget/TextWidget.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool onlogin = true;

  TextEditingController usarName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      appBar: AppBar(
        backgroundColor: c4,
        title: const TextWidget(
          text: "Auth",
          color: Colors.white,
          textSize: 20,
          isTitle: true,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          //  color: Colors.amber,
          margin: const EdgeInsets.all(20),
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: onlogin ? "Login with your info" : "Register your info",
                color: c4,
                textSize: 25,
                isTitle: true,
              ),
              onlogin
                  ? SizedBox(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                                controller: usarName,
                                decoration: InputDecoration(
                                  fillColor: c1,
                                  filled: true,
                                  counter: Container(),
                                  label: const TextWidget(
                                      text: "Username",
                                      color: c4,
                                      textSize: 16),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: usarName.text.length < 3 &&
                                                  usarName.text.isNotEmpty
                                              ? Colors.red
                                              : c4,
                                          width: 3.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: usarName.text.length < 3 &&
                                                usarName.text.isNotEmpty
                                            ? Colors.red
                                            : c4,
                                        width: 3.0),
                                  ),
                                ),
                                maxLines: 1,
                                maxLength: 25,
                                onChanged: (value) => setState(() {
                                      usarName.text = value;
                                    }),
                                style:
                                    const TextStyle(fontSize: 18, color: c4)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                                controller: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: c1,
                                  filled: true,
                                  counter: Container(),
                                  label: const TextWidget(
                                      text: "Password",
                                      color: c4,
                                      textSize: 16),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: password.text.length < 3 &&
                                                  password.text.isNotEmpty
                                              ? Colors.red
                                              : c4,
                                          width: 3.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: password.text.length < 3 &&
                                                password.text.isNotEmpty
                                            ? Colors.red
                                            : c4,
                                        width: 3.0),
                                  ),
                                ),
                                maxLines: 1,
                                maxLength: 25,
                                onChanged: (value) => setState(() {
                                      password.text = value;
                                    }),
                                style:
                                    const TextStyle(fontSize: 18, color: c4)),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 320,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                                controller: usarName,
                                decoration: InputDecoration(
                                  fillColor: c1,
                                  filled: true,
                                  counter: Container(),
                                  label: const TextWidget(
                                      text: "Username",
                                      color: c4,
                                      textSize: 16),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: usarName.text.length < 3 &&
                                                  usarName.text.isNotEmpty
                                              ? Colors.red
                                              : c4,
                                          width: 3.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: usarName.text.length < 3 &&
                                                usarName.text.isNotEmpty
                                            ? Colors.red
                                            : c4,
                                        width: 3.0),
                                  ),
                                ),
                                maxLines: 1,
                                maxLength: 25,
                                onChanged: (value) => setState(() {
                                      usarName.text = value;
                                    }),
                                style:
                                    const TextStyle(fontSize: 18, color: c4)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                                controller: email,
                                decoration: InputDecoration(
                                  fillColor: c1,
                                  filled: true,
                                  counter: Container(),
                                  label: const TextWidget(
                                      text: "E-mail", color: c4, textSize: 16),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: usarName.text.length < 3 &&
                                                  usarName.text.isNotEmpty
                                              ? Colors.red
                                              : c4,
                                          width: 3.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: usarName.text.length < 3 &&
                                                email.text.isNotEmpty
                                            ? Colors.red
                                            : c4,
                                        width: 3.0),
                                  ),
                                ),
                                maxLines: 1,
                                maxLength: 25,
                                onChanged: (value) => setState(() {
                                      email.text = value;
                                    }),
                                style:
                                    const TextStyle(fontSize: 18, color: c4)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                                controller: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: c1,
                                  filled: true,
                                  counter: Container(),
                                  label: const TextWidget(
                                      text: "Password",
                                      color: c4,
                                      textSize: 16),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: password.text.length < 3 &&
                                                  password.text.isNotEmpty
                                              ? Colors.red
                                              : c4,
                                          width: 3.0)),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: password.text.length < 3 &&
                                                password.text.isNotEmpty
                                            ? Colors.red
                                            : c4,
                                        width: 3.0),
                                  ),
                                ),
                                maxLines: 1,
                                maxLength: 25,
                                onChanged: (value) => setState(() {
                                      password.text = value;
                                    }),
                                style:
                                    const TextStyle(fontSize: 18, color: c4)),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            onlogin = true;
                          });
                        },
                        child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: onlogin ? c4 : c2,
                                border: const Border(
                                    bottom: BorderSide(color: c2, width: 4),
                                    left: BorderSide(color: c2, width: 4),
                                    top: BorderSide(color: c2, width: 4),
                                    right: BorderSide(color: c2, width: 4)),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            alignment: Alignment.center,
                            child: const TextWidget(
                              text: "Login",
                              color: Colors.white,
                              textSize: 20,
                              isTitle: true,
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            onlogin = false;
                          });
                        },
                        child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: onlogin ? c3 : c4,
                                border: const Border(
                                    bottom: BorderSide(color: c3, width: 4),
                                    left: BorderSide(color: c3, width: 4),
                                    top: BorderSide(color: c3, width: 4),
                                    right: BorderSide(color: c3, width: 4)),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            alignment: Alignment.center,
                            child: const TextWidget(
                              text: "Register",
                              color: Colors.white,
                              textSize: 20,
                              isTitle: true,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      submit();
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), color: c4),
                      alignment: Alignment.center,
                      child: const TextWidget(
                          text: "Submit", color: Colors.white, textSize: 20),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future submit() async {
    if (onlogin) {
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
      final r = await login(usarName.text, password.text);
      if (r == true) {
        // ignore: use_build_context_synchronously
        Provider.of<MainProvider>(context, listen: false).IsLogged(true);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();

        final msg = jsonDecode(r)["message"] ?? "";
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
    } else {
      if (!onlogin) {
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
        final r =jsonDecode (await register(usarName.text, password.text, email.text));
        
        if (r["success"] == true) {
          
          // ignore: use_build_context_synchronously
          Provider.of<MainProvider>(context, listen: false).IsLogged(true);
           // ignore: use_build_context_synchronously
           Navigator.of(context).pop();
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
                    ))
                  ],
                );
              });
        }
      }
    }
  }
}
