import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iotapp/API/firebasePushNotfications.dart';
import 'package:iotapp/API/urlAPI.dart';
import 'package:iotapp/provider/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String url = APIurl;
const String MAINURL = APIurl;
Future getToken()async{
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString("TOKEN") ?? "";
}
Future loginwithToken(var context) async {
  

  final token =await getToken();
 
  if (token == "") {
    return false;
  }
  final response = await http.get(
    Uri.parse("$url/user"),
    headers: {"Accept": "application/json", "Cookie": "access_token=$token"},
  );

  if (response.statusCode == 200) {
    Provider.of<MainProvider>(context, listen: false).IsLogged(true);
    // return jsonDecode(response.body)["success"];
  } else {
    return false;
  }
}

Future login(String username, String password) async {
  String notfToken = await FirebasePushNotfications().initNotf();
  final response = await http.post(
    Uri.parse("$url/auth/login/"),
    headers: {"Content-Type": "application/json"},
    body: json
        .encode({"email": username, "password": password, "token": notfToken}),
  );
  //sdfygamer@gmail.com
  //123123123asdasd

  if (response.statusCode == 200) {
    final prefs = await SharedPreferences.getInstance();

    final token = jsonDecode(response.body)["accessToken"];

    await prefs.setString("TOKEN", token);

    return response.body;
  } else {
    return response.body;
  }
}

Future register(String username, String password, String email) async {
    String notfToken = await FirebasePushNotfications().initNotf();

  final response = await http.post(Uri.parse("$url/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
          {"username": username, "email": email, "password": password,"token": notfToken}));
  
  if (response.statusCode == 200) {
    final prefs = await SharedPreferences.getInstance();

    final token = jsonDecode(response.body)["accessToken"];

    await prefs.setString("TOKEN", token);
    return response.body;
  } else {
    return response.body;
  }
}
