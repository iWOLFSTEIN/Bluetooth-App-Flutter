import 'package:flutter/material.dart';

class BluetoothIcon extends StatelessWidget {
  const BluetoothIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 13, color: const Color(0xFF0291F7).withOpacity(0.2)),
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 13, color: const Color(0xFF0291F7).withOpacity(0.4)),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'images/bluetooth.png',
          height: 140,
        ),
      ),
    );
  }
}
