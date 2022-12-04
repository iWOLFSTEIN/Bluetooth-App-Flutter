import 'package:bluetooth_app/utils/permissions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/tapable_list_item.dart';

class ScanDevices extends StatefulWidget {
  const ScanDevices({super.key});

  @override
  State<ScanDevices> createState() => _ScanDevicesState();
}

class _ScanDevicesState extends State<ScanDevices> {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  List bluetoothDevices = [];
  bool isScanning = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scanBluetoothDevices();
  }

  scanBluetoothDevices() {
    bluetooth.startDiscovery().listen(
      (event) {
        setState(() {
          bluetoothDevices.add({
            'device': event.device,
            'name': event.device.name,
            'mac': event.device.address,
          });
        });
      },
      onDone: () {
        setState(() {
          isScanning = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> itemsList = [
      const SizedBox(
        height: 5,
      ),
      for (var i = 0; i < bluetoothDevices.length; i++)
        TapableModifiedListItem(
          imageAdress: 'images/device.png',
          title: bluetoothDevices[i]['name'],
          subtitle: bluetoothDevices[i]['mac'],
          buttonAction: () async {
            try {
              await bluetooth.connect(bluetoothDevices[i]['device']);
              setState(() {
                bluetoothDevices.removeAt(i);
              });
            } catch (e) {
              print(e.toString());
            }
          },
          buttonTitle:
              (bluetoothDevices[i]['device'].isConnected) ? 'paired' : 'Pair',
        ),
      const SizedBox(
        height: 5,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          'Scan Devices',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              child: const Icon(
                Icons.share,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xFFB9E1DA).withOpacity(0.4),
        child: (isScanning && listEquals(bluetoothDevices, []))
            ? Center(
                child: Text(
                  'Scanning...',
                  style: TextStyle(color: Colors.black.withOpacity(0.4)),
                ),
              )
            : (!isScanning && listEquals(bluetoothDevices, []))
                ? Center(
                    child: Text(
                      'No device available',
                      style: TextStyle(color: Colors.black.withOpacity(0.4)),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                    children: itemsList,
                  )),
      )),
    );
  }
}
