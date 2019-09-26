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
  Future<dynamic> login(String email, String password) async {
    try {
      final result = await authService.authenticate(email, password);
      token = result['accessToken'];
      return result;
    } catch (e) {
      print('3');
      throw e;
    }
  }

  // @action
  // Future<dynamic> socialLogin(String provider) async {
  //   try {
  //     final result = await authService.googleLogin();
  //     token = result['accessToken'];
  //   } catch (e) {
  //     print('4');
  //     throw e;
  //   }
  // }
}
