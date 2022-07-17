import 'package:bit_socket_flutter2/channel.dart';

class wshello {
  String type = '';
  List<channel> channels = [];

  wshello(this.type, this.channels);

  @override
  String toString() {
    return 'type = $type, channels = $channels ';
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'channels': channels,
    };
  }
}
