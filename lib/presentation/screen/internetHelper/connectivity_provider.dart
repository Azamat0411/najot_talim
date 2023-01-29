import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class ConnectivityProvider extends ChangeNotifier {

  static final _ = ConnectivityProvider._i();
  factory ConnectivityProvider(){
    return _..startMonitoring();
  }
  ConnectivityProvider._i();


  final _connectivity = Connectivity();

  bool _isOnline = true;

  bool get isOnline => _isOnline;

  startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        await _update().then((bool isConnected){
          _isOnline = isConnected;
          notifyListeners();
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  Future<bool> _update()async{
    bool isConnected = false;
    try{
      final List<InternetAddress> result = await InternetAddress.lookup('google.com');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        isConnected = true;
      }
    }on SocketException catch(_){
      isConnected = false;
    }
    return isConnected;
  }
}
