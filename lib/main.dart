import 'package:esp_provisioning_wifi/esp_provisioning_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page_provisioning_page.dart';







void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EspProvisioningBloc(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePageProvisionDevice()
      ),
    );
  }
}
