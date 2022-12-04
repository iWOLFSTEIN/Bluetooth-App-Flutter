import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
getPermission(Permission permission) async {
  var myPermission = await permission.request();
  if (myPermission.isGranted && permission == Permission.bluetoothConnect) {
    var isBluetoothEnabled = await bluetooth.requestEnable();
    if (isBluetoothEnabled != null) {
      return isBluetoothEnabled;
    }
  } else if (myPermission.isDenied) {
    getPermission(permission);
  } else if (myPermission.isPermanentlyDenied) {
    openAppSettings();
  }
}

disableBluetooth() async {
  var checkBluetoothStatus = await bluetooth.isEnabled;
  if (checkBluetoothStatus != null) {
    if (checkBluetoothStatus) {
      var isBluetoothEnabled = await bluetooth.requestDisable();
      if (isBluetoothEnabled != null) {
        return isBluetoothEnabled;
      }
    }
  }
}
