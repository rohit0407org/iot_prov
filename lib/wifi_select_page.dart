import 'package:esp_provisioning_wifi/esp_provisioning_bloc.dart';
import 'package:esp_provisioning_wifi/esp_provisioning_event.dart';
import 'package:esp_provisioning_wifi/esp_provisioning_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_provisioning/success_page.dart';


class WifiSelectPage extends StatefulWidget {
  const WifiSelectPage({super.key});

  @override
  State<WifiSelectPage> createState() => _WifiSelectPageState();
}

class _WifiSelectPageState extends State<WifiSelectPage> {
  final passphraseController = TextEditingController();
  final ssidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Wi-Fi Network',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "To Complete setup of your device, PROV_123 please provide your Home Network's credentials",
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Networks",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Icon(
                  Icons.refresh_outlined,
                  color: Colors.black,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder<EspProvisioningBloc, EspProvisioningState>(
                builder: (context, state) {
                  if (state.wifiNetworks.isEmpty) {
                    return GestureDetector(
                        onTap: () {
                          _openModal(context, ssidController, passphraseController, state);
                        },
                        child: const Text(
                          "Join Other Network",
                          style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                        ));
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {

                      return GestureDetector(
                        onTap: () {
                          ssidController.text =
                              state.wifiNetworks[index].toString();
                          _openModal(context, ssidController, passphraseController, state,);
                        },
                        child: Container(
                            height: 50,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                                child: Text(
                                  state.wifiNetworks[index],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))),
                      );
                    },
                    itemCount: state.wifiNetworks.length,
                  );
                }),
          ),
        ],
      ),
    );
  }

  void _openModal(BuildContext context, TextEditingController ssidController,
      TextEditingController passphraseController, EspProvisioningState state) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: ssidController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Wi-Fi SSID',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passphraseController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Enter Wi-Fi Password',
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: (){
                    context.read<EspProvisioningBloc>().add(
                      EspProvisioningEventWifiSelected(
                        state.bluetoothDevice,
                        'abcd1234',
                        ssidController.text.toString(),
                        passphraseController.text,
                      ),
                    );
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SuccessPage()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                        child: Text(
                          "Provision Device",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
          );
        });
  }

}
