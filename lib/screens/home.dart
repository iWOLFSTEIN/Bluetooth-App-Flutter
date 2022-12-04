import 'package:bluetooth_app/screens/paired_devices.dart';
import 'package:bluetooth_app/screens/scan_devices.dart';
import 'package:bluetooth_app/widgets/custom_alert_dialogues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/permissions.dart';
import '../widgets/bluetooth_icon.dart';
import '../widgets/tapable_list_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool toggleValue = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permissionEnabled();
  }

  permissionEnabled() async {
    var isBluetoothEnabled = await getPermission(Permission.bluetoothConnect);
    setState(() {
      toggleValue = isBluetoothEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        color: const Color(0xFFB9E1DA).withOpacity(0.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: const [
                Text(
                  'Bluetooth Auto Pair',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 35,
                ),
                BluetoothIcon(),
              ],
            ),
            toggleButton(),
            Column(
              children: [
                TapableListItem(
                  imageAdress: 'images/paired.png',
                  title: 'Paired Devices',
                  action: () {
                    if (toggleValue) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PairedDevices()));
                    } else {
                      showCustomAlertDialogue();
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TapableListItem(
                  imageAdress: 'images/scan.png',
                  title: 'Scan for Devices',
                  action: () {
                    if (toggleValue) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScanDevices()));
                    } else {
                      showCustomAlertDialogue();
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TapableListItem(
                  imageAdress: 'images/history.png',
                  title: 'History',
                  action: () {},
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  Widget toggleButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: 65,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF9ED5FA).withOpacity(0.3)),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            const Text(
              'Bluetooth',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Expanded(child: Container()),
            FlutterSwitch(
                toggleSize: 22.5,
                value: toggleValue,
                width: 52.5,
                inactiveColor: const Color(0xFF1F1F1F).withOpacity(0.4),
                onToggle: (value) async {
                  if (value) {
                    await getPermission(Permission.bluetoothConnect);
                  } else {
                    await disableBluetooth();
                  }
                  setState(() {
                    toggleValue = value;
                  });
                }),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }

  showCustomAlertDialogue() {
    var alert = CustomAlertDialogue(
      title: 'Bluetooth is not enabled!',
      subtitle: 'Please enable the bluetooth to perform this operation',
      actionTitle: 'Okay',
      action: () => Navigator.pop(context),
    );
    showDialog(context: context, builder: (context) => alert);
  }
}
