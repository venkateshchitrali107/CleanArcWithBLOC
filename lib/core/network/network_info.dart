import 'dart:async';
import 'dart:core';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  ConnectivityResult get isConnected;
  updateConnectionStatus(ConnectivityResult result);
}

class NetworkInfoImpl implements NetworkInfo {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late Connectivity connectivity;
  final _onStreamController = StreamController<ConnectivityResult>();
  Stream<ConnectivityResult> get onNewDataStream =>
      _onStreamController.stream.asBroadcastStream();
  set updateConnection(ConnectivityResult update) {
    _connectionStatus = update;
  }

  NetworkInfoImpl() {
    connectivity = Connectivity()
      ..onConnectivityChanged.listen(
        updateConnectionStatus,
      );
  }

  checkForNetworkConnection() async {
    _connectionStatus = await connectivity.checkConnectivity();
  }

  @override
  ConnectivityResult get isConnected => _connectionStatus;

  @override
  updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus = result;
    _onStreamController.add(result);
  }
}
