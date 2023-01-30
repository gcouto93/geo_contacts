import 'package:flutter/cupertino.dart';

import '../services/i_auth_provider.dart';

class AuthProvider with ChangeNotifier implements IAuthProvider {
  String? _emailUser ;

  String? get emailUser {
    return _emailUser;
  }

  Future<void> loginAuthProvider(String emailParam) async {
    _emailUser = emailParam;
    notifyListeners();
  }

}