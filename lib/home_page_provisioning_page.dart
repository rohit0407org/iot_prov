// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
//
// import 'bluetooth_provisioning_select_page.dart';
//
// class HomePageProvisionDevice extends StatefulWidget {
//   const HomePageProvisionDevice({super.key});
//
//   @override
//   HomePageProvisionDeviceState createState() =>
//       HomePageProvisionDeviceState();
// }
//
// class HomePageProvisionDeviceState extends State<HomePageProvisionDevice> {
//   // Function to enable Bluetooth and request permissions
//   Future<void> _enableBluetoothAndRequestPermissions() async {
//     // First, attempt to enable Bluetooth
//     await _enableBluetooth();
//
//     // Request necessary permissions after enabling Bluetooth
//     await [
//       Permission.location,
//       Permission.locationWhenInUse,
//     ].request();
//
//     // Check if permissions are granted
//     if (await Permission.location.isGranted &&
//         await Permission.locationWhenInUse.isGranted) {
//
//       Navigator.push(
//         // ignore: use_build_context_synchronously
//         context,
//         MaterialPageRoute(
//           builder: (context) => const BluetoothProvisioningSelectPage(),
//         ),
//       );
//     } else {
//       // Show a snackbar if permissions are not granted
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please grant all permissions to proceed.'),
//         ),
//       );
//     }
//   }
//
//   // // Function to enable Bluetooth
//   // Future<void> _enableBluetooth() async {
//   //   final isBluetoothOn = await FlutterBluePlus.isOn;
//   //   if (!isBluetoothOn) {
//   //     await FlutterBluePlus.turnOn(); // Enable Bluetooth
//   //   }
//   // }
//   // Function to enable Bluetooth
//   Future<void> _enableBluetooth() async {
//     final bluetoothState = await FlutterBluePlus.adapterState.first;
//     if (bluetoothState != BluetoothAdapterState.on) {
//       await FlutterBluePlus.turnOn(); // Enable Bluetooth
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'ESP BLE Prov',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           backgroundColor: Colors.deepPurple,
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () async {
//                   // Handle permissions and Bluetooth enabling when button is clicked
//                   await _enableBluetoothAndRequestPermissions();
//                 },
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   margin: const EdgeInsets.symmetric(horizontal: 22),
//                   decoration: BoxDecoration(
//                     color: Colors.deepPurple,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       "Provision New Device",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'bluetooth_provisioning_select_page.dart';

class HomePageProvisionDevice extends StatefulWidget {
  const HomePageProvisionDevice({super.key});

  @override
  HomePageProvisionDeviceState createState() =>
      HomePageProvisionDeviceState();
}

class HomePageProvisionDeviceState extends State<HomePageProvisionDevice> {
  // Function to enable Bluetooth and request permissions
  Future<void> _enableBluetoothAndRequestPermissions() async {
    // First, attempt to enable Bluetooth
    await _enableBluetooth();

    // Request necessary permissions after enabling Bluetooth
    await [
      Permission.location,
      Permission.locationWhenInUse,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.nearbyWifiDevices,

    ].request();

    // Check if permissions are granted
    if (await Permission.location.isGranted &&
        await Permission.locationWhenInUse.isGranted &&
        await Permission.nearbyWifiDevices.isGranted ) {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const BluetoothProvisioningSelectPage(),
        ),
      );
    } else {
      // Show a snackbar if permissions are not granted
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please grant all permissions to proceed.'),
        ),
      );
    }
  }

  // Function to enable Bluetooth
  Future<void> _enableBluetooth() async {
    final bluetoothState = await FlutterBluePlus.adapterState.first;
    if (bluetoothState != BluetoothAdapterState.on) {
      await FlutterBluePlus.turnOn(); // Enable Bluetooth
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ESP BLE Prov',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  // Handle permissions and Bluetooth enabling when button is clicked
                  await _enableBluetoothAndRequestPermissions();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 22),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Provision New Device",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
