import 'package:mobx/mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/services/auth.dart';

part 'auth.g.dart';

class Auth = _Auth with _$Auth;

abstract class _Auth with Store {
  AuthService authService;

  @observable
  String token;

  @action
  Future<void> login(String email, String password) async {
    try {
      authService = locator<AuthService>();

      final result = await authService.authenticate(email, password);
      token = result['accessToken'];
    } catch (e) {
      throw e;
    }
  }
}
