// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BluetoothDeviceList(),
    );
  }
}

class BluetoothDeviceList extends StatefulWidget {
  const BluetoothDeviceList({super.key});

  @override
  _BluetoothDeviceListState createState() => _BluetoothDeviceListState();
}

class _BluetoothDeviceListState extends State<BluetoothDeviceList> {
  final List<BluetoothDevice> _devicesList = [];

  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance.requestEnable();
    _startDiscovery();
  }

  void _startDiscovery() {
    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        _devicesList.add(r.device);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Devices'),
      ),
      body: ListView.builder(
        itemCount: _devicesList.length,
        itemBuilder: (BuildContext context, int index) {
          BluetoothDevice device = _devicesList[index];
          return ListTile(
            title: Text(device.name ?? "Unknown device"),
            subtitle: Text(device.address.toString()),
          );
        },
      ),
    );
  }
}