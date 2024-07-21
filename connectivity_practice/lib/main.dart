import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ConnectivityResult> connectivityResult = <ConnectivityResult>[
    ConnectivityResult.none
  ];
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _initConnection();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  Future<void> _initConnection() async {
    late List<ConnectivityResult> result;

    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      connectivityResult = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $connectivityResult');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Connectivity Plus Example'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(flex: 2),
            Text(
              'Active connection types:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Spacer(),
            ListView(
              shrinkWrap: true,
              children: List.generate(
                connectivityResult.length,
                (index) => Center(
                  child: Text(
                    connectivityResult[index].toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
