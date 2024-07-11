import 'dart:convert';

import 'package:iotapp/API/urlAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Checklocations {
  Future isthereAsavedLocation() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString("LOCATION") ?? "";

    return data.isEmpty ? false : true;
  }

  Future getLocations() async {
    final prefs = await SharedPreferences.getInstance();

    final token = await prefs.getString("TOKEN") ?? "";
    print(token);
    final response = await http.get(
      Uri.parse("$APIurl/locations"),
      headers: {
        "Accept": "application/json",
        "Cookie": "access_token=$token",
      },
    );
    print(response.body);
    return response.body;
  }

  Future getLocation() async {
    final prefs = await SharedPreferences.getInstance();

    final token = await prefs.getString("TOKEN") ?? "";
    print(token);
    final response = await http.get(
      Uri.parse("$APIurl/locations/"),
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
      Uri.parse("$APIurl/locations/devices"),
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
      Uri.parse("$APIurl/locations/33c30af4-22a0-4c85-b514-9a0e322c92a1/1"),
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
    final response = await http.post(
      Uri.parse("$APIurl/locations"),
      headers: {
        "Content-Type": "application/json",
        "Cookie": "access_token=$token"
      },
      body: json.encode({
        "name": name,
      }),
    );
    return response.body;
  }

  Future attachNewDevice(String id, String deviceId) async {
    final prefs = await SharedPreferences.getInstance();

    final token = await prefs.getString("TOKEN") ?? "";
    final response = await http.post(
      Uri.parse("$APIurl/locations/$id/$deviceId"),
      headers: {
        "Content-Type": "application/json",
        "Cookie": "access_token=$token"
      },
    //  body: json.encode({"id": id, "connectedDevicesId": deviceId}),
    );

    print(response.body);
    return response.body;
  }
}
