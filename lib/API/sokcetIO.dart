import 'package:iotapp/provider/MainProvider.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketService {
  IO.Socket? _socket;
 
  void connect(var context) {
    _socket = IO.io('http://46.101.128.142:2020', <String, dynamic>{
      'transports': ['websocket'],
    });

    _socket!.on('connect', (_) {
      print('Connected to the server');
    });

    _socket!.on('disconnect', (_) {
      print('Disconnected from the server');
    });

    // Listen for custom events
    _socket!.on('data-1', (data) {
      Provider.of<MainProvider>(context, listen: false).updateData(
          data["temperature_c"],
          data["humidity"],
          data["dust_concentration"],
          data["mq135_value"]);

      //(int.parse(data["temperature_c"])),int.parse(data["humidity"]), int.parse(data["dust_concentration"]), int.parse(data["mq135_value"])
     // print('Received custom event: $data');
    });
  }

  void disconnect() {
    _socket?.disconnect();
  }
}
