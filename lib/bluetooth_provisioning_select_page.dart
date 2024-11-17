import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esp_provisioning_wifi/esp_provisioning_bloc.dart';
import 'package:esp_provisioning_wifi/esp_provisioning_event.dart';
import 'package:esp_provisioning_wifi/esp_provisioning_state.dart';
import 'package:iot_provisioning/wifi_select_page.dart';


class BluetoothProvisioningSelectPage extends StatefulWidget {
  const BluetoothProvisioningSelectPage({super.key});

  @override
  State<BluetoothProvisioningSelectPage> createState() =>
      _BluetoothProvisioningSelectPageState();
}

class _BluetoothProvisioningSelectPageState
    extends State<BluetoothProvisioningSelectPage> {
  final TextEditingController prefixController =
  TextEditingController(text: 'PROV_');
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Automatically start scanning for Bluetooth devices on page load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScanning();
    });
  }

  @override
  void dispose() {
    prefixController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _startScanning() {
    // Trigger Bluetooth scan with the current prefix
    final prefix = prefixController.text.trim();
    context.read<EspProvisioningBloc>().add(EspProvisioningEventStart(prefix));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Scanning for devices with prefix: $prefix...')),
    );
  }

  void _onSavePrefix() {
    // Save the new prefix value and restart scanning
    final updatedPrefix = prefixController.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Prefix updated to: $updatedPrefix')),
    );

    // Restart scanning with the updated prefix
    _startScanning();

    // Optionally, unfocus the TextField
    focusNode.unfocus();
  }

  void _onRescan() {
    // Trigger rescan for Bluetooth devices
    _startScanning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Connect to Device",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  "Prefix: ",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: TextField(
                    controller: prefixController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                    onSubmitted: (_) => _onSavePrefix(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _onSavePrefix,
                  child: const Text("SAVE"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "To provision your new device, please make sure that your Phone's Bluetooth is turned on and within range of your new device.",
              style: TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<EspProvisioningBloc, EspProvisioningState>(
              builder: (context, state) {
                if (state.bluetoothDevices.isEmpty) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: _onRescan,
                      child: const Text("Scan Again"),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.bluetoothDevices.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(state.bluetoothDevices[i]),
                      onTap: () {
                        context.read<EspProvisioningBloc>().add(
                            // EspProvisioningEventBleSelected(
                            //     state.bluetoothDevices[i], 'abcd1234')
                            EspProvisioningEventBleSelected(
                                state.bluetoothDevices[i], 'abcd1234')
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WifiSelectPage()  ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
