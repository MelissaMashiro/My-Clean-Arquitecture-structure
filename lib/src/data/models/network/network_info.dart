import 'package:clean_arquitecture_project/src/domain/entities/no_internet_exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectionChecker;

  NetworkInfoImpl(this._connectionChecker);
  @override
  Future<bool> get isConnected async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectionChecker.checkConnectivity();
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        return true;
      }
    } on NoInternetException catch (e) {
      throw Exception(e.toString());
    }

    return false;
  }
}
