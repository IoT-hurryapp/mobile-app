import 'dart:convert';
import 'package:iotapp/API/authstuff.dart';
import 'package:iotapp/provider/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? _socket;
  SocketService(var context){
    try{
      dispose();
    }finally{
      connect(context);
    }
    
  }
  void connect(var context) async {
    final token = await getToken();
    

    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString("LOCATION") ?? "{data:["","","",""]}";
   
    final id = jsonDecode(data)["data"][2]??"";
    print(id);
    _socket = IO.io('http://206.81.29.27:2020/devices/$id', <String, dynamic>{
      'transports': ['websocket'],
      'auth': {"token": token}
    });

    _socket!.on('connect', (_) {
      print('Connected to the server');
    });

    _socket!.on('disconnect', (_) {
      print('Disconnected from the server');
    });

    _socket!.on("data", (data) {
      // print(data);
      Provider.of<MainProvider>(context, listen: false).updateData(
          data["temperatureC"],
          data["humidity"],
          data["dustPercentage"],
          data["AQI"]);
    });
  }
 

  void disconnect() {
    _socket?.disconnect();
  }

  // Dispose method
  void dispose() {
    disconnect();
    _socket?.destroy();
    print('Socket Service disposed and socket disconnected');
  }
}
