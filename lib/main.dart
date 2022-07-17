import 'dart:convert';
import 'dart:io';

import 'package:bit_socket_flutter2/channel.dart';
import 'package:bit_socket_flutter2/constants.dart';
import 'package:bit_socket_flutter2/wshello.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String strPrice = '0.0';
  DateFormat formatter = DateFormat('Hms');
  String strTime = '00.00.00';

  @override
  Widget build(BuildContext context) {
    strTime = formatter.format(DateTime.now().toLocal());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bit WebSocket'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'BTC-USD',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Time: $strTime ',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Price: $strPrice ',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    List<String> strbtc = [];
    strbtc.add('BTC-USD');
    // strbtc.add('BTC-EUR');

    channel ch1 = channel('ticker', strbtc);
    List<channel> chArray = [];
    chArray.add(ch1);
    wshello wshello1 = wshello('subscribe', chArray);

    try {
      String json = jsonEncode(wshello1);
      print(json);

      final channel = IOWebSocketChannel.connect(url);
      channel.sink.add(json);

      channel.stream.listen((message) {
        print(message);
        strTime = formatter.format(DateTime.now().toLocal());
        try {
          //  It doesn't work without this stuff
          dynamic dynValue = jsonDecode(message);
          String strType = dynValue['type'];

          if (strType == 'ticker') {
            setState(() {
              strPrice = dynValue['price'];
            });
          }
        } catch (e) {
          print('Error2 = $e');
        }
        //   sleep(Duration(seconds: 5));
      });
    } catch (e) {
      print('Error1 = $e ');
    }

    super.initState();
  }
}
