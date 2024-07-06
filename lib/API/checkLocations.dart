import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Checklocations {
  Future isthereAsavedLocation() async {
    final prefs = await SharedPreferences.getInstance();

    final data = await prefs.getString("LOCATION") ?? "";

    return data.isEmpty ? false : true;
  }

  Future getLocations() async {
    final prefs = await SharedPreferences.getInstance();

    final token = await prefs.getString("TOKEN") ?? "";

    final response = await http.get(
      Uri.parse("http://46.101.128.142:5050/locations"),
      headers: {
        "Accept": "application/json",
        "Cookie": "access_token=$token",
      },
    );
    print(response.body);
    return response.body;
  }

  Future getAllDevices() async {
    final prefs = await SharedPreferences.getInstance();

    final token = await prefs.getString("TOKEN") ?? "";

    final response = await http.get(
      Uri.parse("http://46.101.128.142:5050/locations/devices"),
      headers: {
        "Accept": "application/json",
        "Cookie": "access_token=$token",
      },
    );
    print(response.body);
    return json.decode(response.body);
  }

  Future getData() async {
    final prefs = await SharedPreferences.getInstance();

    final token = await prefs.getString("TOKEN") ?? "";

    final response = await http.get(
      Uri.parse(
          "http://46.101.128.142:5050/locations/33c30af4-22a0-4c85-b514-9a0e322c92a1/1"),
      headers: {
        "Accept": "application/json",
        "Cookie": "access_token=$token",
      },
    );
    print(response.body);
    return json.decode(response.body);
  }

  Future setNewLoc(String name) async {
    final prefs = await SharedPreferences.getInstance();

    final token = await prefs.getString("TOKEN") ?? "";
    print(token);
    print(name);
    final response = await http.post(
      Uri.parse("http://46.101.128.142:5050/locations"),
      headers: {
        "Content-Type": "application/json",
        "Cookie": "access_token=$token"
      },
      body: json.encode({
        "name": name,
      }),
    );
    //sdfygamer@gmail.com
    //123123123asdasd
    print("____");
    print(response.body);
    return response.body;
  }

  Future attachNewDevice(String id, String deviceId) async {
    final prefs = await SharedPreferences.getInstance();

    final token = await prefs.getString("TOKEN") ?? "";
    final response = await http.post(
      Uri.parse("http://46.101.128.142:5050/locations/:id/:connectedDevicesId"),
      headers: {
        "Content-Type": "application/json",
        "Cookie": "access_token=$token"
      },
      body: json.encode({"id": id, "connectedDevicesId": deviceId}),
    );
   
    print(response.body);
    return response.body;
  }
}
