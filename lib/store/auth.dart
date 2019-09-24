import 'package:mobx/mobx.dart';
import 'package:parking_flutter/services/auth.dart';

part 'auth.g.dart';

class Auth = _Auth with _$Auth;

abstract class _Auth with Store {
  @observable
  String token;

  @action
  Future<void> login(String email, String password) async {
    try {
      final result = await AuthService().authenticate(email, password);
      token = result['accessToken'];
    } catch (e) {
      throw e;
    }
  }
}
