import 'package:bluetooth_app/utils/permissions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/tapable_list_item.dart';

class PairedDevices extends StatefulWidget {
  const PairedDevices({super.key});

  @override
  State<PairedDevices> createState() => _PairedDevicesState();
}

class _PairedDevicesState extends State<PairedDevices> {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  List bluetoothDevices = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchPairedDevices();
  }

  searchPairedDevices() async {
    var connectedDevicesList = await bluetooth.getBondedDevices();
    for (var device in connectedDevicesList) {
      setState(() {
        bluetoothDevices.add({
          'device': device,
          'name': device.name,
          'mac': device.address,
        });
      });
    }
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
              await bluetooth
                  .removeDeviceBondWithAddress(bluetoothDevices[i]['mac']);
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
          'Paired Devices',
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
        child: (listEquals(bluetoothDevices, []))
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
