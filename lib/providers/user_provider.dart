import 'package:flutter/cupertino.dart';
import 'package:movie_searching/services/sql_helper.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  final SqlHelper _sqlHelper = SqlHelper.instance;
  User? _user;

  User? get user => _user;

  void signup(User user) async {
    var rowId = await _sqlHelper.insertUser(user);

    if (rowId != null) {
      notifyListeners();
    }
  }

  bool logout() {
    _user = null;

    if (_user == null) {
      return true;
    }

    return false;
  }

  Future<User?> login(String email, String password) async {
    User? user = await _sqlHelper.login(email, password);

    if (user != null) {
      _user = user;
      notifyListeners();
      return user;
    }
    return null;
  }
}