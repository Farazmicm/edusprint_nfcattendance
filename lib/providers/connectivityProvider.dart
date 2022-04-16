import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityProvider extends ChangeNotifier {
  late bool _isOnline;

  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    _isOnline = true;
    Connectivity _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((connectionResult) {
      if (connectionResult == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    });
  }
}
