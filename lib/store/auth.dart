import 'package:mobx/mobx.dart';
import 'package:parking_flutter/locator.dart';
import 'package:parking_flutter/services/auth.dart';

part 'auth.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  AuthService authService = locator<AuthService>();

  @observable
  String token;

  @action
  Future<void> login(String email, String password) async {
    try {
      final result = await authService.authenticate(email, password);
      token = result['accessToken'];
    } catch (e) {
      throw e;
    }
  }
}
