import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivitySingelton {
  static late Connectivity connectivty;

  static getInstnce() {
    connectivty = Connectivity();
  }

  static Future<ConnectivityResult> checkInternet() async {
    return connectivty.checkConnectivity();
  }
}
